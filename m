From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Feb 2012 11:16:18 +0000
Subject: [PATCH] ARM: Fix proc_info table alignment
Message-ID: <1328267778-29835-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With an admittedly exotic choice of configuration options
(CC_OPTIMIZE_FOR_SIZE, THUMB2, some other size-minimizing ones)
and compiler, the proc_info table can end up being misaligned,
and the kernel being unbootable (Error: unrecognized/unsupported
processor variant).

Forcing the alignement to 4 bytes in the linker script fixes the
issue.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/vmlinux.lds.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 1e19691..43a31fb 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -10,6 +10,7 @@
 #include <asm/page.h>
 	
 #define PROC_INFO							\
+	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
 	*(.proc.info.init)						\
 	VMLINUX_SYMBOL(__proc_info_end) = .;
-- 
1.7.7.1
