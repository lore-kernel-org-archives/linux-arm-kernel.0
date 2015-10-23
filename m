From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 23 Oct 2015 09:22:14 -0500
Subject: [PATCH] arm64: Align .text section to PAGE_SIZE
Message-ID: <1445610134-20528-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It appears that 64k page kernel's die early, in a somewhat random set
of locations when built without KVM. Most likely during memblock
manipulations (depending on kernel debug options).

Normally when KVM is built into the kernel it has an explicit
PAGE_SIZE alignment requirement and that forces the text section to be
aligned to PAGE_SIZE. Without it, the alignment granularity is likely to
be 4k.

This updates the linker script to assure that the the text section is
aligned to a minimum of PAGE_SIZE regardless of build options.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 8a5d97b..bf7b972 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -92,7 +92,7 @@ SECTIONS
 		HEAD_TEXT
 	}
 	ALIGN_DEBUG_RO
-	.text : {			/* Real text segment		*/
+	.text ALIGN(PAGE_SIZE) : {	/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
 			*(.exception.text)
-- 
2.4.3
