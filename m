From: ivan.khoronzhuk@ti.com (Khoronzhuk, Ivan)
Date: Mon, 11 Nov 2013 16:54:23 +0000
Subject: [PATCH 03/12] mtd: nand: davinci: simplify error handling
In-Reply-To: <1384187188-5776-4-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-4-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <4F5844B3A985794BA902E12C070812375F8CFB@DNCE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is not needed to use a lot of names for err handling.
It complicates code support and reading.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 drivers/mtd/nand/davinci_nand.c |   46 +++++++++++++++------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 8e1c88e..9bcbaa9 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -617,8 +617,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
        info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
        if (!info) {
                dev_err(&pdev->dev, "unable to allocate memory\n");
-               ret = -ENOMEM;
-               goto err_nomem;
+               return -ENOMEM;
        }

        platform_set_drvdata(pdev, info);
@@ -627,20 +626,16 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
        res2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
        if (!res1 || !res2) {
                dev_err(&pdev->dev, "resource missing\n");
-               ret = -EINVAL;
-               goto err_nomem;
+               return -EINVAL;
        }

        vaddr = devm_ioremap_resource(&pdev->dev, res1);
-       if (IS_ERR(vaddr)) {
-               ret = PTR_ERR(vaddr);
-               goto err_ioremap;
-       }
+       if (IS_ERR(vaddr))
+               return PTR_ERR(vaddr);
+
        base = devm_ioremap_resource(&pdev->dev, res2);
-       if (IS_ERR(base)) {
-               ret = PTR_ERR(base);
-               goto err_ioremap;
-       }
+       if (IS_ERR(base))
+               return PTR_ERR(base);

        info->dev               = &pdev->dev;
        info->base              = base;
@@ -707,7 +702,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
                        spin_unlock_irq(&davinci_nand_lock);

                        if (ret == -EBUSY)
-                               goto err_ecc;
+                               return ret;

                        info->chip.ecc.calculate = nand_davinci_calculate_4bit;
                        info->chip.ecc.correct = nand_davinci_correct_4bit;
@@ -723,8 +718,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
                info->chip.ecc.strength = pdata->ecc_bits;
                break;
        default:
-               ret = -EINVAL;
-               goto err_ecc;
+               return -EINVAL;
        }
        info->chip.ecc.mode = ecc_mode;

@@ -732,7 +726,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
        if (IS_ERR(info->clk)) {
                ret = PTR_ERR(info->clk);
                dev_dbg(&pdev->dev, "unable to get AEMIF clock, err %d\n", ret);
-               goto err_clk;
+               return ret;
        }

        ret = clk_prepare_enable(info->clk);
@@ -761,7 +755,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
                                                        info->core_chipsel);
        if (ret < 0) {
                dev_dbg(&pdev->dev, "NAND timing values setup fail\n");
-               goto err_timing;
+               goto err;
        }

        spin_lock_irq(&davinci_nand_lock);
@@ -777,7 +771,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
        ret = nand_scan_ident(&info->mtd, pdata->mask_chipsel ? 2 : 1, NULL);
        if (ret < 0) {
                dev_dbg(&pdev->dev, "no NAND chip(s) found\n");
-               goto err_scan;
+               goto err;
        }

        /* Update ECC layout if needed ... for 1-bit HW ECC, the default
@@ -791,7 +785,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
                if (!chunks || info->mtd.oobsize < 16) {
                        dev_dbg(&pdev->dev, "too small\n");
                        ret = -EINVAL;
-                       goto err_scan;
+                       goto err;
                }

                /* For small page chips, preserve the manufacturer's
@@ -822,7 +816,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
                dev_warn(&pdev->dev, "no 4-bit ECC support yet "
                                "for 4KiB-page NAND\n");
                ret = -EIO;
-               goto err_scan;
+               goto err;

 syndrome_done:
                info->chip.ecc.layout = &info->ecclayout;
@@ -830,7 +824,7 @@ syndrome_done:

        ret = nand_scan_tail(&info->mtd);
        if (ret < 0)
-               goto err_scan;
+               goto err;

        if (pdata->parts)
                ret = mtd_device_parse_register(&info->mtd, NULL, NULL,
@@ -843,7 +837,7 @@ syndrome_done:
                                                NULL, 0);
        }
        if (ret < 0)
-               goto err_scan;
+               goto err;

        val = davinci_nand_readl(info, NRCSR_OFFSET);
        dev_info(&pdev->dev, "controller rev. %d.%d\n",
@@ -851,8 +845,7 @@ syndrome_done:

        return 0;

-err_scan:
-err_timing:
+err:
        clk_disable_unprepare(info->clk);

 err_clk_enable:
@@ -860,11 +853,6 @@ err_clk_enable:
        if (ecc_mode == NAND_ECC_HW_SYNDROME)
                ecc4_busy = false;
        spin_unlock_irq(&davinci_nand_lock);
-
-err_ecc:
-err_clk:
-err_ioremap:
-err_nomem:
        return ret;
 }

--
1.7.9.5
