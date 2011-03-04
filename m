From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 4 Mar 2011 09:42:53 +0100
Subject: [PATCH] mmci: separate out ST Micro register defines
Message-ID: <1299228173-3162-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The mmci.h header contained a few registers not clearly marked
as ST Micro only, rectify this and remove the HWFC magic in the
process. The idea is to make the mmci.h header file more ordered
so other vendors with PL180 derivates can see where to put in
their custom register defines.

Includes portions of an earlier patch from Sebastian Rasmussen.

Cc: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |    4 ++--
 drivers/mmc/host/mmci.h |   41 +++++++++++++++++++++++++++--------------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 39f0e77..1dfd099 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -71,7 +71,7 @@ static struct variant_data variant_arm = {
 static struct variant_data variant_u300 = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
-	.clkreg_enable		= 1 << 13, /* HWFCEN */
+	.clkreg_enable		= MCI_ST_U300_HWFCEN,
 	.datalength_bits	= 16,
 	.sdio			= true,
 };
@@ -80,7 +80,7 @@ static struct variant_data variant_ux500 = {
 	.fifosize		= 30 * 4,
 	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
-	.clkreg_enable		= 1 << 14, /* HWFCEN */
+	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
 	.datalength_bits	= 24,
 	.sdio			= true,
 	.st_clkdiv		= true,
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index ec9a7bc6..bb32e21 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -11,23 +11,33 @@
 #define MCI_PWR_OFF		0x00
 #define MCI_PWR_UP		0x02
 #define MCI_PWR_ON		0x03
-#define MCI_DATA2DIREN		(1 << 2)
-#define MCI_CMDDIREN		(1 << 3)
-#define MCI_DATA0DIREN		(1 << 4)
-#define MCI_DATA31DIREN		(1 << 5)
 #define MCI_OD			(1 << 6)
 #define MCI_ROD			(1 << 7)
-/* The ST Micro version does not have ROD */
-#define MCI_FBCLKEN		(1 << 7)
-#define MCI_DATA74DIREN		(1 << 8)
+/*
+ * The ST Micro version does not have ROD and reuse the voltage registers
+ * for direction settings
+ */
+#define MCI_ST_DATA2DIREN	(1 << 2)
+#define MCI_ST_CMDDIREN		(1 << 3)
+#define MCI_ST_DATA0DIREN	(1 << 4)
+#define MCI_ST_DATA31DIREN	(1 << 5)
+#define MCI_ST_FBCLKEN		(1 << 7)
+#define MCI_ST_DATA74DIREN	(1 << 8)
 
 #define MMCICLOCK		0x004
 #define MCI_CLK_ENABLE		(1 << 8)
 #define MCI_CLK_PWRSAVE		(1 << 9)
 #define MCI_CLK_BYPASS		(1 << 10)
 #define MCI_4BIT_BUS		(1 << 11)
-/* 8bit wide buses supported in ST Micro versions */
+/*
+ * 8bit wide buses, hardware flow contronl, negative edges and clock inversion
+ * supported in ST Micro U300 and Ux500 versions
+ */
 #define MCI_ST_8BIT_BUS		(1 << 12)
+#define MCI_ST_U300_HWFCEN	(1 << 13)
+#define MCI_ST_UX500_NEG_EDGE	(1 << 13)
+#define MCI_ST_UX500_HWFCEN	(1 << 14)
+#define MCI_ST_UX500_CLK_INV	(1 << 15)
 
 #define MMCIARGUMENT		0x008
 #define MMCICOMMAND		0x00c
@@ -88,8 +98,9 @@
 #define MCI_RXFIFOEMPTY		(1 << 19)
 #define MCI_TXDATAAVLBL		(1 << 20)
 #define MCI_RXDATAAVLBL		(1 << 21)
-#define MCI_SDIOIT		(1 << 22)
-#define MCI_CEATAEND		(1 << 23)
+/* Extended status bits for the ST Micro variants */
+#define MCI_ST_SDIOIT		(1 << 22)
+#define MCI_ST_CEATAEND		(1 << 23)
 
 #define MMCICLEAR		0x038
 #define MCI_CMDCRCFAILCLR	(1 << 0)
@@ -102,8 +113,9 @@
 #define MCI_CMDSENTCLR		(1 << 7)
 #define MCI_DATAENDCLR		(1 << 8)
 #define MCI_DATABLOCKENDCLR	(1 << 10)
-#define MCI_SDIOITC		(1 << 22)
-#define MCI_CEATAENDC		(1 << 23)
+/* Extended status bits for the ST Micro variants */
+#define MCI_ST_SDIOITC		(1 << 22)
+#define MCI_ST_CEATAENDC	(1 << 23)
 
 #define MMCIMASK0		0x03c
 #define MCI_CMDCRCFAILMASK	(1 << 0)
@@ -127,8 +139,9 @@
 #define MCI_RXFIFOEMPTYMASK	(1 << 19)
 #define MCI_TXDATAAVLBLMASK	(1 << 20)
 #define MCI_RXDATAAVLBLMASK	(1 << 21)
-#define MCI_SDIOITMASK		(1 << 22)
-#define MCI_CEATAENDMASK	(1 << 23)
+/* Extended status bits for the ST Micro variants */
+#define MCI_ST_SDIOITMASK	(1 << 22)
+#define MCI_ST_CEATAENDMASK	(1 << 23)
 
 #define MMCIMASK1		0x040
 #define MMCIFIFOCNT		0x048
-- 
1.7.3.2
