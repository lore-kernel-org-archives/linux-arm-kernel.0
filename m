From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 6 Jan 2017 14:59:45 +0800
Subject: [PATCH 1/3] ARM: at91: flush the L2 cache before entering cpu idle
In-Reply-To: <20170106065947.30631-1-wenyou.yang@atmel.com>
References: <20170106065947.30631-1-wenyou.yang@atmel.com>
Message-ID: <20170106065947.30631-2-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the SoCs such as SAMA5D2 and SAMA5D4 which have L2 cache,
flush the L2 cache first before entering the cpu idle.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/mach-at91/pm.c       | 19 +++++++++++++++++++
 drivers/memory/atmel-sdramc.c |  1 +
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index b4332b727e9c..1a60dede1a01 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -289,6 +289,24 @@ static void at91_ddr_standby(void)
 		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
 }
 
+static void at91_ddr_cache_standby(void)
+{
+	u32 saved_lpr;
+
+	flush_cache_all();
+	outer_disable();
+
+	saved_lpr = at91_ramc_read(0, AT91_DDRSDRC_LPR);
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, (saved_lpr &
+			(~AT91_DDRSDRC_LPCB)) | AT91_DDRSDRC_LPCB_SELF_REFRESH);
+
+	cpu_do_idle();
+
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr);
+
+	outer_resume();
+}
+
 /* We manage both DDRAM/SDRAM controllers, we need more than one value to
  * remember.
  */
@@ -324,6 +342,7 @@ static const struct of_device_id const ramc_ids[] __initconst = {
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
 	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
 	{ .compatible = "atmel,sama5d3-ddramc", .data = at91_ddr_standby },
+	{ .compatible = "atmel,sama5d4-ddramc", .data = at91_ddr_cache_standby },
 	{ /*sentinel*/ }
 };
 
diff --git a/drivers/memory/atmel-sdramc.c b/drivers/memory/atmel-sdramc.c
index b418b39af180..7e5c5c6c1348 100644
--- a/drivers/memory/atmel-sdramc.c
+++ b/drivers/memory/atmel-sdramc.c
@@ -48,6 +48,7 @@ static const struct of_device_id atmel_ramc_of_match[] = {
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = &at91rm9200_caps, },
 	{ .compatible = "atmel,at91sam9g45-ddramc", .data = &at91sam9g45_caps, },
 	{ .compatible = "atmel,sama5d3-ddramc", .data = &sama5d3_caps, },
+	{ .compatible = "atmel,sama5d4-ddramc", .data = &sama5d3_caps, },
 	{},
 };
 
-- 
2.11.0
