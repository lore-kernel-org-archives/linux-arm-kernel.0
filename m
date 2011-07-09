From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:18 +0100
Subject: [PATCH 31/51] ARM: kprobes: Reject 16-bit Thumb SVC and UNDEFINED
	instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-32-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

SVC (SWI) instructions shouldn't occur in kernel code so we don't
need to be able to probe them.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-thumb.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index e496948..997fc6d 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -464,6 +464,14 @@ const union decode_item kprobe_decode_thumb16_table[] = {
 	/* LDM				1100 1xxx xxxx xxxx */
 	DECODE_EMULATE	(0xf000, 0xc000, t16_emulate_loregs_rwflags),
 
+	/*
+	 * Conditional branch, and Supervisor Call
+	 */
+
+	/* Permanently UNDEFINED	1101 1110 xxxx xxxx */
+	/* SVC				1101 1111 xxxx xxxx */
+	DECODE_REJECT	(0xfe00, 0xde00),
+
 	DECODE_END
 };
 
-- 
1.7.2.5
