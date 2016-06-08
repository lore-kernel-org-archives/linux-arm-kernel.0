From: keescook@chromium.org (Kees Cook)
Date: Wed, 8 Jun 2016 16:11:58 -0700
Subject: [PATCH] ARM: mm: fix location of _etext
Message-ID: <20160608231158.GA12159@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The _etext position is defined to be the end of the kernel text code,
and should not include any part of the data segments. This interferes
with things that might check memory ranges and expect executable code
up to _etext.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
arm64 needs this fixed too, but it has other assumptions built onto
_etext that should be using different markers.
---
 arch/arm/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index e2c6da096cef..99420fc1f066 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -125,6 +125,8 @@ SECTIONS
 #ifdef CONFIG_DEBUG_ALIGN_RODATA
 	. = ALIGN(1<<SECTION_SHIFT);
 #endif
+	_etext = .;			/* End of text section */
+
 	RO_DATA(PAGE_SIZE)
 
 	. = ALIGN(4);
@@ -155,8 +157,6 @@ SECTIONS
 
 	NOTES
 
-	_etext = .;			/* End of text and rodata section */
-
 #ifdef CONFIG_DEBUG_RODATA
 	. = ALIGN(1<<SECTION_SHIFT);
 #else
-- 
2.7.4


-- 
Kees Cook
Chrome OS & Brillo Security
