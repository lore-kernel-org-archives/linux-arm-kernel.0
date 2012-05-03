From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu,  3 May 2012 17:59:24 -0400
Subject: [PATCH] ARM: fix swizzle build failure in integrator platform
Message-ID: <1336082364-27611-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 466b8cb9ef7d64efb7aeadc802239e7af754b053 (linux-next)

    "ARM: PCI: get rid of pci_std_swizzle()"

deleted this line:

    #define pci_std_swizzle pci_common_swizzle

but the integrator was still using the std variant,
causing the build failure:

arch/arm/mach-integrator/pci.c:76:2: error: implicit declaration of function 'pci_std_swizzle'

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/arm/mach-integrator/pci.c b/arch/arm/mach-integrator/pci.c
index 40f4b4f..6c1667e 100644
--- a/arch/arm/mach-integrator/pci.c
+++ b/arch/arm/mach-integrator/pci.c
@@ -73,7 +73,7 @@ static u8 __init integrator_swizzle(struct pci_dev *dev, u8 *pinp)
 	if (*pinp == 0)
 		*pinp = 1;
 
-	return pci_std_swizzle(dev, pinp);
+	return pci_common_swizzle(dev, pinp);
 }
 
 static int irq_tab[4] __initdata = {
-- 
1.7.9.1
