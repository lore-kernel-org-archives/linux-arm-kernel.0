From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 12 May 2015 00:17:30 +0200
Subject: [PATCH 2/3] ARM: l2c: highbank: Skip l2c unlocking
In-Reply-To: <1431382651-15894-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1431382651-15894-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1431382651-15894-3-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The highbank SMC interface doesn't allow configuring the cache for
unlocking from the non-secure world. So skip unlocking otherwise the
machine get imprecise abort and become unstable on boot.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 arch/arm/mach-highbank/highbank.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 231fba0..8e4846d 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -66,6 +66,10 @@ static void __init highbank_init_irq(void)
 
 	if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
 		highbank_scu_map_io();
+
+	if (IS_ENABLED(CONFIG_CACHE_L2X0)) {
+		outer_cache.skip_unlock = true;
+	}
 }
 
 static void highbank_power_off(void)
-- 
2.1.4
