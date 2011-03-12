From: andy@warmcat.com (Andy Green)
Date: Sat, 12 Mar 2011 22:50:54 +0000
Subject: [RFC PATCH 3/5] OMAP2+:Common CPU DIE ID reading code reads wrong
	registers for OMAP4430
In-Reply-To: <20110312224440.27728.60593.stgit@otae.warmcat.com>
References: <20110312224440.27728.60593.stgit@otae.warmcat.com>
Message-ID: <20110312225054.27728.89155.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adapts the register offsets used to read the CPU DIE ID registers
when run on 44XX so they match what is in the OMAP4430 Reference Manual
page 269

Signed-off-by: Andy Green <andy.green@linaro.org>
---

 arch/arm/mach-omap2/id.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index fc69ec5..733bb27 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -84,6 +84,11 @@ EXPORT_SYMBOL(omap_type);
 #define OMAP_TAP_DIE_ID_2	0x0220
 #define OMAP_TAP_DIE_ID_3	0x0224
 
+#define OMAP_TAP_DIE_ID_44XX_0	0x0200
+#define OMAP_TAP_DIE_ID_44XX_1	0x0208
+#define OMAP_TAP_DIE_ID_44XX_2	0x020c
+#define OMAP_TAP_DIE_ID_44XX_3	0x0210
+
 #define read_tap_reg(reg)	__raw_readl(tap_base  + (reg))
 
 struct omap_id {
@@ -107,6 +112,14 @@ static u16 tap_prod_id;
 
 void omap_get_die_id(struct omap_die_id *odi)
 {
+	if (cpu_is_omap44xx()) {
+		odi->id_0 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_0);
+		odi->id_1 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_1);
+		odi->id_2 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_2);
+		odi->id_3 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_3);
+
+		return;
+	}
 	odi->id_0 = read_tap_reg(OMAP_TAP_DIE_ID_0);
 	odi->id_1 = read_tap_reg(OMAP_TAP_DIE_ID_1);
 	odi->id_2 = read_tap_reg(OMAP_TAP_DIE_ID_2);
