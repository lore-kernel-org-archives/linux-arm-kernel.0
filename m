From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:33 +0100
Subject: [PATCH 46/51] ARM: kprobes: Reject 32-bit Thumb coprocessor and SIMD
	instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-47-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The kernel doesn't currently support VFP or Neon code, and probing of
code with CP15 operations is fraught with bad consequences. So we will
just reject probing these instructions.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 1677234..6cc51b4 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -510,6 +510,12 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	DECODE_TABLE	(0xfe000000, 0xea000000, t32_table_1110_101x),
 
 	/*
+	 * Coprocessor instructions
+	 *			1110 11xx xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_REJECT	(0xfc000000, 0xec000000),
+
+	/*
 	 * Data-processing (modified immediate)
 	 *			1111 0x0x xxxx xxxx 0xxx xxxx xxxx xxxx
 	 */
@@ -527,6 +533,16 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	 */
 	DECODE_TABLE	(0xf8008000, 0xf0008000, t32_table_1111_0xxx___1),
 
+	/*
+	 * Advanced SIMD element or structure load/store instructions
+	 *			1111 1001 xxx0 xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_REJECT	(0xff100000, 0xf9000000),
+
+	/*
+	 * Coprocessor instructions
+	 *			1111 11xx xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
 	DECODE_END
 };
 
-- 
1.7.2.5
