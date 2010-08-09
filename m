From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 15:20:47 +0200
Subject: [PATCH 03/12] mxc_nand: make some internally used functions
	overwriteable
In-Reply-To: <1281360053-8386-1-git-send-email-s.hauer@pengutronix.de>
References: <1281360053-8386-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281360053-8386-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch prepares the driver to add v3 controller support
later. The v3 controller is basically the same controller as v1
and v2, but with a completely different register layout.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   72 ++++++++++++++++++++++++++----------------
 1 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 6654446..2d2e2e7 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -115,6 +115,13 @@ struct mxc_nand_host {
 	uint8_t			*data_buf;
 	unsigned int		buf_start;
 	int			spare_len;
+
+	void			(*preset)(struct mtd_info *);
+	void			(*send_cmd)(struct mxc_nand_host *, uint16_t, int);
+	void			(*send_addr)(struct mxc_nand_host *, uint16_t, int);
+	void			(*send_page)(struct mtd_info *, unsigned int);
+	void			(*send_read_id)(struct mxc_nand_host *);
+	uint16_t		(*get_dev_status)(struct mxc_nand_host *);
 };
 
 /* OOB placement block for use with hardware ecc generation */
@@ -212,7 +219,7 @@ static void wait_op_done(struct mxc_nand_host *host, int useirq)
 
 /* This function issues the specified command to the NAND device and
  * waits for completion. */
-static void send_cmd(struct mxc_nand_host *host, uint16_t cmd, int useirq)
+static void send_cmd_v1_v2(struct mxc_nand_host *host, uint16_t cmd, int useirq)
 {
 	DEBUG(MTD_DEBUG_LEVEL3, "send_cmd(host, 0x%x, %d)\n", cmd, useirq);
 
@@ -241,7 +248,7 @@ static void send_cmd(struct mxc_nand_host *host, uint16_t cmd, int useirq)
 /* This function sends an address (or partial address) to the
  * NAND device. The address is used to select the source/destination for
  * a NAND command. */
-static void send_addr(struct mxc_nand_host *host, uint16_t addr, int islast)
+static void send_addr_v1_v2(struct mxc_nand_host *host, uint16_t addr, int islast)
 {
 	DEBUG(MTD_DEBUG_LEVEL3, "send_addr(host, 0x%x %d)\n", addr, islast);
 
@@ -252,7 +259,7 @@ static void send_addr(struct mxc_nand_host *host, uint16_t addr, int islast)
 	wait_op_done(host, islast);
 }
 
-static void send_page(struct mtd_info *mtd, unsigned int ops)
+static void send_page_v1_v2(struct mtd_info *mtd, unsigned int ops)
 {
 	struct nand_chip *nand_chip = mtd->priv;
 	struct mxc_nand_host *host = nand_chip->priv;
@@ -276,7 +283,7 @@ static void send_page(struct mtd_info *mtd, unsigned int ops)
 }
 
 /* Request the NANDFC to perform a read of the NAND device ID. */
-static void send_read_id(struct mxc_nand_host *host)
+static void send_read_id_v1_v2(struct mxc_nand_host *host)
 {
 	struct nand_chip *this = &host->nand;
 
@@ -302,7 +309,7 @@ static void send_read_id(struct mxc_nand_host *host)
 
 /* This function requests the NANDFC to perform a read of the
  * NAND device status and returns the current status. */
-static uint16_t get_dev_status(struct mxc_nand_host *host)
+static uint16_t get_dev_status_v1_v2(struct mxc_nand_host *host)
 {
 	void __iomem *main_buf = host->main_area0;
 	uint32_t store;
@@ -381,7 +388,7 @@ static u_char mxc_nand_read_byte(struct mtd_info *mtd)
 
 	/* Check for status request */
 	if (host->status_request)
-		return get_dev_status(host) & 0xFF;
+		return host->get_dev_status(host) & 0xFF;
 
 	ret = *(uint8_t *)(host->data_buf + host->buf_start);
 	host->buf_start++;
@@ -517,39 +524,39 @@ static void mxc_do_addr_cycle(struct mtd_info *mtd, int column, int page_addr)
 		 * we will used the saved column address to index into
 		 * the full page.
 		 */
-		send_addr(host, 0, page_addr == -1);
+		host->send_addr(host, 0, page_addr == -1);
 		if (mtd->writesize > 512)
 			/* another col addr cycle for 2k page */
-			send_addr(host, 0, false);
+			host->send_addr(host, 0, false);
 	}
 
 	/* Write out page address, if necessary */
 	if (page_addr != -1) {
 		/* paddr_0 - p_addr_7 */
-		send_addr(host, (page_addr & 0xff), false);
+		host->send_addr(host, (page_addr & 0xff), false);
 
 		if (mtd->writesize > 512) {
 			if (mtd->size >= 0x10000000) {
 				/* paddr_8 - paddr_15 */
-				send_addr(host, (page_addr >> 8) & 0xff, false);
-				send_addr(host, (page_addr >> 16) & 0xff, true);
+				host->send_addr(host, (page_addr >> 8) & 0xff, false);
+				host->send_addr(host, (page_addr >> 16) & 0xff, true);
 			} else
 				/* paddr_8 - paddr_15 */
-				send_addr(host, (page_addr >> 8) & 0xff, true);
+				host->send_addr(host, (page_addr >> 8) & 0xff, true);
 		} else {
 			/* One more address cycle for higher density devices */
 			if (mtd->size >= 0x4000000) {
 				/* paddr_8 - paddr_15 */
-				send_addr(host, (page_addr >> 8) & 0xff, false);
-				send_addr(host, (page_addr >> 16) & 0xff, true);
+				host->send_addr(host, (page_addr >> 8) & 0xff, false);
+				host->send_addr(host, (page_addr >> 16) & 0xff, true);
 			} else
 				/* paddr_8 - paddr_15 */
-				send_addr(host, (page_addr >> 8) & 0xff, true);
+				host->send_addr(host, (page_addr >> 8) & 0xff, true);
 		}
 	}
 }
 
-static void preset(struct mtd_info *mtd)
+static void preset_v1_v2(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd->priv;
 	struct mxc_nand_host *host = nand_chip->priv;
@@ -602,15 +609,15 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 	/* Command pre-processing step */
 	switch (command) {
 	case NAND_CMD_RESET:
-		send_cmd(host, command, false);
-		preset(mtd);
+		host->send_cmd(host, command, false);
+		host->preset(mtd);
 		break;
 
 	case NAND_CMD_STATUS:
 		host->buf_start = 0;
 		host->status_request = true;
 
-		send_cmd(host, command, true);
+		host->send_cmd(host, command, true);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 		break;
 
@@ -623,13 +630,13 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 
 		command = NAND_CMD_READ0; /* only READ0 is valid */
 
-		send_cmd(host, command, false);
+		host->send_cmd(host, command, false);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 
 		if (mtd->writesize > 512)
-			send_cmd(host, NAND_CMD_READSTART, true);
+			host->send_cmd(host, NAND_CMD_READSTART, true);
 
-		send_page(mtd, NFC_OUTPUT);
+		host->send_page(mtd, NFC_OUTPUT);
 
 		memcpy(host->data_buf, host->main_area0, mtd->writesize);
 		copy_spare(mtd, true);
@@ -642,28 +649,28 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 
 		host->buf_start = column;
 
-		send_cmd(host, command, false);
+		host->send_cmd(host, command, false);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 		break;
 
 	case NAND_CMD_PAGEPROG:
 		memcpy(host->main_area0, host->data_buf, mtd->writesize);
 		copy_spare(mtd, false);
-		send_page(mtd, NFC_INPUT);
-		send_cmd(host, command, true);
+		host->send_page(mtd, NFC_INPUT);
+		host->send_cmd(host, command, true);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 		break;
 
 	case NAND_CMD_READID:
-		send_cmd(host, command, true);
+		host->send_cmd(host, command, true);
 		mxc_do_addr_cycle(mtd, column, page_addr);
-		send_read_id(host);
+		host->send_read_id(host);
 		host->buf_start = column;
 		break;
 
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
-		send_cmd(host, command, false);
+		host->send_cmd(host, command, false);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 
 		break;
@@ -760,6 +767,15 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 
 	host->main_area0 = host->base;
 
+	if (nfc_is_v1() || nfc_is_v21()) {
+		host->preset = preset_v1_v2;
+		host->send_cmd = send_cmd_v1_v2;
+		host->send_addr = send_addr_v1_v2;
+		host->send_page = send_page_v1_v2;
+		host->send_read_id = send_read_id_v1_v2;
+		host->get_dev_status = get_dev_status_v1_v2;
+	}
+
 	if (nfc_is_v21()) {
 		host->regs = host->base + 0x1e00;
 		host->spare0 = host->base + 0x1000;
-- 
1.7.1
