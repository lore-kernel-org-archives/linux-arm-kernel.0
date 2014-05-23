From: marc.ceeeee@gmail.com (Marc Carino)
Date: Thu, 22 May 2014 18:27:52 -0700
Subject: [PATCH] ARM: zImage: add DSB and ISB barriers after relocating code
Message-ID: <1400808472-401-1-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zImage loader will relocate the image if it determines that
decompression will overwrite its current location. Since the act
of relocation is basically a form of code self-modification, we
need to ensure that the CPU fetches the updated instruction stream.

Since cache maintenance is skipped during the relocation phase (the
MMUs and caches are off), we need to execute both a data sync
and instruction sync barrier prior to jumping to the relocated code.
Skipping the barriers can result in execution of stale prefetched
code, leading to hangs or an UNDEFINED INSTRUCTION exception.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 arch/arm/boot/compressed/head.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 066b034..df067ca 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -400,8 +400,16 @@ dtb_check_done:
 		add	sp, sp, r6
 #endif
 
+		/*
+		 * Perform cache maintenance if caches were enabled earlier.
+		 * Otherwise, execute data and instruction barriers prior to
+		 * jumping to the newly-written code.
+		 */
 		tst	r4, #1
 		bleq	cache_clean_flush
+		movne	r0, #0
+		mcrne	p15, 0, r0, c7, c10, 4	@ DSB
+		mcrne	p15, 0, r0, c7, c5, 4	@ ISB
 
 		adr	r0, BSYM(restart)
 		add	r0, r0, r6
-- 
1.8.1.3
