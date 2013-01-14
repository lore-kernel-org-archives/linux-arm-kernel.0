From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 14 Jan 2013 10:50:50 +0100
Subject: [PATCH] ARM: let CPUs not being able to run in ARM mode enter in
 THUMB mode
In-Reply-To: <20130111162016.GM14860@pengutronix.de>
References: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130111160753.GC23505@n2100.arm.linux.org.uk>
 <20130111162016.GM14860@pengutronix.de>
Message-ID: <20130114095050.GO14860@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Fri, Jan 11, 2013 at 05:20:16PM +0100, Uwe Kleine-K?nig wrote:
> On Fri, Jan 11, 2013 at 04:07:53PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Jan 11, 2013 at 12:39:57PM +0100, Uwe Kleine-K?nig wrote:
> > > +# Select this if your CPU doesn't support the 32 bit ARM instructions.
> > > +config THUMBONLY_CPU
> > > +	bool
> > > +	select THUMB2_KERNEL
> > > +	select ARM_THUMB
> > 
> > Hmm, not convinced this is the best solution.  Yes, fine for there to be
> > a THUMBONLY_CPU option, _but_ not the select statements onto user visible
> > symbols.  We can get this instead by:
> > 
> > config THUMB2_KERNEL
> >         bool "Compile the kernel in Thumb-2 mode" if !THUMBONLY_CPU
> >         depends on (CPU_V7 && !CPU_V6 && !CPU_V6K) || THUMBONLY_CPU
> > 	default y if THUMBONLY_CPU
> >         select AEABI
> >         select ARM_ASM_UNIFIED
> >         select ARM_UNWIND
> > 
> > and:
> > 
> > config ARM_THUMB
> >         bool "Support Thumb user binaries" if !THUMBONLY_CPU
> >         depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || \
> > 		   CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || \
> > 		   CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || \
> > 		   CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
> > 		   CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || \
> > 		   CPU_V6K || CPU_V7 || CPU_FEROCEON || THUMBONLY_CPU
> >         default y
> > 
> > And... I'm left wondering - should we have this instead:
> > 
> > config CPU_ARM
> > 	bool
> > 
> > config CPU_THUMB
> > 	bool
> > 
> > which indicates whether the CPU supports the ARM instruction set or the
> > Thumb instruction set (or both) - that should then allow us to select
> > those from the individual CPU_xxx options and eliminate that big long
> > list of dependencies against ARM_THUMB.
> I like your idea and I will come up with a patch.
This looks nice and clean, but after having thought about it for a while
it turns out not to be that easy.

For THUMB2_KERNEL only CPUs must be supported that can do Thumb2. That
means the logic must be something like:

	config THUMB2_KERNEL
		bool "Compile the kernel in Thumb-2 mode" if ALL_CONFIGURED_CPUS_SUPPORT_ARM
		depends on ALL_CONFIGURED_CPUS_SUPPORT_THUMB2
		default y if !ALL_CONFIGURED_CPUS_SUPPORT_ARM

for the ALL_CONFIGURED_CPUS_SUPPORT_ARM and .._THUMB2 symbols to do the
right thing, we'd need something like:

	config CPU_32v4
		bool
		...
		select ISA_ARM
		select ISA_THUMB_NONE

	config CPU_32v4T
		bool
		...
		select ISA_ARM
		select ISA_THUMB1
	...
	config CPU_32v7
		bool
		select ISA_ARM
		select ISA_THUMB2

	config CPU_32v7M
		bool
		select ISA_ARM_NONE
		select ISA_THUMB2

	config ALL_CONFIGURED_CPUS_SUPPORT_ARM
		bool
		default ISA_ARM && !ISA_ARM_NONE

	config ALL_CONFIGURED_CPUS_SUPPORT_THUMB2
		bool
		default ISA_THUMB2 && !ISA_THUMB1 && !ISA_THUMB_NONE

which looks less nice than what I thought first.

What do you think? Is it still worthwhile to implement this?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
