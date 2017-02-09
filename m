From: chris.brandt@renesas.com (Chris Brandt)
Date: Wed,  8 Feb 2017 22:30:42 -0500
Subject: [PATCH 0/2] ARM: ARMv7 (with MMU) XIP without ARCH_MULTIPLATFORM
Message-ID: <20170209033044.19513-1-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The basic idea of this series is to introduce a top level ARM_SINGLE_ARMV7 that
can be selected instead of ARCH_MULTIPLATFORM for the purpose of being able to
select XIP_KERNEL.

ARM_SINGLE_ARMV7 is not selected directly, but rather by first selecting a
specific SOC family (as opposed to the multiplatform option), then the SoC
family will select ARM_SINGLE_ARMV7.

At that point, an individual SOC device can selected which then allows them to
select XIP_KERNEL if they want to.

It is up to the SoC familiies to determine if XIP and/or ARM_SINGLE_ARMV7 makes
sence.


For this series, the Renesas SoCs allow ARM_SINGLE_ARMV7.

Particulary, the Renesas RZ/A1 (ARCH_R7S72100) was tested with both XIP_KERNEL=y
and XIP_KERNEL=n.

System Type  --->
	[*] MMU-based Paged Memory Management Support
	-*- ARMv7 based single platforms
	    ARM system type (Renesas ARM SoCs)
	[*] Renesas ARM SoCs  --->
		[*]   RZ/A1H (R7S72100)


For me, I was able to come up with a .config that would produce the same
defconfig as it did before this patch series proving that ARCH_MULTIPLATFORM is
just a method in grouping configs together that could normally be selected
individually.


I would say maybe the only other thing we could add is a XIP_CAPABLE config
that is set only by each individual SoC. Then users can only select
XIP_KERNEL for SoCs that actually have a chance at working.

Something like:

[ arch/arm/mach-shmobile/Kconfig ]
config ARCH_R7S72100
	bool "RZ/A1H (R7S72100)"
	select PM
	select PM_GENERIC_DOMAINS
	select SYS_SUPPORTS_SH_MTU2
	select RENESAS_OSTM
	select XIP_CAPABLE


[ arch/arm/Kconifg ]
config XIP_KERNEL
	bool "Kernel Execute-In-Place from ROM"
	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM && XIP_CAPABLE



Chris Brandt (2):
  ARM: add ARM_SINGLE_ARMV7 as config option
  ARM: shmobile: add renesas soc as a top level selection

 arch/arm/Kconfig               | 22 ++++++++++++++++++++++
 arch/arm/Kconfig.debug         |  6 ++++--
 arch/arm/Makefile              |  5 +++++
 arch/arm/kernel/devtree.c      |  3 ++-
 arch/arm/mach-shmobile/Kconfig |  2 +-
 5 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.10.1
