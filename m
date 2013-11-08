From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  8 Nov 2013 13:21:10 -0800
Subject: [PATCH 0/7] arm: zynq: cpufreq support
Message-ID: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series targets to enable cpufreq for Zynq which needs some
preparation in the DT and clocksource driver to work.

The first two patches are cleaning up the DT. The first just removes an
invalid property and the second adds a 'cpus' node to the DT. Those
changes should be okay independently of the final cpufreq patch.

Then the cadence_ttc patches: The first one fixes an issue which - I
think - shows in combination with cpuidle. I saw a kernel WARN triggered
because the driver calls clk_get_rate() from interrupt context. 3/7
should fix that. Patches 4 and 5 then are the actual preparation for
cpufreq. And 6 is an optimization to use the timer HW a little bit more
efficient.

And the final patch adds the required DT properties, platform devices
etc. to use cpufreq-cpu0 to scale the CPU frequency.

	S?ren


Soren Brinkmann (7):
  arm: dt: zynq: Remove 'clock-ranges' from TTC nodes
  arm: dt: zynq: Add 'cpus' node
  clocksource/cadence_ttc: Store timer frequency in driver data
  clocksource/cadence_ttc: Adjust interval in clock notifier
  clocksource/cadence_ttc: Overhaul clocksource frequency adjustment
  clocksource/cadence_ttc: Use only one counter
  arm: zynq: Add support for cpufreq

 arch/arm/boot/dts/zynq-7000.dtsi        |  35 ++++-
 arch/arm/mach-zynq/Kconfig              |   2 +
 arch/arm/mach-zynq/common.c             |   3 +
 drivers/clocksource/cadence_ttc_timer.c | 259 +++++++++++++++++++++-----------
 4 files changed, 208 insertions(+), 91 deletions(-)

-- 
1.8.4.2
