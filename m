From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Jun 2017 08:18:46 +0000
Subject: [PATCH v2 4/7] arm: compressed: discard ksymtab/kcrctab sections
In-Reply-To: <20170629081849.15081-1-ard.biesheuvel@linaro.org>
References: <20170629081849.15081-1-ard.biesheuvel@linaro.org>
Message-ID: <20170629081849.15081-5-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With UEFI support added to the decompressor, we may end up including
C code that is part of the kernel proper, but is rebuilt for the
decompressor. This may result in ksymtab/kcrctab metadata being
duplicated into the decompressor, so discard such regions explicitly.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/boot/compressed/vmlinux.lds.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 81c493156ce8..1fa62432e283 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -29,6 +29,11 @@ SECTIONS
      * of the text/got segments.
      */
     *(.data)
+    /*
+     * C code that is shared with the kernel proper (but rebuilt for the
+     * decompressor) may contain exports that we have no use for here.
+     */
+    *(*ksymtab* *kcrctab*)
   }
 
   . = TEXT_START;
-- 
2.9.3
