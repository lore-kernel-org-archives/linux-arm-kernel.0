From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Apr 2012 10:19:57 +0100
Subject: [RESEND PATCH] ARM: tls: remove covert channel via TPIDRURW
Message-ID: <1334222397-16265-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TPIDRURW is a user read/write register forming part of the group of
thread registers in more recent versions of the ARM architecture (~v6+).

Currently, the kernel does not touch this register, which allows tasks
to communicate covertly by reading and writing to the register without
context-switching affecting its contents.

This patch clears TPIDRURW when TPIDRURO is updated via the set_tls
macro, which is called directly from __switch_to. Since the current
behaviour makes the register useless to userspace as far as thread
pointers are concerned, simply clearing the register (rather than saving
and restoring it) will not cause any problems to userspace.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/tls.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
index 60843eb..73409e6 100644
--- a/arch/arm/include/asm/tls.h
+++ b/arch/arm/include/asm/tls.h
@@ -7,6 +7,8 @@
 
 	.macro set_tls_v6k, tp, tmp1, tmp2
 	mcr	p15, 0, \tp, c13, c0, 3		@ set TLS register
+	mov	\tmp1, #0
+	mcr	p15, 0, \tmp1, c13, c0, 2	@ clear user r/w TLS register
 	.endm
 
 	.macro set_tls_v6, tp, tmp1, tmp2
@@ -15,6 +17,8 @@
 	mov	\tmp2, #0xffff0fff
 	tst	\tmp1, #HWCAP_TLS		@ hardware TLS available?
 	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
+	movne	\tmp1, #0
+	mcrne	p15, 0, \tmp1, c13, c0, 2	@ clear user r/w TLS register
 	streq	\tp, [\tmp2, #-15]		@ set TLS value at 0xffff0ff0
 	.endm
 
-- 
1.7.4.1
