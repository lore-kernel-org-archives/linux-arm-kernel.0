From: s-anna@ti.com (Suman Anna)
Date: Wed, 7 Jun 2017 16:27:24 -0500
Subject: [PATCH 0/6] Init Clock frequences for accelerators
Message-ID: <20170607212730.33002-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following series configures the initial frequencies for the required
DPLLs and corresponding output divider clocks used by various remoteproc
accelerators (DSP, IVAHD) on OMAP4, OMAP5 & DRA7xx/AM57xx SoCs and the
GPU on DRA7xx/AM57xx SoCs. All these devices require Adaptive Voltage
Scaling (AVS) to be programmed at all OPPs at boot time, which is
programmed in the bootloader. Furthermore, DVFS is not supported on
these domains implying a one-time OPP clock frequency setup.

IPUs (except for IPU1 on DRA7) being in CORE domain, are clocked by the
CORE DPLL and do not require any specific programming. The DPLLs clock
rates are configured for OPP_NOM rates which is what the bootloader
configures the corresponding voltage domains for by default. The design
follows the assigned-clock parents/rates rules for clock providers in
the generic clock bindings.

Newer U-boots of 2017.01 and later can also add/update these properties
if a different OPP is required. The default is OPP_NOM, and higher OPPs
can be supported through configuration of the bootloader. This series
sets up the DPLLs for OPP_NOM and be agnostic of the bootloaders w.r.t
the clock frequences (like when using older U-Boots).

MPU domain is not affected as it supports DVFS and different OPPs can
be supported through the appropriate kernel framework.

I have tested the patches using 4.12-rc4, but they can be applied on
the 4.12-rc1 base just fine.

regards
Suman

Subhajit Paul (1):
  ARM: dts: dra7xx-clocks: Use DPLL_GPU for GPU clocks

Suman Anna (5):
  ARM: dts: omap44xx-clocks: Set IVA DPLL and its output clock rates
  ARM: dts: omap54xx-clocks: Set IVA DPLL and its output clock rates
  ARM: dts: dra7xx-clocks: Source IPU1 functional clock from CORE DPLL
  ARM: dts: dra7xx-clocks: Set DSP DPLL and its output clock rates
  ARM: dts: dra7xx-clocks: Set IVA DPLL and its output clock rates

 arch/arm/boot/dts/dra7xx-clocks.dtsi   | 20 ++++++++++++++++++++
 arch/arm/boot/dts/omap44xx-clocks.dtsi |  6 ++++++
 arch/arm/boot/dts/omap54xx-clocks.dtsi |  6 ++++++
 3 files changed, 32 insertions(+)

-- 
2.12.0
