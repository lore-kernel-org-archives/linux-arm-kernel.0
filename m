From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:57 -0800
Subject: [PATCH 15/35] davinci: da850/omap-l138: Modify NOR partition info
In-Reply-To: <1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

On DA850/OMAP-L138, NOR flash partition was starting from offset
ZERO erasing the UBL and u-boot when the complete NOR is erased.
This patch moves the start of the partition to 512K, after the
bootloaders and u-boot env variables.

This patch also creates a new partition on NOR Flash to store
Linux kernel image.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index dba2241..ac3b5a3 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -46,8 +46,20 @@
 
 static struct mtd_partition da850_evm_norflash_partition[] = {
 	{
-		.name           = "NOR filesystem",
+		.name           = "bootloaders + env",
 		.offset         = 0,
+		.size           = SZ_512K,
+		.mask_flags     = MTD_WRITEABLE,
+	},
+	{
+		.name           = "kernel",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = SZ_2M,
+		.mask_flags     = 0,
+	},
+	{
+		.name           = "filesystem",
+		.offset         = MTDPART_OFS_APPEND,
 		.size           = MTDPART_SIZ_FULL,
 		.mask_flags     = 0,
 	},
-- 
1.6.6.rc2.1.g42108
