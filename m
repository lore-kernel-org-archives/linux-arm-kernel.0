From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Wed, 7 Jun 2017 16:59:32 +0800
Subject: [PATCH] Revert "ARM: 8433/1: add a VMSPLIT_3G_OPT config option"
Message-ID: <1496825972-26829-1-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 63ce446c9b5787a94ed875bab20772e1a2b3092f.

When enable VMSPLIT_3G_OPT, the PAGE_OFFSET will be 0xB0000000, and then
we will get the value "1" for TTBR1_SIZE(T1SZ) as the following MACRO:

   #define TTBR1_SIZE     (((PAGE_OFFSET >> 30) - 1) << 16)

which means TTBR1's range will be 0x80000000 to 0xffffffff, and it is
waster of VA [0x80000000, 0xB0000000). So it is better to use VMSPLIT_2G
instead, to achieve the goal "allows for 1GB systems to have their RAM
entirely mapped as low memory".

Meanwhile, It will trigger a bug of boot fail with CONFIG_ARM_LPAE=y,
which I reported:
    https://patchwork.kernel.org/patch/9768573/

For ARM_LPAE only support 3:1, 2:2, 1:3 split of TTBR1, which mention in:
  http://elinux.org/images/6/6a/Elce11_marinas.pdf - p16

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/arm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c1a35f..5961835a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1415,8 +1415,6 @@ choice
 
 	config VMSPLIT_3G
 		bool "3G/1G user/kernel split"
-	config VMSPLIT_3G_OPT
-		bool "3G/1G user/kernel split (for full 1G low memory)"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
 	config VMSPLIT_1G
@@ -1428,7 +1426,6 @@ config PAGE_OFFSET
 	default PHYS_OFFSET if !MMU
 	default 0x40000000 if VMSPLIT_1G
 	default 0x80000000 if VMSPLIT_2G
-	default 0xB0000000 if VMSPLIT_3G_OPT
 	default 0xC0000000
 
 config NR_CPUS
-- 
1.7.12.4
