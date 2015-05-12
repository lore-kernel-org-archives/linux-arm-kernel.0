From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 12 May 2015 09:39:15 +0200
Subject: [PATCH 2/2] ARM: l2c: highbank: Add dummy configure function
In-Reply-To: <1431416355-7693-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1431416355-7693-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1431416355-7693-3-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add empty configure function for the highbank l2c to reflect that the
cache can't be confured through a SMC. This prevent a useless
WARN_ONCE during early boot.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 arch/arm/mach-highbank/highbank.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 231fba0..623eb5e8 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -60,12 +60,20 @@ static void highbank_l2c310_write_sec(unsigned long val, unsigned reg)
 			  reg);
 }
 
+static void highbank_l2c310_configure(const struct l2x0_regs *regs)
+{
+}
+
 static void __init highbank_init_irq(void)
 {
 	irqchip_init();
 
 	if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
 		highbank_scu_map_io();
+
+	if (IS_ENABLED(CONFIG_CACHE_L2X0)) {
+		outer_cache.configure = highbank_l2c310_configure;
+	}
 }
 
 static void highbank_power_off(void)
-- 
2.1.4
