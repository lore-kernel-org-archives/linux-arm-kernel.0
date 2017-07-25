From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 25 Jul 2017 13:09:15 +0800
Subject: [PATCH 0/4] ARM: sun9i: SMP bring-up with Multi-Cluster Power
 Management
Message-ID: <20170725050919.16036-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is a partial resend of my sun9i SMP support with MCPM series from
over two years ago [1]. Not much has changed since then. We've tried
to implement PSCI for both the A80 and A83T. Results were not promising.
The issue is that these two chips have a broken security extensions
implementation. If a specific bit is not burned in its e-fuse, most if
not all security protections don't work [2]. Even worse, non-secure
access to the GIC become secure. This requires a crazy workaround in
the GIC driver which probably doesn't work in all cases [3].

Nicolas mentioned that the MCPM framework is likely overkill in our
case [4]. However the framework does provide cluster/core state tracking
and proper sequencing of cache related operations. We could rework
the code to use standard smp_ops, but I would like to actually get
a working version in first.

Core and cluster power-down, aka hotplugging, is not included in this
series. Nicolas mentioned that a new optional callback should be added
in cases where the kernel has to do the actual power down [5]. This
will be done later on. Only patches 1 ~ 4 from the original RFC series
are resent.

Changes since RFC:

  - Have MACH_SUN9I imply MCPM, and have SUN9I_A80_MCPM default to
    MACH_SUN9I. This means no defconfig changes are required.


Please have a look.

Regards
ChenYu

[1] http://www.spinics.net/lists/arm-kernel/msg418350.html
[2] https://lists.denx.de/pipermail/u-boot/2017-June/294637.html
[3] https://github.com/wens/linux/commit/c48654c1f737116e7a7660183c8c74fa91970528
[4] http://www.spinics.net/lists/arm-kernel/msg434160.html
[5] http://www.spinics.net/lists/arm-kernel/msg434408.html


Original cover letter from the old RFC series:

This is my attempt to support SMP and CPU hot plugging on the Allwinner
A80 SoC. The A80 is a big.Little processor with 2 clusters of 4x Cortex-A7
and 4x Cortex-A15 cores.

Much of the sunxi-specific MCPM code is derived from Allwinner code and
documentation, with some references to the other MCPM implementations,
as well as the Cortex's Technical Reference Manuals for the power
sequencing info.

One major difference compared to other platforms is we currently do not
have a standalone PMU or other embedded firmware to do the actually power
sequencing. All power/reset control is done by the kernel. As such, I
couldn't figure out where to put the code to power off the outbound
processor. I'm putting it in the .wait_for_powerdown() callback for now.
This does not get called by the big.Little switcher. But since we lack
cpufreq support at the moment, big.Little switcher is probably not going
to work anyway.

The code has been tested on my A80 Optimus, and reliably brings up all
cores. CPU hotplugging works as well. One issue I have is the processors
in cluster 0 do not stay in WFI after they are signaled to go offline.
I haven't tested the CCI-400 PMU bits yet.

I've done the best I could to fit the code into the new MCPM callbacks,
unlike the Allwinner code which uses the old .power_up()/.power_down()
ones. However my knowledge of ARM internals is limited, so it is quite
possible I got something wrong. Reviews are highly appreciated.

The actual work is split into 3 phases:

Patch 1 adds basic SMP bringup code using the common MCPM code.
No hotplugging is supported.

Patch 2 ~ 4 add the required DT device nodes.

Patch 5 adds support for hotplugging processor cores 1~7.

Patch 6 adds support for cpu0 hotplugging. The BROM checks a region
of secure SRAM for special flags. If they are set, execution is
diverted to the configured secondary startup address, just like it
would be for all the other processor cores.

Patch 7 adds the DT nodes for the secure SRAM.

Chen-Yu Tsai (4):
  ARM: sun9i: Support SMP on A80 with Multi-Cluster Power Management
    (MCPM)
  ARM: dts: sun9i: Add CCI-400 device nodes for A80
  ARM: dts: sun9i: Add CPUCFG device node for A80 dtsi
  ARM: dts: sun9i: Add PRCM device node for the A80 dtsi

 arch/arm/boot/dts/sun9i-a80.dtsi |  56 ++++++
 arch/arm/mach-sunxi/Kconfig      |  10 +
 arch/arm/mach-sunxi/Makefile     |   1 +
 arch/arm/mach-sunxi/mcpm.c       | 391 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 458 insertions(+)
 create mode 100644 arch/arm/mach-sunxi/mcpm.c

-- 
2.13.3
