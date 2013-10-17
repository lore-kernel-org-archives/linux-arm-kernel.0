From: cinifr@gmail.com (Fan Rong)
Date: Fri, 18 Oct 2013 00:37:04 +0800
Subject: [Add SMP support for Allwinner A20: PATCH V5 0/3] 
Message-ID: <1382027827-10080-1-git-send-email-cinifr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V1 V2:
The patchs add smp support for Allwinner A20. It add cpuregister node in dts for smp configure. The patchs also add a options for phy count timer to replace vir count timer as ARM arch timer clocksource.
V3 Changes since V2:
It delete platform.h and delete some code in platsmp.c that's not necessary. It delete phy count timer support because most linux kernel platform want to use vir count timer especially for kvm. SMP need arch timer as clocksource, It does use virtual counter timer and  no longer use physical counter timer, so bootloader ***must*** set CNTVOFF register for a20 before kernel booting. I have add support set CNTVOFF register for uboot, if you want to test it in a20 board, you need update your sunxi uboot from: https://groups.google.com/forum/#!topic/linux-sunxi/O0Za7H5_jQI
V4 Changes since V3:
It use smp_prepare_cpus replacing early_init as cpuconfigure map init funcation caller and use sun7i replacing sunxi7i as funcation name and variable name.
V5 Changes since V4:
Move smp from struct DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)") to struct DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family") in file sunxi.c

*** BLURB HERE ***

Fan Rong (3):
  Add smp support for Allwinner A20(sunxi 7i).
  Add cpuconfig nodes in dts for smp configure.
  Add arch count timer node in dts for Allwinner A20(sunxi 7i).

 arch/arm/boot/dts/sun7i-a20.dtsi |  15 ++++++
 arch/arm/mach-sunxi/Makefile     |   2 +
 arch/arm/mach-sunxi/headsmp.S    |  18 +++++++
 arch/arm/mach-sunxi/platsmp.c    | 114 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-sunxi/sunxi.c      |   3 ++
 5 files changed, 152 insertions(+)
 create mode 100644 arch/arm/mach-sunxi/headsmp.S
 create mode 100644 arch/arm/mach-sunxi/platsmp.c
 mode change 100644 => 100755 arch/arm/mach-sunxi/sunxi.c

-- 
1.8.1.2
