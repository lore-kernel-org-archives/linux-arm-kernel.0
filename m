From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 Apr 2012 18:56:40 +0100
Subject: [PATCH 1/2] ARM: DT: fix atags_to_fdt() second call site
Message-ID: <1334080601-14339-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atags_to_fdt() returns 1 when it fails to find a valid FDT signature.
The CONFIG_ARM_ATAG_DTB_COMPAT code is supposed to retry with another
location, but only does so when the initial call doesn't fail.

Fix this by using the correct condition in the assembly code.

Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/compressed/head.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 5f6045f..dc7e8ce 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -273,7 +273,7 @@ restart:	adr	r0, LC0
 		add	r0, r0, #0x100
 		mov	r1, r6
 		sub	r2, sp, r6
-		blne	atags_to_fdt
+		bleq	atags_to_fdt
 
 		ldmfd	sp!, {r0-r3, ip, lr}
 		sub	sp, sp, #0x10000
-- 
1.7.7.1
