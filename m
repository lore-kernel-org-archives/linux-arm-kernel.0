From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Sep 2011 01:41:41 -0400
Subject: [PATCH 1/6] ARM: zImage: ensure it is always a multiple of 64 bits in
	size
In-Reply-To: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
Message-ID: <1315978906-15829-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

This is needed for proper alignment when the DTB appending feature
is used.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/compressed/vmlinux.lds.in |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
index 4e728834a1..4919f2ac8b 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ b/arch/arm/boot/compressed/vmlinux.lds.in
@@ -51,6 +51,10 @@ SECTIONS
   _got_start = .;
   .got			: { *(.got) }
   _got_end = .;
+
+  /* ensure the zImage file size is always a multiple of 64 bits */
+  /* (without a dummy byte, ld just ignores the empty section) */
+  .pad			: { BYTE(0); . = ALIGN(8); }
   _edata = .;
 
   . = BSS_START;
-- 
1.7.7-rc0
