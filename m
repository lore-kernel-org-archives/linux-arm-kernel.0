From: banajit.g@samsung.com (Banajit Goswami)
Date: Tue, 19 Jul 2011 17:35:04 +0530
Subject: [PATCH 5/7] ARM: SAMSUNG: Use generic s3c_set_platdata for NAND
In-Reply-To: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
References: <1311077106-28351-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1311077106-28351-6-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call the generic s3c_set_platdata to set NAND platdata

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/plat-samsung/dev-nand.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-nand.c b/arch/arm/plat-samsung/dev-nand.c
index 6927ae8..b8e30ec 100644
--- a/arch/arm/plat-samsung/dev-nand.c
+++ b/arch/arm/plat-samsung/dev-nand.c
@@ -91,11 +91,10 @@ void __init s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
 	 * time then there is little chance the system is going to run.
 	 */ 
 
-	npd = kmemdup(nand, sizeof(struct s3c2410_platform_nand), GFP_KERNEL);
-	if (!npd) {
-		printk(KERN_ERR "%s: failed copying platform data\n", __func__);
+	npd = s3c_set_platdata(nand, sizeof(struct s3c2410_platform_nand),
+				&s3c_device_nand);
+	if (!npd)
 		return;
-	}
 
 	/* now see if we need to copy any of the nand set data */
 
@@ -123,6 +122,4 @@ void __init s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
 			to++;
 		}
 	}
-
-	s3c_device_nand.dev.platform_data = npd;
 }
-- 
1.7.2.3
