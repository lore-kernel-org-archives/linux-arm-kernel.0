From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:11 +0100
Subject: [PATCH 22/24] ARM: kprobes: Reject probing of unprivileged load and
	store instructions
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-23-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These occur extremely rarely in the kernel and writing test cases for
them is difficult.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 1ee38ad..70e540b 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1262,6 +1262,13 @@ static const union decode_item arm_cccc_0001_____1001_table[] = {
 static const union decode_item arm_cccc_000x_____1xx1_table[] = {
 	/* Extra load/store instructions				*/
 
+	/* STRHT		cccc 0000 xx10 xxxx xxxx xxxx 1011 xxxx */
+	/* ???			cccc 0000 xx10 xxxx xxxx xxxx 11x1 xxxx */
+	/* LDRHT		cccc 0000 xx11 xxxx xxxx xxxx 1011 xxxx */
+	/* LDRSBT		cccc 0000 xx11 xxxx xxxx xxxx 1101 xxxx */
+	/* LDRSHT		cccc 0000 xx11 xxxx xxxx xxxx 1111 xxxx */
+	DECODE_REJECT	(0x0f200090, 0x00200090),
+
 	/* LDRD/STRD lr,pc,{...	cccc 000x x0x0 xxxx 111x xxxx 1101 xxxx */
 	DECODE_REJECT	(0x0e10e0d0, 0x0000e0d0),
 
@@ -1564,6 +1571,12 @@ static const union decode_item arm_cccc_01xx_table[] = {
 	/* LDRB/STRB pc,[...]	cccc 01xx x0xx xxxx xxxx xxxx xxxx xxxx */
 	DECODE_REJECT	(0x0c40f000, 0x0440f000),
 
+	/* STRT			cccc 01x0 x010 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRT			cccc 01x0 x011 xxxx xxxx xxxx xxxx xxxx */
+	/* STRBT		cccc 01x0 x110 xxxx xxxx xxxx xxxx xxxx */
+	/* LDRBT		cccc 01x0 x111 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0x0d200000, 0x04200000),
+
 	/* STR (immediate)	cccc 010x x0x0 xxxx xxxx xxxx xxxx xxxx */
 	/* STRB (immediate)	cccc 010x x1x0 xxxx xxxx xxxx xxxx xxxx */
 	DECODE_EMULATEX	(0x0e100000, 0x04000000, emulate_str,
-- 
1.7.2.5
