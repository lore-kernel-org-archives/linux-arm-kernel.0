From: tabbott@ksplice.com (Tim Abbott)
Date: Wed, 16 Sep 2009 16:40:05 -0400
Subject: [PATCH v3 1/2] arm: convert to use __HEAD and HEAD_TEXT macros.
In-Reply-To: <1253133606-24918-1-git-send-email-tabbott@ksplice.com>
References: <1253133606-24918-1-git-send-email-tabbott@ksplice.com>
Message-ID: <1253133606-24918-2-git-send-email-tabbott@ksplice.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has the consequence of changing the section name used for head
code from ".text.head" to ".head.text".  Since this commit changes all
users in the architecture, this change should be harmless.

The .text.head output section is eliminated and the head text code is
included at the start of the .init output section.

Signed-off-by: Tim Abbott <tabbott@ksplice.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/arm/kernel/head-nommu.S  |    2 +-
 arch/arm/kernel/head.S        |    2 +-
 arch/arm/kernel/vmlinux.lds.S |    8 +++-----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index e5dfc28..573b803 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -32,7 +32,7 @@
  * numbers for r1.
  *
  */
-	.section ".text.head", "ax"
+	__HEAD
 ENTRY(stext)
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 38ccbe1..eb62bf9 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -74,7 +74,7 @@
  * crap here - that's what the boot loader (or in extreme, well justified
  * circumstances, zImage) is for.
  */
-	.section ".text.head", "ax"
+	__HEAD
 ENTRY(stext)
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 5cc4812..d3fbd98 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -24,13 +24,11 @@ SECTIONS
 #else
 	. = PAGE_OFFSET + TEXT_OFFSET;
 #endif
-	.text.head : {
-		_stext = .;
-		_sinittext = .;
-		*(.text.head)
-	}
 
 	.init : {			/* Init code and data		*/
+		_stext = .;
+		_sinittext = .;
+			HEAD_TEXT
 			INIT_TEXT
 		_einittext = .;
 		__proc_info_begin = .;
-- 
1.6.3.3
