From: slash.tmp@free.fr (Mason)
Date: Thu, 26 Nov 2015 17:53:11 +0100
Subject: ARCH_MULTIPLATFORM + ARM_APPENDED_DTB + custom boot-loader
Message-ID: <565738F7.1060204@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm using an ARCH_MULTIPLATFORM kernel with an appended DTB.
I make a uImage out of this zImage+DTB.
On my board, U-Boot passes control to Linux, which boots correctly.

But when I replace U-Boot with a custom boot-loader, Linux tries
to boot some kind of "Generic DT based system" rather than the DT
I appended.

In fact, my setup code is:

static const char *const tango_dt_compat[] = { "sigma,tango4", NULL };
DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
	.dt_compat	= tango_dt_compat,
	.l2c_aux_mask	= ~0,
	.l2c_write_sec	= tango_l2c_write,
MACHINE_END


When I boot with U-Boot, in the early stage, the kernel prints
[    0.000000] Machine model: Sigma Designs SMP8758 Vantage-1172 Rev E1
(that's my model property)

But when I boot with the custom boot-loader, it just prints
[    0.000000] Machine: Sigma Tango DT
(and fails quickly since there are no clocks)


Does someone know what's going on? I thought the ARM_APPENDED_DTB
option was supposed to make DT handling transparent to boot-loaders?

This discussion may be relevant:
https://github.com/raspberrypi/linux/issues/381

Regards.
