From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 26 Oct 2015 13:09:49 -0500
Subject: [PATCH v2] arm64: Align .text section to PAGE_SIZE
Message-ID: <1445882989-10618-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
Use ALIGN_DEBUG_RO_MIN() instead of ALIGN() directly.

v1:
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
index 8a5d97b..f3fc966 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -91,7 +91,7 @@ SECTIONS
 		_text = .;
 		HEAD_TEXT
 	}
-	ALIGN_DEBUG_RO
+	ALIGN_DEBUG_RO_MIN(PAGE_SIZE)
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
-- 
2.4.3
