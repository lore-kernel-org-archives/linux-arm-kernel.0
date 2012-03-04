From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun,  4 Mar 2012 12:01:11 +0200
Subject: [PATCH] ARM: OMAP: fix iommu, not mailbox
Message-ID: <1330855271-28820-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some weird (freudian?) reason, commit 435792d "ARM: OMAP: make
iommu subsys_initcall to fix builtin omap3isp" unintentionally changed
the mailbox's initcall instead of the iommu's.

Fix that.

Reported-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mailbox.c    |    3 +--
 arch/arm/mach-omap2/omap-iommu.c |    3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index a6db1e4..609ea2d 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -412,8 +412,7 @@ static void __exit omap2_mbox_exit(void)
 	platform_driver_unregister(&omap2_mbox_driver);
 }
 
-/* must be ready before omap3isp is probed */
-subsys_initcall(omap2_mbox_init);
+module_init(omap2_mbox_init);
 module_exit(omap2_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index b882204..ac49384 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -150,7 +150,8 @@ err_out:
 		platform_device_put(omap_iommu_pdev[i]);
 	return err;
 }
-module_init(omap_iommu_init);
+/* must be ready before omap3isp is probed */
+subsys_initcall(omap_iommu_init);
 
 static void __exit omap_iommu_exit(void)
 {
-- 
1.7.5.4
