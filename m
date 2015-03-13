From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Mar 2015 13:07:30 +0100
Subject: [PATCH v2 6/8] asm-generic: introduce .text.fixup input section
In-Reply-To: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426248452-4773-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces a new .text.fixup input section that gets emitted
together with the .text section for each input object file.

Note that

  *(.text)
  *(.text.fixup)

is not the same as

  *(.text .text.fixup)

and we are looking for the latter, to ensure that fixup snippets that
are assembled into a separate section in the object file do not end
up out of range for the relative branch instructions it contains if
the .text section itself grows very large.

This helps prevent linker failures on large ARM kernels.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ac78910d7416..463231d5bfc7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -401,7 +401,7 @@
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.hot)						\
-		*(.text)						\
+		*(.text .text.fixup)					\
 		*(.ref.text)						\
 	MEM_KEEP(init.text)						\
 	MEM_KEEP(exit.text)						\
-- 
1.8.3.2
