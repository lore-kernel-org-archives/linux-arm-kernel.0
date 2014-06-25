From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 25 Jun 2014 13:50:28 -0400
Subject: [PATCH v2] ARM: virt, vexpress: Use 64-bit DMA for LPAE
In-Reply-To: <5331B14B.7040103@codeaurora.org>
References: <5331B14B.7040103@codeaurora.org>
Message-ID: <1403718631-25194-1-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On an LPAE system, the physical addresses used by VirtIO-MMIO may be
higher than 32 bits. For example on a Versatile Express system with
4G RAM, the following error surfaces when trying to use a VirtIO-MMIO
block device.

EXT2-fs (vda): error: ext2_check_page: bad entry in directory #2: : unaligned directory entry - offset=0, inode=3755990991, rec_len=57311, name_len=223

To fix this, select ARCH_DMA_ADDR_T_64BIT when LPAE is selected
and mach-vexpress, mach-virt, or both are being built.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm/Kconfig               | 1 +
 arch/arm/mach-vexpress/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 245058b..8407c28 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -901,6 +901,7 @@ endmenu
 
 config ARCH_VIRT
 	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_PSCI
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 99c1f15..5f33e16 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -1,5 +1,6 @@
 menuconfig ARCH_VEXPRESS
 	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by the Linux Foundation.
