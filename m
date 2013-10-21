From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Mon, 21 Oct 2013 10:58:49 +0100
Subject: [PATCH v2 0/5] ARM: vexpress/TC2: cpufreq support
Message-ID: <1382349534-31502-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Hi,

The SPC(Serial Power Controller) on Versatile Express V2P-CA15_A7(TC2)
not only controls low-power states, wake-up irqs and per-CPU jump addresses
but also the CPU performance operating points which is essential to provide
CPU DVFS. The M3 microcontroller can provide upto eight performance values,
one set for each cluster (CA15 or CA7). Each of this value contains the
frequency(kHz) and voltage(mV) at that performance level. It expects
these performance level to be passed through the SPC PERF_LVL registers.
    
This patch series adds support to populate those OPPs, add them to the
cpu devices and runtime programming of these performance levels through
clock framework. It also adds a small interface cpufreq driver to validate
the OPPs and register the arm_big_little cpufreq driver.

Changes v1->v2:
	- Introduced ARCH_VEXPRESS_SPC config to make dependency
	  selection cleaner
	- Other minor review comments from Nico implemented

Regards,
Sudeep

Sudeep KarkadaNagesha (5):
  cpufreq: arm-big-little: use clk_get instead of clk_get_sys
  ARM: vexpress/TC2: add support for CPU DVFS
  ARM: vexpress/TC2: add cpu clock support
  cpufreq: arm_big_little: add vexpress SPC interface driver
  ARM: vexpress/TC2: register vexpress-spc cpufreq device

 arch/arm/mach-vexpress/Kconfig         |  12 ++
 arch/arm/mach-vexpress/Makefile        |   3 +-
 arch/arm/mach-vexpress/spc.c           | 366 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-vexpress/spc.h           |   2 +-
 arch/arm/mach-vexpress/tc2_pm.c        |   7 +-
 drivers/cpufreq/Kconfig.arm            |   8 +
 drivers/cpufreq/Makefile               |   1 +
 drivers/cpufreq/arm_big_little.c       |   2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c |  69 +++++++
 9 files changed, 464 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpufreq/vexpress-spc-cpufreq.c

-- 
1.8.1.2
