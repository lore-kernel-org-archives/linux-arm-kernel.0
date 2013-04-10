From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 10 Apr 2013 15:03:37 -0400 (EDT)
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410190052.GC18196@blackmetal.musicnaut.iki.fi>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304101307280.17375@syhkavp.arg>
 <20130410190052.GC18196@blackmetal.musicnaut.iki.fi>
Message-ID: <alpine.LFD.2.03.1304101502090.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Apr 2013, Aaro Koskinen wrote:

> On Wed, Apr 10, 2013 at 01:30:35PM -0400, Nicolas Pitre wrote:
> > On Wed, 10 Apr 2013, Russell King - ARM Linux wrote:
> > 
> > > I have just committed a patch to remove the arch/arm/nwfpe code from
> > > the kernel, and the VFP code emulating the FP operations.
> > > 
> > > This I have done after it has been brought to my attention by the OSADL's
> > > GPL-violations project that the license for the softfloat library is
> > > incompatible with GPLv2.  This is because the FSF have ruled that
> > > indemnification clauses consitute an "additional restriction" which is
> > > incompatible with the GPLv2 section 6.  NWFPE contains the softfloat
> > > library, and VFP's emulation code is a derivative of softfloat.
> > > 
> > > This will be very disruptive for ARMv4 and ARMv5 CPUs, which will no
> > > longer be able to run userspace with NWFPE support removed.  A possible
> > > solution there is to resurrect FASTFPE support and merge that into
> > > mainline in place of NWFPE.  FASTFPE's hooks are all present in the
> > > kernel, and it should just be a case of adding the FASTFPE code.
> > > However, FASTFPE is probably lacking GDB and signal stack support.
> > > (FastFPE's per-thread workspace is different from NWFPE.)
> > 
> > A point worth mentioning is the EABI availability since 2006 which moved 
> > away from FPA completely. A soft-float library in user space is used in 
> > that case.  Major ARM binary producers including all ARM distros moved 
> > to EABI with user space soft-float since then as it is order of 
> > magnitude faster than FPA emulation.  So 99.99% of ARMv4 and ARMv5 users 
> > are unlikely to be affected.
> 
> Menuconfig mentions under "Floating point emulation" that "At least one
> emulation must be selected". But if I compile my OS with EABI userspace
> soft-float I guess I won't actually need to select any emulation,
> or have I missed something? (I just checked my configs, and at least
> on Kirkwood/openrd I have been already running without any emulation,
> so I guess the help text is wrong?)

It is wrong in the EABI case.  This help text probably predates the 
introduction of EABI.


Nicolas
