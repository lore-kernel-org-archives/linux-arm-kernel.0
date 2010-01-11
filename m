From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:22 -0800
Subject: [RFC 03/18] arm: boot: remove old ARM ID for QSD
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-4-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@quicinc.com>

The mask and ID pattern for older ARM IDs in the kernel
decompressor matches the CPU ID for Scorpion, causing the
v7 caching routines not to be run and kernel decompression
to take significantly longer.

QSD may eventually use CPUs other than Scorpion, but they
will adhere to the new ARM CPU ID format, which is
incompatible with the entry for older ARM CPU IDs.

Signed-off-by: Steve Muckle <smuckle@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/boot/compressed/head.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index d356af7..36c321c 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -620,6 +620,7 @@ proc_types:
 @		b	__arm6_mmu_cache_off
 @		b	__armv3_mmu_cache_flush
 
+#ifndef CONFIG_ARCH_MSM_SCORPION
 		.word	0x00000000		@ old ARM ID
 		.word	0x0000f000
 		mov	pc, lr
@@ -628,6 +629,7 @@ proc_types:
  THUMB(		nop				)
 		mov	pc, lr
  THUMB(		nop				)
+#endif
 
 		.word	0x41007000		@ ARM7/710
 		.word	0xfff8fe00
-- 
1.6.3.3
