From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:20 +0100
Subject: [PATCH 33/51] ARM: kprobes: Reject 16-bit Thumb SETEND,
	CPS and BKPT instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-34-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These are very rare and/or problematic to emulate so we will take the
easy option and disallow probing them (as does the existing ARM
implementation).

Rejecting these instructions doesn't actually require any entries in the
decoding table as it is the default case for instructions which aren't
found.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index d3133fd..554578b 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -373,6 +373,10 @@ static const union decode_item t16_table_1011[] = {
 	/* IT				1011 1111 xxxx xxxx */
 	DECODE_CUSTOM	(0xff00, 0xbf00, t16_decode_it),
 
+	/* SETEND			1011 0110 010x xxxx */
+	/* CPS				1011 0110 011x xxxx */
+	/* BKPT				1011 1110 xxxx xxxx */
+	/* And unallocated instructions...		    */
 	DECODE_END
 };
 
-- 
1.7.2.5
