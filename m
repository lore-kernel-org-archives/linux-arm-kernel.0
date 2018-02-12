From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 12 Feb 2018 11:19:32 +0000
Subject: [PATCH 3/4] ARM: NOMMU: Make _stext and _end meet PMSAv8 alignment
 restrictions
In-Reply-To: <1518434373-27907-1-git-send-email-vladimir.murzin@arm.com>
References: <1518434373-27907-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1518434373-27907-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMSAv8 require addresses to be either 32 (for M-class) or 64 bytes
(for R-class) aligned. To keep it simple align to 64 bytes always.

For XIP we already have alignment restrictions in place from PMSAv7,
but they can be potentially relaxed for PMSAv8.

Tested-by: Szemz? Andr?s <sza@esh.hu>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/vmlinux.lds.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 84a1ae3..edcf07b 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -8,6 +8,8 @@
 #include "vmlinux-xip.lds.S"
 #else
 
+#include <linux/sizes.h>
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
@@ -102,6 +104,9 @@ SECTIONS
 	. = ALIGN(1<<SECTION_SHIFT);
 #endif
 
+#ifdef CONFIG_ARM_MPU
+	. = ALIGN(SZ_64);
+#endif
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 			IDMAP_TEXT
@@ -295,6 +300,9 @@ SECTIONS
 #endif
 
 	BSS_SECTION(0, 0, 0)
+#ifdef CONFIG_ARM_MPU
+	. = ALIGN(SZ_64);
+#endif
 	_end = .;
 
 	STABS_DEBUG
-- 
2.0.0
