From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 24 Jan 2017 15:16:39 +0300
Subject: [PATCH v5 4/8] ARM: dts: rockchip: disable arm-global-timer for rk3188
In-Reply-To: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
References: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1485260203-14216-5-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clocksource and shed_clock provided by arm-global-timer is quite
unstable, because their rate depends on cpu frequency.
So disable arm-global-timer and use clocksource and sched_clock
from rockchip_timer.

It is impossible get stable clocksource having rockchip_timer and
arm-global-timer enabled at the same time. Because arm-global-timer
looks like a better candidate for the kernel: it has higher
frequency and rating.

Disabling arm-global-timer doesn't leave kernel without
clockevents as there is another clockevent provider (smp-twd).

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Reviwed-by: Heiko St?bner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index bcf8e03..f677130 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -546,6 +546,7 @@
 
 &global_timer {
 	interrupts = <GIC_PPI 11 0xf04>;
+	status = "disabled";
 };
 
 &local_timer {
-- 
1.7.9.5
