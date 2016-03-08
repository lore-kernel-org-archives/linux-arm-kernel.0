From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 8 Mar 2016 12:24:35 +0530
Subject: [PATCH] ARM: dts: AM43x-epos: Fix clk parent for synctimer
Message-ID: <1457420075-26158-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 55ee7017ee31 ("arm: omap2: board-generic: use omap4_local_timer_init
for AM437x") makes synctimer32k as the clocksource on AM43xx. By default
the synctimer32k is clocked by 32K RTC OSC on AM43xx. But this 32K RTC OSC
is not available on epos boards which makes it fail to boot.

Synctimer32k can also be clocked by a peripheral PLL, so making this as
clock parent for synctimer3k on epos boards.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Tested on AM43x-epos board:
Before this patch: http://pastebin.ubuntu.com/15326328/
After this patch: http://pastebin.ubuntu.com/15326323/

 arch/arm/boot/dts/am43x-epos-evm.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 948fb29..e415332 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -794,3 +794,8 @@
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&synctimer_32kclk {
+	assigned-clocks = <&mux_synctimer32k_ck>;
+	assigned-clock-parents = <&clkdiv32k_ick>;
+};
-- 
2.1.4
