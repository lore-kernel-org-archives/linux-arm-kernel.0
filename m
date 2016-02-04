From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  4 Feb 2016 10:41:04 +0100
Subject: [PATCH] ARM: hide TCM section markers from kallsyms
Message-ID: <1454578864-1136-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new base relative kallsyms implementation that is queued for inclusion
in v4.6 assumes that kernel symbols are within 2 GB of each other, and
hence splits the 32-bit kallsyms symbol address space into 2 GB of absolute
addresses and 2 GB of relative values.

This triggers a pathological case on ARM, where, if CONFIG_KALLSYMS_ALL,
CONFIG_HAVE_TCM and CONFIG_VMSPLIT_1G are all enabled, the distance
between kernel symbols exceeds this 2 GB, and the kallsyms table generation
fails. Since both VMSPLIT_1G and HAVE_TCM are niche features, and there
is no code in mainline that actually populates the TCM code and data
regions, we can work around the issue by hiding the TCM section markers
from kallsyms, by emitting them as absolute symbols.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/vmlinux.lds.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 8b60fde5ce48..931ebd0696ea 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -293,11 +293,11 @@ SECTIONS
 	 */
 	.text_itcm ITCM_OFFSET : AT(__itcm_start)
 	{
-		__sitcm_text = .;
+		__sitcm_text = ABSOLUTE(.);
 		*(.tcm.text)
 		*(.tcm.rodata)
 		. = ALIGN(4);
-		__eitcm_text = .;
+		__eitcm_text = ABSOLUTE(.);
 	}
 
 	/*
@@ -314,10 +314,10 @@ SECTIONS
 	.data_dtcm DTCM_OFFSET : AT(__dtcm_start)
 	{
 		. = ALIGN(4);
-		__sdtcm_data = .;
+		__sdtcm_data = ABSOLUTE(.);
 		*(.tcm.data)
 		. = ALIGN(4);
-		__edtcm_data = .;
+		__edtcm_data = ABSOLUTE(.);
 	}
 
 	/* Reset the dot pointer or the linker gets confused */
-- 
2.5.0
