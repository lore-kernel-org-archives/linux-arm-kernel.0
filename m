From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 20 Apr 2016 10:25:23 +0100
Subject: SoCFPGA with CONFIG_THUMB2_KERNEL boot error
In-Reply-To: <20160419140220.GA9503@pengutronix.de>
References: <20160419140220.GA9503@pengutronix.de>
Message-ID: <20160420092516.GA21732@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 04:02:20PM +0200, Steffen Trumtrar wrote:
> Hi!
> 
> According to kernelci.org (and validating on my own hardware), the current
> socfpga mainline kernel has an issue with CONFIG_THUMB2_KERNEL enabled.
> 
> https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html
> 
> vs
> 
> https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html
> 
> Both boot successfully, but notice that the board fails to bring up CPU1 if
> thumb2 support is enabled.
> 
> Any ideas why this might be happening?

Looks like there is at least a module loading problem:

dwc2: section 2 reloc 234 sym '_raw_spin_lock': relocation 10 out of range (0xbf801086 -> 0xc08c2d75)

This happens because of the smaller branch range on Thumb2 versus ARM,
if the combined size of the kernel and modules area gets too large.

So, use CONFIG_THUMB2_KERNEL=n, shrink your kernel or load fewer
modules :P

You could try enabling CONFIG_ARM_MODULE_PLTS -- I've never tried that,
but it looks like it is designed to solve this problem by allocating
space for trampolines to help resolve long branches.  If you are
_already_ enabling this option, there may be a bug in its
implementation though...

Cheers
---Dave
