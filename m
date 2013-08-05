From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 5 Aug 2013 19:14:33 +0800
Subject: [PATCH 1/6] MTD: atmel_nand: use devm_xxx gpio kzalloc,
 gpio and ioremap
In-Reply-To: <1375701279-11495-1-git-send-email-josh.wu@atmel.com>
References: <1375701279-11495-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1375701279-11495-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

this will allow to simply the error and remove path

Cc: linux-mtd at lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
[josh.wu at atmel.com: fix checkpatch warnings and rebase to latest mtd git tree]
[josh.wu at atmel.com: replace devm_request_and_ioremap with devm_ioremap_resource]
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
v5 --> v6:
  rebase on top of l2-mtd.git.

v3 --> v4:
  use devm_ioremap_resource instead of devm_request_and_ioremap.

 drivers/mtd/nand/atmel_nand.c |  180 +++++++++++++++--------------------------
 1 file changed, 65 insertions(+), 115 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index a43adce..3d7db95 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -358,43 +358,34 @@ static void __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
 			table_size * sizeof(int16_t);
 }
 
-static void pmecc_data_free(struct atmel_nand_host *host)
-{
-	kfree(host->pmecc_partial_syn);
-	kfree(host->pmecc_si);
-	kfree(host->pmecc_lmu);
-	kfree(host->pmecc_smu);
-	kfree(host->pmecc_mu);
-	kfree(host->pmecc_dmu);
-	kfree(host->pmecc_delta);
-}
-
 static int pmecc_data_alloc(struct atmel_nand_host *host)
 {
 	const int cap = host->pmecc_corr_cap;
+	int size;
+
+	size = (2 * cap + 1) * sizeof(int16_t);
+	host->pmecc_partial_syn = devm_kzalloc(host->dev, size, GFP_KERNEL);
+	host->pmecc_si = devm_kzalloc(host->dev, size, GFP_KERNEL);
+	host->pmecc_lmu = devm_kzalloc(host->dev,
+			(cap + 1) * sizeof(int16_t), GFP_KERNEL);
+	host->pmecc_smu = devm_kzalloc(host->dev,
+			(cap + 2) * size, GFP_KERNEL);
+
+	size = (cap + 1) * sizeof(int);
+	host->pmecc_mu = devm_kzalloc(host->dev, size, GFP_KERNEL);
+	host->pmecc_dmu = devm_kzalloc(host->dev, size, GFP_KERNEL);
+	host->pmecc_delta = devm_kzalloc(host->dev, size, GFP_KERNEL);
+
+	if (!host->pmecc_partial_syn ||
+		!host->pmecc_si ||
+		!host->pmecc_lmu ||
+		!host->pmecc_smu ||
+		!host->pmecc_mu ||
+		!host->pmecc_dmu ||
+		!host->pmecc_delta)
+		return -ENOMEM;
 
-	host->pmecc_partial_syn = kzalloc((2 * cap + 1) * sizeof(int16_t),
-					GFP_KERNEL);
-	host->pmecc_si = kzalloc((2 * cap + 1) * sizeof(int16_t), GFP_KERNEL);
-	host->pmecc_lmu = kzalloc((cap + 1) * sizeof(int16_t), GFP_KERNEL);
-	host->pmecc_smu = kzalloc((cap + 2) * (2 * cap + 1) * sizeof(int16_t),
-					GFP_KERNEL);
-	host->pmecc_mu = kzalloc((cap + 1) * sizeof(int), GFP_KERNEL);
-	host->pmecc_dmu = kzalloc((cap + 1) * sizeof(int), GFP_KERNEL);
-	host->pmecc_delta = kzalloc((cap + 1) * sizeof(int), GFP_KERNEL);
-
-	if (host->pmecc_partial_syn &&
-			host->pmecc_si &&
-			host->pmecc_lmu &&
-			host->pmecc_smu &&
-			host->pmecc_mu &&
-			host->pmecc_dmu &&
-			host->pmecc_delta)
-		return 0;
-
-	/* error happened */
-	pmecc_data_free(host);
-	return -ENOMEM;
+	return 0;
 }
 
 static void pmecc_gen_syndrome(struct mtd_info *mtd, int sector)
@@ -1015,27 +1006,28 @@ static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
 		return 0;
 	}
 
-	host->ecc = ioremap(regs->start, resource_size(regs));
-	if (host->ecc == NULL) {
+	host->ecc = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(host->ecc)) {
 		dev_err(host->dev, "ioremap failed\n");
-		err_no = -EIO;
-		goto err_pmecc_ioremap;
+		err_no = PTR_ERR(host->ecc);
+		goto err;
 	}
 
 	regs_pmerr = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	regs_rom = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	if (regs_pmerr && regs_rom) {
-		host->pmerrloc_base = ioremap(regs_pmerr->start,
-			resource_size(regs_pmerr));
-		host->pmecc_rom_base = ioremap(regs_rom->start,
-			resource_size(regs_rom));
+	host->pmerrloc_base = devm_ioremap_resource(&pdev->dev, regs_pmerr);
+	if (IS_ERR(host->pmerrloc_base)) {
+		dev_err(host->dev,
+			"Can not get I/O resource for PMECC ERRLOC controller!\n");
+		err_no = PTR_ERR(host->pmerrloc_base);
+		goto err;
 	}
 
-	if (!host->pmerrloc_base || !host->pmecc_rom_base) {
-		dev_err(host->dev,
-			"Can not get I/O resource for PMECC ERRLOC controller or ROM!\n");
-		err_no = -EIO;
-		goto err_pmloc_ioremap;
+	regs_rom = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+	host->pmecc_rom_base = devm_ioremap_resource(&pdev->dev, regs_rom);
+	if (IS_ERR(host->pmecc_rom_base)) {
+		dev_err(host->dev, "Can not get I/O resource for ROM!\n");
+		err_no = PTR_ERR(host->pmecc_rom_base);
+		goto err;
 	}
 
 	/* ECC is calculated for the whole page (1 step) */
@@ -1060,7 +1052,7 @@ static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
 		if (nand_chip->ecc.bytes > mtd->oobsize - 2) {
 			dev_err(host->dev, "No room for ECC bytes\n");
 			err_no = -EINVAL;
-			goto err_no_ecc_room;
+			goto err;
 		}
 		pmecc_config_ecc_layout(&atmel_pmecc_oobinfo,
 					mtd->oobsize,
@@ -1085,7 +1077,7 @@ static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
 	if (err_no) {
 		dev_err(host->dev,
 				"Cannot allocate memory for PMECC computation!\n");
-		goto err_pmecc_data_alloc;
+		goto err;
 	}
 
 	nand_chip->ecc.read_page = atmel_nand_pmecc_read_page;
@@ -1095,15 +1087,7 @@ static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
 
 	return 0;
 
-err_pmecc_data_alloc:
-err_no_ecc_room:
-err_pmloc_ioremap:
-	iounmap(host->ecc);
-	if (host->pmerrloc_base)
-		iounmap(host->pmerrloc_base);
-	if (host->pmecc_rom_base)
-		iounmap(host->pmecc_rom_base);
-err_pmecc_ioremap:
+err:
 	return err_no;
 }
 
@@ -1407,10 +1391,10 @@ static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
 		return 0;
 	}
 
-	host->ecc = ioremap(regs->start, resource_size(regs));
-	if (host->ecc == NULL) {
+	host->ecc = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(host->ecc)) {
 		dev_err(host->dev, "ioremap failed\n");
-		return -EIO;
+		return PTR_ERR(host->ecc);
 	}
 
 	/* ECC is calculated for the whole page (1 step) */
@@ -1464,27 +1448,21 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	struct mtd_part_parser_data ppdata = {};
 	int res;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		printk(KERN_ERR "atmel_nand: can't get I/O resource mem\n");
-		return -ENXIO;
-	}
-
 	/* Allocate memory for the device structure (and zero it) */
-	host = kzalloc(sizeof(struct atmel_nand_host), GFP_KERNEL);
+	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
 	if (!host) {
 		printk(KERN_ERR "atmel_nand: failed to allocate device structure.\n");
 		return -ENOMEM;
 	}
 
-	host->io_phys = (dma_addr_t)mem->start;
-
-	host->io_base = ioremap(mem->start, resource_size(mem));
-	if (host->io_base == NULL) {
-		printk(KERN_ERR "atmel_nand: ioremap failed\n");
-		res = -EIO;
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	host->io_base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(host->io_base)) {
+		dev_err(&pdev->dev, "atmel_nand: ioremap resource failed\n");
+		res = PTR_ERR(host->io_base);
 		goto err_nand_ioremap;
 	}
+	host->io_phys = (dma_addr_t)mem->start;
 
 	mtd = &host->mtd;
 	nand_chip = &host->nand_chip;
@@ -1492,7 +1470,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node) {
 		res = atmel_of_init_port(host, pdev->dev.of_node);
 		if (res)
-			goto err_ecc_ioremap;
+			goto err_nand_ioremap;
 	} else {
 		memcpy(&host->board, pdev->dev.platform_data,
 		       sizeof(struct atmel_nand_data));
@@ -1508,12 +1486,13 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	nand_chip->cmd_ctrl = atmel_nand_cmd_ctrl;
 
 	if (gpio_is_valid(host->board.rdy_pin)) {
-		res = gpio_request(host->board.rdy_pin, "nand_rdy");
+		res = devm_gpio_request(&pdev->dev,
+				host->board.rdy_pin, "nand_rdy");
 		if (res < 0) {
 			dev_err(&pdev->dev,
 				"can't request rdy gpio %d\n",
 				host->board.rdy_pin);
-			goto err_ecc_ioremap;
+			goto err_nand_ioremap;
 		}
 
 		res = gpio_direction_input(host->board.rdy_pin);
@@ -1521,19 +1500,20 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"can't request input direction rdy gpio %d\n",
 				host->board.rdy_pin);
-			goto err_ecc_ioremap;
+			goto err_nand_ioremap;
 		}
 
 		nand_chip->dev_ready = atmel_nand_device_ready;
 	}
 
 	if (gpio_is_valid(host->board.enable_pin)) {
-		res = gpio_request(host->board.enable_pin, "nand_enable");
+		res = devm_gpio_request(&pdev->dev,
+				host->board.enable_pin, "nand_enable");
 		if (res < 0) {
 			dev_err(&pdev->dev,
 				"can't request enable gpio %d\n",
 				host->board.enable_pin);
-			goto err_ecc_ioremap;
+			goto err_nand_ioremap;
 		}
 
 		res = gpio_direction_output(host->board.enable_pin, 1);
@@ -1541,7 +1521,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"can't request output direction enable gpio %d\n",
 				host->board.enable_pin);
-			goto err_ecc_ioremap;
+			goto err_nand_ioremap;
 		}
 	}
 
@@ -1558,7 +1538,8 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	atmel_nand_enable(host);
 
 	if (gpio_is_valid(host->board.det_pin)) {
-		res = gpio_request(host->board.det_pin, "nand_det");
+		res = devm_gpio_request(&pdev->dev,
+				host->board.det_pin, "nand_det");
 		if (res < 0) {
 			dev_err(&pdev->dev,
 				"can't request det gpio %d\n",
@@ -1636,26 +1617,15 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 		return res;
 
 err_scan_tail:
-	if (host->has_pmecc && host->nand_chip.ecc.mode == NAND_ECC_HW) {
+	if (host->has_pmecc && host->nand_chip.ecc.mode == NAND_ECC_HW)
 		pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
-		pmecc_data_free(host);
-	}
-	if (host->ecc)
-		iounmap(host->ecc);
-	if (host->pmerrloc_base)
-		iounmap(host->pmerrloc_base);
-	if (host->pmecc_rom_base)
-		iounmap(host->pmecc_rom_base);
 err_hw_ecc:
 err_scan_ident:
 err_no_card:
 	atmel_nand_disable(host);
 	if (host->dma_chan)
 		dma_release_channel(host->dma_chan);
-err_ecc_ioremap:
-	iounmap(host->io_base);
 err_nand_ioremap:
-	kfree(host);
 	return res;
 }
 
@@ -1675,31 +1645,11 @@ static int __exit atmel_nand_remove(struct platform_device *pdev)
 		pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
 		pmerrloc_writel(host->pmerrloc_base, ELDIS,
 				PMERRLOC_DISABLE);
-		pmecc_data_free(host);
 	}
 
-	if (gpio_is_valid(host->board.det_pin))
-		gpio_free(host->board.det_pin);
-
-	if (gpio_is_valid(host->board.enable_pin))
-		gpio_free(host->board.enable_pin);
-
-	if (gpio_is_valid(host->board.rdy_pin))
-		gpio_free(host->board.rdy_pin);
-
-	if (host->ecc)
-		iounmap(host->ecc);
-	if (host->pmecc_rom_base)
-		iounmap(host->pmecc_rom_base);
-	if (host->pmerrloc_base)
-		iounmap(host->pmerrloc_base);
-
 	if (host->dma_chan)
 		dma_release_channel(host->dma_chan);
 
-	iounmap(host->io_base);
-	kfree(host);
-
 	return 0;
 }
 
-- 
1.7.9.5
