From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Thu, 8 Jun 2017 14:05:44 +0800
Subject: [PATCH] ARM/Kconfig: make VMSPLIT_3G_OPT depends on !ARM_LPAE
Message-ID: <1496901944-42140-1-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When both enable CONFIG_ARM_LPAE=y and CONFIG_VMSPLIT_3G_OPT=y, which
means use PAGE_OFFSET=0xB0000000 with ARM_LPAE, the kernel will boot
fail and stop after uncompressed:

   Starting kernel ...

   Uart base = 0x20001000
   watchdog reg = 0x20013000
   dtb addr = 0x80840308
   Uncompressing Linux... done, booting the kernel.

For ARM_LPAE only support 3:1, 2:2, 1:3 split of TTBR1, which mention in:
   http://elinux.org/images/6/6a/Elce11_marinas.pdf - p16

So we should make VMSPLIT_3G_OPT depends on !ARM_LPAE to avoid trigger
this bug.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c1a35f..c0fcab6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1416,6 +1416,7 @@ choice
 	config VMSPLIT_3G
 		bool "3G/1G user/kernel split"
 	config VMSPLIT_3G_OPT
+		depends on !ARM_LPAE
 		bool "3G/1G user/kernel split (for full 1G low memory)"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
-- 
1.7.12.4
