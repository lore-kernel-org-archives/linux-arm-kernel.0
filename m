From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Feb 2018 17:25:18 +0000
Subject: [RFC PATCH v3 2/3] arm64/kernel: don't ban ADRP to work around
 Cortex-A53 erratum #843419
In-Reply-To: <CAKv+Gu_Jm9PDGj0uq2BwWLja7_FNekT=GyQ7OG50KZxuOj9xiA@mail.gmail.com>
References: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
 <20180214113645.16793-3-ard.biesheuvel@linaro.org>
 <20180223171551.qnpuf2rydyibztgt@lakrids.cambridge.arm.com>
 <CAKv+Gu_Jm9PDGj0uq2BwWLja7_FNekT=GyQ7OG50KZxuOj9xiA@mail.gmail.com>
Message-ID: <20180223172518.264ara42xj52ehao@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 05:17:31PM +0000, Ard Biesheuvel wrote:
> On 23 February 2018 at 17:15, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Feb 14, 2018 at 11:36:44AM +0000, Ard Biesheuvel wrote:
> >> +static bool reloc_adrp_erratum_843419(struct module *mod, __le32 *place,
> >> +                                   u64 val)
> >> +{
> >> +     if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419))
> >> +             return false;
> >> +
> >> +     /* only ADRP instructions at the end of a 4k page are affected */
> >> +     if (((u64)place & 0xfff) < 0xff8)
> >> +             return false;
> >> +
> >> +     /* patch ADRP to ADR if it is in range */
> >> +     if (!reloc_insn_imm(RELOC_OP_PREL, place, val & ~0xfff, 0, 21,
> >> +                         AARCH64_INSN_IMM_ADR)) {
> >> +             ((u8 *)place)[3] &= 0x7f; /* clear opcode bit 31 */
> >
> > That's a bit hideous, and broken for BE, I think.
> 
> Instructions are always LE

Ugh; I forgot that single didn't have endianness. :(

> > Can we not construct the equivalent ADR using the usual insn code, and
> > insert it?
> 
> Sure.

Cheers!

Mark.
