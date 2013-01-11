From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jan 2013 16:07:53 +0000
Subject: [PATCH] ARM: let CPUs not being able to run in ARM mode enter
 in THUMB mode
In-Reply-To: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1357904397-8476-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130111160753.GC23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 12:39:57PM +0100, Uwe Kleine-K?nig wrote:
> +# Select this if your CPU doesn't support the 32 bit ARM instructions.
> +config THUMBONLY_CPU
> +	bool
> +	select THUMB2_KERNEL
> +	select ARM_THUMB

Hmm, not convinced this is the best solution.  Yes, fine for there to be
a THUMBONLY_CPU option, _but_ not the select statements onto user visible
symbols.  We can get this instead by:

config THUMB2_KERNEL
        bool "Compile the kernel in Thumb-2 mode" if !THUMBONLY_CPU
        depends on (CPU_V7 && !CPU_V6 && !CPU_V6K) || THUMBONLY_CPU
	default y if THUMBONLY_CPU
        select AEABI
        select ARM_ASM_UNIFIED
        select ARM_UNWIND

and:

config ARM_THUMB
        bool "Support Thumb user binaries" if !THUMBONLY_CPU
        depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || \
		   CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || \
		   CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || \
		   CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
		   CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || \
		   CPU_V6K || CPU_V7 || CPU_FEROCEON || THUMBONLY_CPU
        default y

And... I'm left wondering - should we have this instead:

config CPU_ARM
	bool

config CPU_THUMB
	bool

which indicates whether the CPU supports the ARM instruction set or the
Thumb instruction set (or both) - that should then allow us to select
those from the individual CPU_xxx options and eliminate that big long
list of dependencies against ARM_THUMB.
