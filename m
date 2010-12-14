From: john.stultz@linaro.org (John Stultz)
Date: Mon, 13 Dec 2010 20:57:36 -0800
Subject: [PATCH 1/4] avoid mis-detecting some V7 cores in the decompressor
In-Reply-To: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
Message-ID: <1292302659-1863-2-git-send-email-john.stultz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brian Swetland <swetland@google.com>

This allows kernel decompress to happen nearly instantly instead
of taking over 20 seconds.

CC: Nicolas Pitre <nicolas.pitre@linaro.org>
CC: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Brian Swetland <swetland@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm/boot/compressed/head.S |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 6825c34..18d1847 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -637,6 +637,8 @@ proc_types:
 @		b	__arm6_mmu_cache_off
 @		b	__armv3_mmu_cache_flush
 
+#if !defined(CONFIG_CPU_V7)
+		/* This collides with some V7 IDs, preventing correct detection */
 		.word	0x00000000		@ old ARM ID
 		.word	0x0000f000
 		mov	pc, lr
@@ -645,6 +647,7 @@ proc_types:
  THUMB(		nop				)
 		mov	pc, lr
  THUMB(		nop				)
+#endif
 
 		.word	0x41007000		@ ARM7/710
 		.word	0xfff8fe00
-- 
1.7.3.2.146.gca209
