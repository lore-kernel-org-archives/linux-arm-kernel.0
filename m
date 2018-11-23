From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 23 Nov 2018 17:24:13 +0100
Subject: [PATCH 2/2] arm64/module: switch to ADRP/ADD sequences for PLT
 entries
In-Reply-To: <20181123161135.GA370@lst.de>
References: <20181122084646.3247-1-ard.biesheuvel@linaro.org>
 <20181122084646.3247-3-ard.biesheuvel@linaro.org>
 <20181123161135.GA370@lst.de>
Message-ID: <CAKv+Gu93dgDSapVva0HxTssSf+zT22VmiJhby25sHMz4fZpdpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Nov 2018 at 17:12, Torsten Duwe <duwe@lst.de> wrote:
>
> On Thu, Nov 22, 2018 at 09:46:46AM +0100, Ard Biesheuvel wrote:
> > Now that we have switched to the small code model entirely, and
> > reduced the extended KASLR range to 4 GB, we can be sure that the
> > targets of relative branches that are out of range are in range
> > for a ADRP/ADD pair, which is one instruction shorter than our
> > current MOVN/MOVK/MOVK sequence, and is more idiomatic and so it
> > is more likely to be implemented efficiently by micro-architectures.
> >
> > So switch over the ordinary PLT code and the special handling of
> > the Cortex-A53 ADRP errata, as well as the ftrace trampline
> > handling.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Generally, an ACK by me, but...
>
> > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> > index f0690c2ca3e0..3c6e5f3a4973 100644
> > --- a/arch/arm64/kernel/module-plts.c
> > +++ b/arch/arm64/kernel/module-plts.c
> > @@ -11,6 +11,55 @@
> >  #include <linux/module.h>
> >  #include <linux/sort.h>
> >
> > +static struct plt_entry __get_adrp_add_pair(u64 dst, u64 pc,
> > +                                         enum aarch64_insn_register reg)
> > +{
> > +     u32 adrp, add;
> > +
> > +     adrp = aarch64_insn_gen_adr(pc, dst, reg, AARCH64_INSN_ADR_TYPE_ADRP);
> > +     add = aarch64_insn_gen_add_sub_imm(reg, reg, dst % SZ_4K,
> > +                                        AARCH64_INSN_VARIANT_64BIT,
> > +                                        AARCH64_INSN_ADSB_ADD);
> > +
> > +     return (struct plt_entry){ cpu_to_le32(adrp), cpu_to_le32(add) };
> > +}
>
> Will __get_adrp_add_pair get reused? Otherwise it would just be inlined
> below, but then again why is it returning a partial struct plt_entry?
>

Because it is used in two places: get_plt_entry() and
module_emit_veneer_for_adrp()

> > +struct plt_entry get_plt_entry(u64 dst, void *pc)
> > +{
> > +     struct plt_entry plt;
> > +     static u32 br;
>
> Well, _I_ would call this variable insn_br_x16...
>
> > +     if (!br)
> > +             br = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_16,
> > +                                              AARCH64_INSN_BRANCH_NOLINK);
> > +
> > +     plt = __get_adrp_add_pair(dst, (u64)pc, AARCH64_INSN_REG_16);
> > +     plt.br = cpu_to_le32(br);
> > +
> > +     return plt;
> > +}
>
> But I'm really lost with this one:
>
> > +bool plt_entries_equal(const struct plt_entry *a, const struct plt_entry *b)
> > +{
> > +     u64 p, q;
> > +
> > +     /*
> > +      * Check whether both entries refer to the same target:
> > +      * do the cheapest checks first.
> > +      */
> > +     if (a->add != b->add || a->br != b->br)
> > +             return false;
> > +
> > +     p = ALIGN_DOWN((u64)a, SZ_4K);
> > +     q = ALIGN_DOWN((u64)b, SZ_4K);
> > +
> > +     if (a->adrp == b->adrp && p == q)
> > +             return true;
> > +
> > +     return (p + aarch64_insn_adrp_get_offset(le32_to_cpu(a->adrp))) ==
> > +            (q + aarch64_insn_adrp_get_offset(le32_to_cpu(b->adrp)));
> > +}
>
> IIUC addr/addrp are PC-relative? So in order to tell whether they lead to
> the same destination, their location (a and b) must _fully_ been taken
> into account, not just some bits?
>

The criterion is whether they point to the same target.

So the reasoning is as follows:
- if the 'add' or 'br' opcodes are different, they are definitely not equal
- if the 'add' and 'br' opcodes are the same, the 'adrp' opcodes are
the same, and the adrp instructions reside in the same 4 KB sized/4 KB
aligned window, they must point to the same symbol
- otherwise, decode the instructions to see if they point to the same
symbol. Note that we already checked the 'add's so no need to check
them again.

> Also, plt entries residing at different locations might address the same
> target, but (a->add != b->add || a->br != b->br) would yield true
> despite that. Is this intended?
>

If they address the same target, the add will be the same. The br also
has to be the same because we cannot reuse an ordinary PLT as and ADRP
veneer or vice versa.
