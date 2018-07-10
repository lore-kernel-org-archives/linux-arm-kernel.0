From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Jul 2018 18:14:38 +0100
Subject: [PATCH net-next 13/13] ARM: net: bpf: use double-word
 load/stores where available
In-Reply-To: <CAOesGMio4JTzAPQ3Bkx8LxhkhJStzOGC6t2U8aC6m4TiBtaunQ@mail.gmail.com>
References: <20180710123340.GK17271@n2100.armlinux.org.uk>
 <E1fcrtG-0005Vh-DK@rmk-PC.armlinux.org.uk>
 <CAOesGMio4JTzAPQ3Bkx8LxhkhJStzOGC6t2U8aC6m4TiBtaunQ@mail.gmail.com>
Message-ID: <20180710171438.GM17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:03:33AM -0700, Olof Johansson wrote:
> Hi Russell,
> > @@ -663,13 +679,27 @@ static inline void emit_a32_mov_r(const s8 dst, const s8 src,
> >  static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
> >                                   const s8 src[],
> >                                   struct jit_ctx *ctx) {
> > -       emit_a32_mov_r(dst_lo, src_lo, ctx);
> > -       if (is64) {
> > +       if (!is64) {
> > +               emit_a32_mov_r(dst_lo, src_lo, ctx);
> > +               /* Zero out high 4 bytes */
> > +               emit_a32_mov_i(dst_hi, 0, ctx);
> > +       } else if (__LINUX_ARM_ARCH__ < 6 &&
> > +                  ctx->cpu_architecture < CPU_ARCH_ARMv5) {
> >                 /* complete 8 byte move */
> > +               emit_a32_mov_r(dst_lo, src_lo, ctx);
> >                 emit_a32_mov_r(dst_hi, src_hi, ctx);
> 
> 
> Tiny nit: Looks like you compare for >= ARMv5TE above and <ARMv5 here.

Good catch, I'll fix it, and it gives me some satisfaction that
someone is reviewing this JIT code closely!  IMHO, JITs need a lot
of scrutiny.

> I'm not aware of any vanilla v5 implementations (all I can find are
> v5TE or <=v4T), so it doesn't seem like something actually causing
> problems. Mostly pointing it out for consistency's sake.

They're rare - I think the only one is an ARM1020 (ARMv5T) as opposed
to the ARM1020E (ARMv5TE).  Whether any are in the wild or not is
another matter.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
