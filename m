From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Wed, 27 Sep 2017 13:49:28 +0200
Subject: [PATCH 1/2] ARM: Make DEBUG_LL produce CRLF instead of LFCR
In-Reply-To: <20170927114929.9259-1-alexander.sverdlin@nokia.com>
References: <20170927114929.9259-1-alexander.sverdlin@nokia.com>
Message-ID: <20170927114929.9259-2-alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change almost doubles the usage of DEBUG_LL macros but
in exchange terminates all the console output with CRLF not LFCR.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/kernel/debug.S | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index ea9646c..ca502cc 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -80,12 +80,15 @@ hexbuf:		.space 16
 ENTRY(printascii)
 		addruart_current r3, r1, r2
 		b	2f
-1:		waituart r2, r3
+1:		teq	r1, #'\n'
+		bne	3f
+		waituart r2, r3
+		mov	r2, #'\r'
+		senduart r2, r3
+		busyuart r2, r3
+3:		waituart r2, r3
 		senduart r1, r3
 		busyuart r2, r3
-		teq	r1, #'\n'
-		moveq	r1, #'\r'
-		beq	1b
 2:		teq	r0, #0
 		ldrneb	r1, [r0], #1
 		teqne	r1, #0
-- 
2.4.6
