From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 12 May 2015 00:17:31 +0200
Subject: [PATCH 3/3] ARM: l2c: highbank: Add dummy configure function
In-Reply-To: <1431382651-15894-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1431382651-15894-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1431382651-15894-4-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add empty configure function for the highbank l2c to reflect that the
cache can't be configured through a SMC. This prevent a useless
WARN_ONCE during early boot.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 arch/arm/mach-highbank/highbank.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 8e4846d..cee18db 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -60,6 +60,10 @@ static void highbank_l2c310_write_sec(unsigned long val, unsigned reg)
 			  reg);
 }
 
+static void highbank_l2c310_configure(const struct l2x0_regs *regs)
+{
+}
+
 static void __init highbank_init_irq(void)
 {
 	irqchip_init();
@@ -68,6 +72,7 @@ static void __init highbank_init_irq(void)
 		highbank_scu_map_io();
 
 	if (IS_ENABLED(CONFIG_CACHE_L2X0)) {
+		outer_cache.configure = highbank_l2c310_configure;
 		outer_cache.skip_unlock = true;
 	}
 }
-- 
2.1.4
