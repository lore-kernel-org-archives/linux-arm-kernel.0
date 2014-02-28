From: herve.codina@celad.com (Herve Codina)
Date: Fri, 28 Feb 2014 16:53:44 +0100
Subject: nand pmecc crash detected
Message-ID: <5310B108.8040800@celad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am using an sam5d35 and its pmecc nand ecc controller.

In barebox, using similar atmel_nand.c the system crashes.

The problem was a call to chip->ecc.hwctl from nand_write_subpage_hwecc
(nand_base.c) when we write a sub page.

chip->ecc.hwctl function is not set when we are using PMECC controller.

As a workaround, i set NAND_NO_SUBPAGE_WRITE for PMECC controller in
order to disable sub page access in nand_write_page.

I think we can have the same problem in Linux. I do not performed
subpage nand writes from Linux but i made the following patch according
to my Barebox defect.

Here after are my patches (same modification) for 1st my local Barebox
and 2nd my local Linux :

---8<-------------------
>From 757e8dbf141619a55b7a5b1ca11780b2589eacc1 Mon Sep 17 00:00:00 2001
From: Herve Codina <Herve.CODINA@celad.com>
Date: Fri, 28 Feb 2014 08:39:08 +0100
Subject: [PATCH 5/5] Disable Subpage nand write when using Atmel PMECC.


Signed-off-by: Herve Codina <Herve.CODINA@celad.com>
---
 drivers/mtd/nand/atmel_nand.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 2ff7427..cdbe685 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -837,6 +837,7 @@ static int __init
atmel_pmecc_nand_init_params(struct device_d *dev,
 		return err_no;
 	}

+	nand_chip->options |= NAND_NO_SUBPAGE_WRITE;
 	nand_chip->ecc.read_page = atmel_nand_pmecc_read_page;
 	nand_chip->ecc.write_page = atmel_nand_pmecc_write_page;

-- 
1.7.9.5

---8<-------------------


---8<-------------------
>From bd6a9645841d74611a5be44a60c9c41b2bca9c19 Mon Sep 17 00:00:00 2001
From: Herve Codina <Herve.CODINA@celad.com>
Date: Fri, 28 Feb 2014 08:28:07 +0100
Subject: [PATCH 4/4] Disable Subpage nand write when using Atmel PMECC.


Signed-off-by: Herve Codina <Herve.CODINA@celad.com>
---
 drivers/mtd/nand/atmel_nand.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 5a36a7d..1340a7b 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1249,6 +1249,7 @@ static int __init
atmel_pmecc_nand_init_params(struct platform_device *pdev,
 		goto err;
 	}

+	nand_chip->options |= NAND_NO_SUBPAGE_WRITE;
 	nand_chip->ecc.read_page = atmel_nand_pmecc_read_page;
 	nand_chip->ecc.write_page = atmel_nand_pmecc_write_page;

-- 
1.7.9.5

---8<-------------------

Can you review/integrate these patches in Barebox / Linux ?


Best regards,
Herv? Codina
