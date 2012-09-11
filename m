From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:24 +0200
Subject: [PATCH v4 11/17] arm: plat-orion: use void __iomem pointers for MPP
 functions
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-12-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The registration function for MPP now takes void __iomem pointers, so
we remove the temporary "unsigned long" casts from the mach-*/mpp.c
files.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/mpp.c               |    3 +--
 arch/arm/mach-kirkwood/mpp.c           |    3 +--
 arch/arm/mach-mv78xx0/mpp.c            |    3 +--
 arch/arm/mach-orion5x/mpp.c            |    3 +--
 arch/arm/plat-orion/include/plat/mpp.h |    2 +-
 arch/arm/plat-orion/mpp.c              |    6 +++---
 6 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-dove/mpp.c
index fc04ebe..7f70afc 100644
--- a/arch/arm/mach-dove/mpp.c
+++ b/arch/arm/mach-dove/mpp.c
@@ -151,8 +151,7 @@ void __init dove_mpp_conf(unsigned int *mpp_list,
 	dove_mpp_dump_regs();
 
 	/* Use platform code for pins 0-23 */
-	orion_mpp_conf(mpp_list, 0, MPP_MAX,
-		       (unsigned long) DOVE_MPP_VIRT_BASE);
+	orion_mpp_conf(mpp_list, 0, MPP_MAX, DOVE_MPP_VIRT_BASE);
 
 	dove_mpp_conf_grp(mpp_grp_list);
 	dove_mpp_cfg_au1(grp_au1_52_57);
diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
index 6774279..0c6ad63 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-kirkwood/mpp.c
@@ -38,6 +38,5 @@ static unsigned int __init kirkwood_variant(void)
 void __init kirkwood_mpp_conf(unsigned int *mpp_list)
 {
 	orion_mpp_conf(mpp_list, kirkwood_variant(),
-		       MPP_MAX,
-		       (unsigned long) DEV_BUS_VIRT_BASE);
+		       MPP_MAX, DEV_BUS_VIRT_BASE);
 }
diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-mv78xx0/mpp.c
index 4da82f8..df50342 100644
--- a/arch/arm/mach-mv78xx0/mpp.c
+++ b/arch/arm/mach-mv78xx0/mpp.c
@@ -33,6 +33,5 @@ static unsigned int __init mv78xx0_variant(void)
 void __init mv78xx0_mpp_conf(unsigned int *mpp_list)
 {
 	orion_mpp_conf(mpp_list, mv78xx0_variant(),
-		       MPP_MAX,
-		       (unsigned long) DEV_BUS_VIRT_BASE);
+		       MPP_MAX, DEV_BUS_VIRT_BASE);
 }
diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion5x/mpp.c
index 30f5ef6..5b70026 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion5x/mpp.c
@@ -40,6 +40,5 @@ static unsigned int __init orion5x_variant(void)
 void __init orion5x_mpp_conf(unsigned int *mpp_list)
 {
 	orion_mpp_conf(mpp_list, orion5x_variant(),
-		       MPP_MAX,
-		       (unsigned long) ORION5X_DEV_BUS_VIRT_BASE);
+		       MPP_MAX, ORION5X_DEV_BUS_VIRT_BASE);
 }
diff --git a/arch/arm/plat-orion/include/plat/mpp.h b/arch/arm/plat-orion/include/plat/mpp.h
index 723adce..254552f 100644
--- a/arch/arm/plat-orion/include/plat/mpp.h
+++ b/arch/arm/plat-orion/include/plat/mpp.h
@@ -29,6 +29,6 @@
 #define MPP_OUTPUT_MASK		GENERIC_MPP(0, 0x0, 0, 1)
 
 void __init orion_mpp_conf(unsigned int *mpp_list, unsigned int variant_mask,
-			   unsigned int mpp_max, unsigned int dev_bus);
+			   unsigned int mpp_max, void __iomem *dev_bus);
 
 #endif
diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/plat-orion/mpp.c
index 3b1e17b..20d4208 100644
--- a/arch/arm/plat-orion/mpp.c
+++ b/arch/arm/plat-orion/mpp.c
@@ -17,15 +17,15 @@
 #include <plat/mpp.h>
 
 /* Address of the ith MPP control register */
-static __init unsigned long mpp_ctrl_addr(unsigned int i,
-					  unsigned long dev_bus)
+static __init void __iomem *mpp_ctrl_addr(unsigned int i,
+					  void __iomem *dev_bus)
 {
 	return dev_bus + (i) * 4;
 }
 
 
 void __init orion_mpp_conf(unsigned int *mpp_list, unsigned int variant_mask,
-			   unsigned int mpp_max, unsigned int dev_bus)
+			   unsigned int mpp_max, void __iomem *dev_bus)
 {
 	unsigned int mpp_nr_regs = (1 + mpp_max/8);
 	u32 mpp_ctrl[mpp_nr_regs];
-- 
1.7.9.5
