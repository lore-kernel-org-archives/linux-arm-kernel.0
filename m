From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 19 Oct 2010 16:28:17 +0200
Subject: [PATCH 2/2] ARM: pxa: Update Balloon3 for new FPGA firmware
In-Reply-To: <1287498497-11251-1-git-send-email-marek.vasut@gmail.com>
References: <1287498497-11251-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1287498497-11251-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new FPGA firmware in Balloon3 uses different methods to control it's bus
control lines. In the new version, there are separate registers to set/clear
bus control lines. This patch updates affected places.

Affected are NAND and PCMCIA.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c              |   51 ++++++++++++++++------------
 arch/arm/mach-pxa/include/mach/balloon3.h |    2 +
 drivers/pcmcia/pxa2xx_balloon3.c          |   11 +++---
 3 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index f4142b0..235d957 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -569,27 +569,29 @@ static inline void balloon3_i2c_init(void) {}
  * NAND
  ******************************************************************************/
 #if defined(CONFIG_MTD_NAND_PLATFORM)||defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
-static uint16_t balloon3_ctl =
-	BALLOON3_NAND_CONTROL_FLCE0 | BALLOON3_NAND_CONTROL_FLCE1 |
-	BALLOON3_NAND_CONTROL_FLCE2 | BALLOON3_NAND_CONTROL_FLCE3 |
-	BALLOON3_NAND_CONTROL_FLWP;
-
 static void balloon3_nand_cmd_ctl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct nand_chip *this = mtd->priv;
+	uint8_t balloon3_ctl_set = 0, balloon3_ctl_clr = 0;
 
 	if (ctrl & NAND_CTRL_CHANGE) {
 		if (ctrl & NAND_CLE)
-			balloon3_ctl |= BALLOON3_NAND_CONTROL_FLCLE;
+			balloon3_ctl_set |= BALLOON3_NAND_CONTROL_FLCLE;
 		else
-			balloon3_ctl &= ~BALLOON3_NAND_CONTROL_FLCLE;
+			balloon3_ctl_clr |= BALLOON3_NAND_CONTROL_FLCLE;
 
 		if (ctrl & NAND_ALE)
-			balloon3_ctl |= BALLOON3_NAND_CONTROL_FLALE;
+			balloon3_ctl_set |= BALLOON3_NAND_CONTROL_FLALE;
 		else
-			balloon3_ctl &= ~BALLOON3_NAND_CONTROL_FLALE;
-
-		__raw_writel(balloon3_ctl, BALLOON3_NAND_CONTROL_REG);
+			balloon3_ctl_clr |= BALLOON3_NAND_CONTROL_FLALE;
+
+		if (balloon3_ctl_clr)
+			__raw_writel(balloon3_ctl_clr,
+				BALLOON3_NAND_CONTROL_REG);
+		if (balloon3_ctl_set)
+			__raw_writel(balloon3_ctl_set,
+				BALLOON3_NAND_CONTROL_REG |
+				BALLOON3_FPGA_SETnCLR);
 	}
 
 	if (cmd != NAND_CMD_NONE)
@@ -601,15 +603,15 @@ static void balloon3_nand_select_chip(struct mtd_info *mtd, int chip)
 	if (chip < 0 || chip > 3)
 		return;
 
-	balloon3_ctl |= BALLOON3_NAND_CONTROL_FLCE0 |
-			BALLOON3_NAND_CONTROL_FLCE1 |
-			BALLOON3_NAND_CONTROL_FLCE2 |
-			BALLOON3_NAND_CONTROL_FLCE3;
+	/* Assert all nCE lines */
+	__raw_writew(
+		BALLOON3_NAND_CONTROL_FLCE0 | BALLOON3_NAND_CONTROL_FLCE1 |
+		BALLOON3_NAND_CONTROL_FLCE2 | BALLOON3_NAND_CONTROL_FLCE3,
+		BALLOON3_NAND_CONTROL_REG | BALLOON3_FPGA_SETnCLR);
 
 	/* Deassert correct nCE line */
-	balloon3_ctl &= ~(BALLOON3_NAND_CONTROL_FLCE0 << chip);
-
-	__raw_writew(balloon3_ctl, BALLOON3_NAND_CONTROL_REG);
+	__raw_writew(BALLOON3_NAND_CONTROL_FLCE0 << chip,
+		BALLOON3_NAND_CONTROL_REG);
 }
 
 static int balloon3_nand_probe(struct platform_device *pdev)
@@ -618,11 +620,12 @@ static int balloon3_nand_probe(struct platform_device *pdev)
 	uint16_t ver;
 	int ret;
 
-	__raw_writew(BALLOON3_NAND_CONTROL2_16BIT, BALLOON3_NAND_CONTROL2_REG);
+	__raw_writew(BALLOON3_NAND_CONTROL2_16BIT,
+		BALLOON3_NAND_CONTROL2_REG | BALLOON3_FPGA_SETnCLR);
 
 	ver = __raw_readw(BALLOON3_FPGA_VER);
-	if (ver > 0x0201)
-		pr_warn("The FPGA code, version 0x%04x, is newer than rel-0.3. "
+	if (ver < 0x4f08)
+		pr_warn("The FPGA code, version 0x%04x, is too old. "
 			"NAND support might be broken in this version!", ver);
 
 	/* Power up the NAND chips */
@@ -637,7 +640,11 @@ static int balloon3_nand_probe(struct platform_device *pdev)
 	gpio_set_value(BALLOON3_GPIO_RUN_NAND, 1);
 
 	/* Deassert all nCE lines and write protect line */
-	__raw_writel(balloon3_ctl, BALLOON3_NAND_CONTROL_REG);
+	__raw_writel(
+		BALLOON3_NAND_CONTROL_FLCE0 | BALLOON3_NAND_CONTROL_FLCE1 |
+		BALLOON3_NAND_CONTROL_FLCE2 | BALLOON3_NAND_CONTROL_FLCE3 |
+		BALLOON3_NAND_CONTROL_FLWP,
+		BALLOON3_NAND_CONTROL_REG | BALLOON3_FPGA_SETnCLR);
 	return 0;
 
 err2:
diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
index 3506da1..f6c81ea 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -26,6 +26,8 @@ enum balloon3_features {
 #define BALLOON3_FPGA_VIRT	(0xf1000000)	/* as per balloon2 */
 #define BALLOON3_FPGA_LENGTH	0x01000000
 
+#define	BALLOON3_FPGA_SETnCLR		(0x1000)
+
 /* FPGA / CPLD registers for CF socket */
 #define	BALLOON3_CF_STATUS_REG		(BALLOON3_FPGA_VIRT + 0x00e00008)
 #define	BALLOON3_CF_CONTROL_REG		(BALLOON3_FPGA_VIRT + 0x00e00008)
diff --git a/drivers/pcmcia/pxa2xx_balloon3.c b/drivers/pcmcia/pxa2xx_balloon3.c
index dbbdd00..453c54c 100644
--- a/drivers/pcmcia/pxa2xx_balloon3.c
+++ b/drivers/pcmcia/pxa2xx_balloon3.c
@@ -39,12 +39,10 @@ static struct pcmcia_irqs irqs[] = {
 static int balloon3_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	uint16_t ver;
-	int ret;
-	static void __iomem *fpga_ver;
 
 	ver = __raw_readw(BALLOON3_FPGA_VER);
-	if (ver > 0x0201)
-		pr_warn("The FPGA code, version 0x%04x, is newer than rel-0.3. "
+	if (ver < 0x4f08)
+		pr_warn("The FPGA code, version 0x%04x, is too old. "
 			"PCMCIA/CF support might be broken in this version!",
 			ver);
 
@@ -97,8 +95,9 @@ static void balloon3_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 static int balloon3_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 				       const socket_state_t *state)
 {
-	__raw_writew((state->flags & SS_RESET) ? BALLOON3_CF_RESET : 0,
-			BALLOON3_CF_CONTROL_REG);
+	__raw_writew(BALLOON3_CF_RESET, BALLOON3_CF_CONTROL_REG |
+			((state->flags & SS_RESET) ?
+			BALLOON3_FPGA_SETnCLR : 0));
 	return 0;
 }
 
-- 
1.7.1
