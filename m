From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Sep 2011 11:10:44 -0400 (EDT)
Subject: [PATCH 2/6] ARM: zImage: Allow the appending of a device tree
	binary
In-Reply-To: <20110914142030.GF2104@arm.com>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
	<1315978906-15829-3-git-send-email-nico@fluxnic.net>
	<20110914133244.GE2104@arm.com>
	<alpine.LFD.2.00.1109140957000.20358@xanadu.home>
	<20110914142030.GF2104@arm.com>
Message-ID: <alpine.LFD.2.00.1109141056150.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Sep 2011, Dave Martin wrote:

> On Wed, Sep 14, 2011 at 10:04:28AM -0400, Nicolas Pitre wrote:
> > On Wed, 14 Sep 2011, Dave Martin wrote:
> > 
> > > On Wed, Sep 14, 2011 at 01:41:42AM -0400, Nicolas Pitre wrote:
> > > > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > > 
> > > > This patch provides the ability to boot using a device tree that is appended
> > > > to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> > > > 
> > > > Signed-off-by: John Bonesio <bones@secretlab.ca>
> > > > [nico: adjusted to latest zImage changes plus additional cleanups]
> > > > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > > > Acked-by: Tony Lindgren <tony@atomide.com>
> > > > ---
> > > >  arch/arm/Kconfig                |    8 ++++
> > > >  arch/arm/boot/compressed/head.S |   70 +++++++++++++++++++++++++++++++++++++--
> > > >  2 files changed, 75 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > index 5ebc5d922e..83323c2b1f 100644
> > > > --- a/arch/arm/Kconfig
> > > > +++ b/arch/arm/Kconfig
> > > > @@ -1781,6 +1781,14 @@ config ZBOOT_ROM_SH_MOBILE_SDHI
> > > >  
> > > >  endchoice
> > > >  
> > > > +config ARM_APPENDED_DTB
> > > > +	bool "Use appended device tree blob to zImage"
> > > > +	depends on OF && !ZBOOT_ROM
> > > > +	help
> > > > +	  With this option, the boot code will look for a device tree binary
> > > > +	  (dtb) appended to zImage
> > > > +	  (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> > > > +
> > > >  config CMDLINE
> > > >  	string "Default kernel command string"
> > > >  	default ""
> > > > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> > > > index e95a598960..3ce5738ddb 100644
> > > > --- a/arch/arm/boot/compressed/head.S
> > > > +++ b/arch/arm/boot/compressed/head.S
> > > > @@ -216,6 +216,59 @@ restart:	adr	r0, LC0
> > > >  		mov	r10, r6
> > > >  #endif
> > > >  
> > > > +		mov	r5, #0			@ init dtb size to 0
> > > > +#ifdef CONFIG_ARM_APPENDED_DTB
> > > > +/*
> > > > + *   r0  = delta
> > > > + *   r2  = BSS start
> > > > + *   r3  = BSS end
> > > > + *   r4  = final kernel address
> > > > + *   r5  = appended dtb size (still unknown)
> > > > + *   r6  = _edata
> > > > + *   r7  = architecture ID
> > > > + *   r8  = atags/device tree pointer
> > > > + *   r9  = size of decompressed image
> > > > + *   r10 = end of this image, including  bss/stack/malloc space if non XIP
> > > > + *   r11 = GOT start
> > > > + *   r12 = GOT end
> > > > + *   sp  = stack pointer
> > > > + *
> > > > + * if there are device trees (dtb) appended to zImage, advance r10 so that the
> > > > + * dtb data will get relocated along with the kernel if necessary.
> > > > + */
> > > > +
> > > > +		ldr	lr, [r6, #0]
> > > > +#ifndef __ARMEB__
> > > > +		ldr	r1, =0xedfe0dd0		@ sig is 0xd00dfeed big endian
> > > > +#else
> > > > +		ldr	r1, =0xd00dfeed
> > > > +#endif
> > > 
> > > Do we worry that garbage in memory after the zImage might match this
> > > magic number?
> > > 
> > > For example, if an ordinary userspace program allocates a huge number
> > > of pages and fills them with bogus device tree headers, is there a chance
> > > that the those headers could remain in memory across a reboot?
> > 
> > In theory this _could_ be possible.  However I don't expect this feature 
> > to be enabled if you are not going to actually use it, especially in a 
> > production setup.  If you are not appending a DTB to your kernel then 
> > there is simply no point keeping this config option set (normally you 
> > should use this option only because you have no other choices).
> 
> That seems reasonable.
> 
> Should we document this recommendation, in the Kconfig help or
> Documentation/?

I'll add some scary wording to the help text, and make it depend on 
EXPERIMENTAL as well.  I prefer not to impose some expectations on the 
zImage layout for this even if not in use, like being stuck with an 
offset that we'll always have to guard against corruption due to people 
blindly scripting the zImage poking you suggested even when it is not 
needed.

People will find ways to screw it up if they really want to anyway.  So 
I'd lean towards keeping this simple and not create any legacy around 
this hopefully temporary accommodation feature.


Nicolas
