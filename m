From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Nov 2010 17:14:10 +0100
Subject: [PATCH 1/2] dmaengine i.MX SDMA: Allow to run without firmware
In-Reply-To: <1288887251-31851-1-git-send-email-s.hauer@pengutronix.de>
References: <1288887251-31851-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1288887251-31851-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDMA firmware consists of a ROM part and a RAM part.
The ROM part is always present in the SDMA engine and
is sufficient for many cases.
This patch allows to pass in platform data containing
the script addresses in ROM, so loading a firmware is
optional now.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/sdma.h |   46 +++++++++
 drivers/dma/imx-sdma.c                |  174 +++++++++++++++------------------
 2 files changed, 124 insertions(+), 96 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/sdma.h b/arch/arm/plat-mxc/include/mach/sdma.h
index 9be1122..913e043 100644
--- a/arch/arm/plat-mxc/include/mach/sdma.h
+++ b/arch/arm/plat-mxc/include/mach/sdma.h
@@ -2,16 +2,62 @@
 #define __MACH_MXC_SDMA_H__
 
 /**
+ * struct sdma_script_start_addrs - SDMA script start pointers
+ *
+ * start addresses of the different functions in the physical
+ * address space of the SDMA engine.
+ */
+struct sdma_script_start_addrs {
+	s32 ap_2_ap_addr;
+	s32 ap_2_bp_addr;
+	s32 ap_2_ap_fixed_addr;
+	s32 bp_2_ap_addr;
+	s32 loopback_on_dsp_side_addr;
+	s32 mcu_interrupt_only_addr;
+	s32 firi_2_per_addr;
+	s32 firi_2_mcu_addr;
+	s32 per_2_firi_addr;
+	s32 mcu_2_firi_addr;
+	s32 uart_2_per_addr;
+	s32 uart_2_mcu_addr;
+	s32 per_2_app_addr;
+	s32 mcu_2_app_addr;
+	s32 per_2_per_addr;
+	s32 uartsh_2_per_addr;
+	s32 uartsh_2_mcu_addr;
+	s32 per_2_shp_addr;
+	s32 mcu_2_shp_addr;
+	s32 ata_2_mcu_addr;
+	s32 mcu_2_ata_addr;
+	s32 app_2_per_addr;
+	s32 app_2_mcu_addr;
+	s32 shp_2_per_addr;
+	s32 shp_2_mcu_addr;
+	s32 mshc_2_mcu_addr;
+	s32 mcu_2_mshc_addr;
+	s32 spdif_2_mcu_addr;
+	s32 mcu_2_spdif_addr;
+	s32 asrc_2_mcu_addr;
+	s32 ext_mem_2_ipu_addr;
+	s32 descrambler_addr;
+	s32 dptc_dvfs_addr;
+	s32 utra_addr;
+	s32 ram_code_start_addr;
+};
+
+/**
  * struct sdma_platform_data - platform specific data for SDMA engine
  *
  * @sdma_version	The version of this SDMA engine
  * @cpu_name		used to generate the firmware name
  * @to_version		CPU Tape out version
+ * @script_addrs	SDMA scripts addresses in SDMA ROM
  */
 struct sdma_platform_data {
 	int sdma_version;
 	char *cpu_name;
 	int to_version;
+	struct sdma_script_start_addrs *script_addrs;
 };
 
 #endif /* __MACH_MXC_SDMA_H__ */
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 0834323..01166a9 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -273,50 +273,6 @@ struct sdma_channel {
 #define MXC_SDMA_MIN_PRIORITY 1
 #define MXC_SDMA_MAX_PRIORITY 7
 
-/**
- * struct sdma_script_start_addrs - SDMA script start pointers
- *
- * start addresses of the different functions in the physical
- * address space of the SDMA engine.
- */
-struct sdma_script_start_addrs {
-	u32 ap_2_ap_addr;
-	u32 ap_2_bp_addr;
-	u32 ap_2_ap_fixed_addr;
-	u32 bp_2_ap_addr;
-	u32 loopback_on_dsp_side_addr;
-	u32 mcu_interrupt_only_addr;
-	u32 firi_2_per_addr;
-	u32 firi_2_mcu_addr;
-	u32 per_2_firi_addr;
-	u32 mcu_2_firi_addr;
-	u32 uart_2_per_addr;
-	u32 uart_2_mcu_addr;
-	u32 per_2_app_addr;
-	u32 mcu_2_app_addr;
-	u32 per_2_per_addr;
-	u32 uartsh_2_per_addr;
-	u32 uartsh_2_mcu_addr;
-	u32 per_2_shp_addr;
-	u32 mcu_2_shp_addr;
-	u32 ata_2_mcu_addr;
-	u32 mcu_2_ata_addr;
-	u32 app_2_per_addr;
-	u32 app_2_mcu_addr;
-	u32 shp_2_per_addr;
-	u32 shp_2_mcu_addr;
-	u32 mshc_2_mcu_addr;
-	u32 mcu_2_mshc_addr;
-	u32 spdif_2_mcu_addr;
-	u32 mcu_2_spdif_addr;
-	u32 asrc_2_mcu_addr;
-	u32 ext_mem_2_ipu_addr;
-	u32 descrambler_addr;
-	u32 dptc_dvfs_addr;
-	u32 utra_addr;
-	u32 ram_code_start_addr;
-};
-
 #define SDMA_FIRMWARE_MAGIC 0x414d4453
 
 /**
@@ -1127,8 +1083,74 @@ static void sdma_issue_pending(struct dma_chan *chan)
 	 */
 }
 
-static int __init sdma_init(struct sdma_engine *sdma,
-		void *ram_code, int ram_code_size)
+#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
+
+static void sdma_add_scripts(struct sdma_engine *sdma,
+		const struct sdma_script_start_addrs *addr)
+{
+	s32 *addr_arr = (u32 *)addr;
+	s32 *saddr_arr = (u32 *)sdma->script_addrs;
+	int i;
+
+	for (i = 0; i < SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1; i++)
+		if (addr_arr[i] > 0)
+			saddr_arr[i] = addr_arr[i];
+}
+
+static int __init sdma_get_firmware(struct sdma_engine *sdma,
+		const char *cpu_name, int to_version)
+{
+	const struct firmware *fw;
+	char *fwname;
+	const struct sdma_firmware_header *header;
+	int ret;
+	const struct sdma_script_start_addrs *addr;
+	unsigned short *ram_code;
+
+	fwname = kasprintf(GFP_KERNEL, "sdma-%s-to%d.bin", cpu_name, to_version);
+	if (!fwname)
+		return -ENOMEM;
+
+	ret = request_firmware(&fw, fwname, sdma->dev);
+	if (ret) {
+		kfree(fwname);
+		return ret;
+	}
+	kfree(fwname);
+
+	if (fw->size < sizeof(*header))
+		goto err_firmware;
+
+	header = (struct sdma_firmware_header *)fw->data;
+
+	if (header->magic != SDMA_FIRMWARE_MAGIC)
+		goto err_firmware;
+	if (header->ram_code_start + header->ram_code_size > fw->size)
+		goto err_firmware;
+
+	addr = (void *)header + header->script_addrs_start;
+	ram_code = (void *)header + header->ram_code_start;
+
+	clk_enable(sdma->clk);
+	/* download the RAM image for SDMA */
+	sdma_load_script(sdma, ram_code,
+			header->ram_code_size,
+			sdma->script_addrs->ram_code_start_addr);
+	clk_disable(sdma->clk);
+
+	sdma_add_scripts(sdma, addr);
+
+	dev_info(sdma->dev, "loaded firmware %d.%d\n",
+			header->version_major,
+			header->version_minor);
+
+err_firmware:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int __init sdma_init(struct sdma_engine *sdma)
 {
 	int i, ret;
 	dma_addr_t ccb_phys;
@@ -1192,11 +1214,6 @@ static int __init sdma_init(struct sdma_engine *sdma,
 
 	__raw_writel(ccb_phys, sdma->regs + SDMA_H_C0PTR);
 
-	/* download the RAM image for SDMA */
-	sdma_load_script(sdma, ram_code,
-			ram_code_size,
-			sdma->script_addrs->ram_code_start_addr);
-
 	/* Set bits of CONFIG register with given context switching mode */
 	__raw_writel(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
 
@@ -1216,14 +1233,9 @@ err_dma_alloc:
 static int __init sdma_probe(struct platform_device *pdev)
 {
 	int ret;
-	const struct firmware *fw;
-	const struct sdma_firmware_header *header;
-	const struct sdma_script_start_addrs *addr;
 	int irq;
-	unsigned short *ram_code;
 	struct resource *iores;
 	struct sdma_platform_data *pdata = pdev->dev.platform_data;
-	char *fwname;
 	int i;
 	dma_cap_mask_t mask;
 	struct sdma_engine *sdma;
@@ -1262,38 +1274,9 @@ static int __init sdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_request_irq;
 
-	fwname = kasprintf(GFP_KERNEL, "sdma-%s-to%d.bin",
-			pdata->cpu_name, pdata->to_version);
-	if (!fwname) {
-		ret = -ENOMEM;
-		goto err_cputype;
-	}
-
-	ret = request_firmware(&fw, fwname, &pdev->dev);
-	if (ret) {
-		dev_err(&pdev->dev, "request firmware \"%s\" failed with %d\n",
-				fwname, ret);
-		kfree(fwname);
-		goto err_cputype;
-	}
-	kfree(fwname);
-
-	if (fw->size < sizeof(*header))
-		goto err_firmware;
-
-	header = (struct sdma_firmware_header *)fw->data;
-
-	if (header->magic != SDMA_FIRMWARE_MAGIC)
-		goto err_firmware;
-	if (header->ram_code_start + header->ram_code_size > fw->size)
-		goto err_firmware;
-
-	addr = (void *)header + header->script_addrs_start;
-	ram_code = (void *)header + header->ram_code_start;
-	sdma->script_addrs = kmalloc(sizeof(*addr), GFP_KERNEL);
+	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
 	if (!sdma->script_addrs)
-		goto err_firmware;
-	memcpy(sdma->script_addrs, addr, sizeof(*addr));
+		goto err_alloc;
 
 	sdma->version = pdata->sdma_version;
 
@@ -1316,10 +1299,15 @@ static int __init sdma_probe(struct platform_device *pdev)
 		list_add_tail(&sdmac->chan.device_node, &sdma->dma_device.channels);
 	}
 
-	ret = sdma_init(sdma, ram_code, header->ram_code_size);
+	ret = sdma_init(sdma);
 	if (ret)
 		goto err_init;
 
+	if (pdata->script_addrs)
+		sdma_add_scripts(sdma, pdata->script_addrs);
+
+	sdma_get_firmware(sdma, pdata->cpu_name, pdata->to_version);
+
 	sdma->dma_device.dev = &pdev->dev;
 
 	sdma->dma_device.device_alloc_chan_resources = sdma_alloc_chan_resources;
@@ -1336,10 +1324,6 @@ static int __init sdma_probe(struct platform_device *pdev)
 		goto err_init;
 	}
 
-	dev_info(&pdev->dev, "initialized (firmware %d.%d)\n",
-			header->version_major,
-			header->version_minor);
-
 	/* request channel 0. This is an internal control channel
 	 * to the SDMA engine and not available to clients.
 	 */
@@ -1347,15 +1331,13 @@ static int __init sdma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SLAVE, mask);
 	dma_request_channel(mask, NULL, NULL);
 
-	release_firmware(fw);
+	dev_info(sdma->dev, "initialized\n");
 
 	return 0;
 
 err_init:
 	kfree(sdma->script_addrs);
-err_firmware:
-	release_firmware(fw);
-err_cputype:
+err_alloc:
 	free_irq(irq, sdma);
 err_request_irq:
 	iounmap(sdma->regs);
-- 
1.7.2.3
