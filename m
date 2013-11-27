From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 26 Nov 2013 17:04:47 -0800
Subject: [PATCH v2 0/9] arm: zynq: Add support for cpufreq
Message-ID: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I revised this series and rebased on top of Linus' tree. Patch specific
changes are tracked in the respective email with their patch. On the
level of the whole series, this changed:

v2:
 - added 'clocksource/cadence_ttc: Use enable/disable_irq'. I hope that
   is more appropriate to avoid races of the timer with its interrupt
   handler.
 - added 'arm: zynq: Don't use arm_global_timer with cpufreq'. In the
   3.13 merge window we enabled the arm_global_timer for Zynq. That
   timer is clocked by the CPU clock and hence does not provide a stable
   clocksource when cpufreq is enabled. That patch makes the selection of
   the GT driver depend on !CPU_FREQ for Zynq.

	S?ren

Soren Brinkmann (9):
  arm: dt: zynq: Remove 'clock-ranges' from TTC nodes
  arm: dt: zynq: Add 'cpus' node
  clocksource/cadence_ttc: Store timer frequency in driver data
  clocksource/cadence_ttc: Use enable/disable_irq
  clocksource/cadence_ttc: Adjust interval in clock notifier
  clocksource/cadence_ttc: Overhaul clocksource frequency adjustment
  clocksource/cadence_ttc: Use only one counter
  arm: zynq: Don't use arm_global_timer with cpufreq
  arm: zynq: Add support for cpufreq

 arch/arm/boot/dts/zynq-7000.dtsi        |  27 +++-
 arch/arm/mach-zynq/Kconfig              |   4 +-
 arch/arm/mach-zynq/common.c             |   3 +
 drivers/clocksource/cadence_ttc_timer.c | 235 +++++++++++++++++++-------------
 4 files changed, 174 insertions(+), 95 deletions(-)

-- 
1.8.4.4
