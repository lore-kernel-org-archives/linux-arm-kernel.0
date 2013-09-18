From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 18 Sep 2013 11:48:34 -0700
Subject: [PATCH v2 0/4] arm: zynq: Enable global timer
Message-ID: <1379530118-22813-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

here's a v2. I reused the subject from my v1 submission although the focus of
this series moved a bit towards the timer subsystem.
I replaced Stephen's fix to prevent per cpu devices from becoming
the broadcast device with Thomas' proposal, but I kept the original commit
message. I split the whole approach in small chunks that I found reasonable.

In 4/4, I picked up Grant's comment regarding the DT node name.

v2:
 - drop 1/2 of the original series
 - implement preventing per cpu devices from becoming broadcast device according
   to Thomas' proposal
   - introduce new CLOCK_EVT_FEAT_PERCPU flag
   - set the flag for the arm_global_timer
   - filter per cpu devices based on this flag when choosing the broadcast
     device
 - rename DT node to avoid '_'s
 

Soren Brinkmann (4):
  clockchips: Add FEAT_PERCPU clockevent flag
  clocksource/arm_global_timer: Set FEAT_PERCPU flag
  tick: broadcast: Deny per-cpu clockevents from being broadcast sources
  arm: zynq: Enable arm_global_timer

 arch/arm/boot/dts/zynq-7000.dtsi       | 8 ++++++++
 arch/arm/mach-zynq/Kconfig             | 1 +
 drivers/clocksource/arm_global_timer.c | 3 ++-
 include/linux/clockchips.h             | 1 +
 kernel/time/tick-broadcast.c           | 1 +
 5 files changed, 13 insertions(+), 1 deletion(-)

-- 
1.8.4
