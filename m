From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Jun 2010 10:57:03 +0300
Subject: [PATCH 2/2] arm: Make VFPv3 usable on ARMv6
In-Reply-To: <20100622132037.GV12255@atomide.com>
References: <20100621135125.24299.91290.stgit@baageli.muru.com>
	<1277211592.29532.20.camel@e102109-lin.cambridge.arm.com>
	<20100622132037.GV12255@atomide.com>
Message-ID: <20100623075703.GB12255@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100622 16:15]:
> * Catalin Marinas <catalin.marinas@arm.com> [100622 15:53]:
> > On Mon, 2010-06-21 at 14:51 +0100, Tony Lindgren wrote:
> > > diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> > > index 315a540..19ba626 100644
> > > --- a/arch/arm/vfp/vfpmodule.c
> > > +++ b/arch/arm/vfp/vfpmodule.c
> > > @@ -549,10 +549,14 @@ static int __init vfp_init(void)
> > >                 /*
> > >                  * Check for the presence of the Advanced SIMD
> > >                  * load/store instructions, integer and single
> > > -                * precision floating point operations.
> > > +                * precision floating point operations. Only check
> > > +                * for NEON if the hardware has TLS register as the
> > > +                * MVFR registers got added in ARM1136 r1p0 with TLS.
> > >                  */
> > > -               if ((fmrx(MVFR1) & 0x000fff00) == 0x00011100)
> > > -                       elf_hwcap |= HWCAP_NEON;
> > > +               if (elf_hwcap & HWCAP_TLS) {
> > > +                       if ((fmrx(MVFR1) & 0x000fff00) == 0x00011100)
> > > +                               elf_hwcap |= HWCAP_NEON;
> > > +               }
> > 
> > MVFR should be available with the new CPU id format:
> > 
> > 	((read_cpuid_id() & 0x000f0000) == 0x000f0000)
> > 
> > I think that would be a cleaner test than relying on the TLS presence.
> 
> OK, thanks that's better. Will update accordingly and repost.

Here's this one updated. Using your better MVFR check also removes the
dependency to the previous patch.

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: vfpv3-armv6-fix.patch
Type: text/x-diff
Size: 3323 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100623/75317dfe/attachment.bin>
