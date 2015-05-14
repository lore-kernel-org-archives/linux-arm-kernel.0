From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 May 2015 14:10:04 +0800
Subject: [RFC 0/7] ARM: sun9i: SMP support with Multi-Cluster Power Management
Message-ID: <1431583811-25780-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

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


Regards
ChenYu


Chen-Yu Tsai (7):
  ARM: sun9i: Support SMP on A80 with Multi-Cluster Power Management
    (MCPM)
  ARM: dts: sun9i: Add CCI-400 device nodes for A80
  ARM: dts: sun9i: Add CPUCFG device node for A80 dtsi
  ARM: dts: sun9i: Add PRCM device node for the A80 dtsi
  ARM: sunxi: mcpm: Support CPU/cluster power down and hotplugging for
    cpu1~7
  ARM: sunxi: mcpm: Support cpu0 hotplug
  ARM: dts: sun9i: Add secure SRAM node used for MCPM SMP hotplug

 arch/arm/boot/dts/sun9i-a80.dtsi |  76 ++++++
 arch/arm/mach-sunxi/Kconfig      |   8 +
 arch/arm/mach-sunxi/Makefile     |   1 +
 arch/arm/mach-sunxi/mcpm.c       | 497 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 582 insertions(+)
 create mode 100644 arch/arm/mach-sunxi/mcpm.c

-- 
2.1.4
