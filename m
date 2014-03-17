From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:16:50 +0000
Subject: [PATCH 39/44] ARM: l2c: highbank: implement new write_sec method
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLEY-0002eW-Io@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the write_sec method, we no longer need to override the default L2C
disable method.  This can be handled via the write_sec method instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-highbank/highbank.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index c7de89b263dd..d6b803594358 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -51,11 +51,13 @@ static void __init highbank_scu_map_io(void)
 }
 
 
-static void highbank_l2x0_disable(void)
+static void highbank_l2c310_write_sec(unsigned long val, unsigned reg)
 {
-	outer_flush_all();
-	/* Disable PL310 L2 Cache controller */
-	highbank_smc1(0x102, 0x0);
+	if (reg == L2X0_CTRL)
+		highbank_smc1(0x102, val);
+	else
+		WARN_ONCE(1, "Highbank L2C310: ignoring write to reg 0x%x\n",
+			  reg);
 }
 
 static void __init highbank_init_irq(void)
@@ -69,8 +71,8 @@ static void __init highbank_init_irq(void)
 	if (IS_ENABLED(CONFIG_CACHE_L2X0) &&
 	    of_find_compatible_node(NULL, NULL, "arm,pl310-cache")) {
 		highbank_smc1(0x102, 0x1);
+		outer_cache.write_sec = highbank_l2x0_write_sec;
 		l2x0_of_init(0, ~0UL);
-		outer_cache.disable = highbank_l2x0_disable;
 	}
 }
 
-- 
1.8.3.1
