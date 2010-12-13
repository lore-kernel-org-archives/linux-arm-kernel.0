From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 19:21:46 +0000
Subject: [PATCH 20/24] ARM: nomadik: update clock source registration
In-Reply-To: <20101213191437.GN8665@n2100.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Message-ID: <E1PSDxy-0008Da-Su@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-nomadik/timer.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 63cdc60..b0bd6df 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -222,7 +222,6 @@ void __init nmdk_timer_init(void)
 	} else {
 		cr |= MTU_CRn_PRESCALE_1;
 	}
-	clocksource_calc_mult_shift(&nmdk_clksrc, rate, MTU_MIN_RANGE);
 
 	/* Timer 0 is the free running clocksource */
 	writel(cr, mtu_base + MTU_CR(0));
@@ -233,7 +232,7 @@ void __init nmdk_timer_init(void)
 	/* Now the clock source is ready */
 	nmdk_clksrc.read = nmdk_read_timer;
 
-	if (clocksource_register(&nmdk_clksrc))
+	if (clocksource_register_hz(&nmdk_clksrc, rate))
 		pr_err("timer: failed to initialize clock source %s\n",
 		       nmdk_clksrc.name);
 
-- 
1.6.2.5
