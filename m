From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 06 Jul 2011 11:25:10 +0100
Subject: [PATCH 7/7] ARM: vmlinux.lds: use _text and _stext the same way as x86
In-Reply-To: <20110706102245.GO8286@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
Message-ID: <E1QePI6-0004zz-RR@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

x86 uses _text to mark the start of the kernel image including the
head text, and _stext to mark the start of the .text section.  Change
our vmlinux.lds to conform.  An audit of the places which use _stext
and _text in arch/arm indicates no users of either symbol are impacted
by this change.  It does mean a slight change to /proc/iomem output.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/vmlinux.lds.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 18574b7..bf977f8 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -66,11 +66,11 @@ SECTIONS
 	. = PAGE_OFFSET + TEXT_OFFSET;
 #endif
 	.head.text : {
-		_stext = .;
+		_text = .;
 		HEAD_TEXT
 	}
 	.text : {			/* Real text segment		*/
-		_text = .;		/* Text and read-only data	*/
+		_stext = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
 			*(.exception.text)
 			__exception_text_end = .;
-- 
1.7.4.4
