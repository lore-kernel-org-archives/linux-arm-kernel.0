From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 22 Feb 2013 00:08:05 -0800
Subject: [PATCH] ARM: vfp: fix fpsid register subarchitecture field mask width
Message-ID: <1361520485-30269-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@codeaurora.org>

The subarchitecture field in the fpsid register is 7 bits wide.
The topmost bit is used to designate that the subarchitecture
designer is not ARM. We use this field to determine which VFP
version is supported by the CPU. Since the topmost bit is masked
off we detect non-ARM subarchitectures as supporting only
HWCAP_VFP and not HWCAP_VFPv3 as it should be for Qualcomm's
processors.

Use the proper width for the mask so that we report the correct
elf_hwcap of non-ARM designed processors.

Signed-off-by: Steve Muckle <smuckle@codeaurora.org>
[sboyd: Expanded on commit text]
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/include/asm/vfp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/vfp.h b/arch/arm/include/asm/vfp.h
index f4ab34f..76d3f69 100644
--- a/arch/arm/include/asm/vfp.h
+++ b/arch/arm/include/asm/vfp.h
@@ -21,7 +21,7 @@
 #define FPSID_FORMAT_MASK	(0x3  << FPSID_FORMAT_BIT)
 #define FPSID_NODOUBLE		(1<<20)
 #define FPSID_ARCH_BIT		(16)
-#define FPSID_ARCH_MASK		(0xF  << FPSID_ARCH_BIT)
+#define FPSID_ARCH_MASK		(0x7F  << FPSID_ARCH_BIT)
 #define FPSID_PART_BIT		(8)
 #define FPSID_PART_MASK		(0xFF << FPSID_PART_BIT)
 #define FPSID_VARIANT_BIT	(4)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
