From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 06 Nov 2018 13:40:20 +0000
Subject: [PATCH 3/4] ARM: merge -fdata-sections BSS data to .bss section
In-Reply-To: <20181106133935.GB30658@n2100.armlinux.org.uk>
References: <20181106133935.GB30658@n2100.armlinux.org.uk>
Message-ID: <E1gK1ae-0000or-7R@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building with -fdata-sections, the BSS data is placed into separate
sections, so we need to ask the linker to group these together into the
.bss output section, so that they're correctly placed.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/compressed/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 2b963d8e76dd..3b91bc3c606f 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -118,7 +118,7 @@ SECTIONS
 
   . = BSS_START;
   __bss_start = .;
-  .bss			: { *(.bss) }
+  .bss			: { *(.bss) *(.bss.*) }
   _end = .;
 
   . = ALIGN(8);		/* the stack must be 64-bit aligned */
-- 
2.7.4
