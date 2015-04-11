From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Apr 2015 13:20:56 +0100
Subject: [PATCH] Ensure delay timer has sufficient accuracy for delays
Message-ID: <20150411122056.GN12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have recently had an example of someone wanting to use a 90kHz timer
for the software delay loop.

udelay() needs to have at least microsecond resolution to allow drivers
access to a delay mechanism with a reasonable chance of delaying the
period they requested within at least a 50% marging of error, especially
for small delays.

Discussion about the udelay() accuracy can be found at:
	https://lkml.org/lkml/2011/1/9/37

Reject timers which are unable to supply this level of resolution.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/lib/delay.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 312d43eb686a..8044591dca72 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -83,6 +83,12 @@ void __init register_current_timer_delay(const struct delay_timer *timer)
 			       NSEC_PER_SEC, 3600);
 	res = cyc_to_ns(1ULL, new_mult, new_shift);
 
+	if (res > 1000) {
+		pr_err("Ignoring delay timer %ps, which has insufficient resolution of %lluns\n",
+			timer, res);
+		return;
+	}
+
 	if (!delay_calibrated && (!delay_res || (res < delay_res))) {
 		pr_info("Switching to timer-based delay loop, resolution %lluns\n", res);
 		delay_timer			= timer;

-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
