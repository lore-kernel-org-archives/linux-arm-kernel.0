From: silvano.dininno@nxp.com (Silvano di Ninno)
Date: Wed, 3 Jan 2018 17:32:50 +0100
Subject: [PATCH] ARM: decompressor: Make RAM sections Outer non-cacheable
In-Reply-To: <1514997170-31906-1-git-send-email-silvano.dininno@nxp.com>
References: <1514997170-31906-1-git-send-email-silvano.dininno@nxp.com>
Message-ID: <1514997170-31906-2-git-send-email-silvano.dininno@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel decompressor is not aware of external caches.
If those caches are enabled (It can be so if Linux runs in
Non-secure world and the secure world OS has enabled them),
it leads to stale data in external caches and coherency
problem when Linux enables them.

This patch makes the RAM sections Outer non-cacheable

Signed-off-by: Silvano di Ninno <silvano.dininno@nxp.com>
---
 arch/arm/boot/compressed/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 45c8823..1cbba2a 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -775,6 +775,7 @@ __armv7_mmu_cache_on:
 		mrc	p15, 0, r11, c0, c1, 4	@ read ID_MMFR0
 		tst	r11, #0xf		@ VMSA
 		movne	r6, #CB_BITS | 0x02	@ !XN
+		orrne	r6, r6, #4 << 12	@ TEX[2:0] = 100
 		blne	__setup_mmu
 		mov	r0, #0
 		mcr	p15, 0, r0, c7, c10, 4	@ drain write buffer
-- 
2.7.4
