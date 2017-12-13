From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 13 Dec 2017 17:02:06 +0000
Subject: [RFC PATCH 4/5] ARM: NOMMU: Make _stext and _end meet PMSAv8
 alignment restrictions
In-Reply-To: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
References: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1513184527-44120-5-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMSAv8 requires addresses to be either 32 (for M-class) or 64 bytes
(for R-class) aligned. To keep it simple align to 64 bytes always.

For XIP we already have alignment restrictions in place from PMSAv7,
but they can be potentially relaxed for PMSAv8.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/vmlinux.lds.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index ee53f65..a4643a2 100644
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
