From: gerg@uclinux.org (Greg Ungerer)
Date: Mon, 26 Sep 2016 10:52:27 +1000
Subject: [PATCH 1/4] arm/versatile: support no-MMU mode addressing
In-Reply-To: <1474851150-12532-1-git-send-email-gerg@uclinux.org>
References: <1474851150-12532-1-git-send-email-gerg@uclinux.org>
Message-ID: <1474851150-12532-2-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently for the versatile boards the IO_ADDRESS() macro applies static
virtual address mapping for built-in IO devices. When operating without
the MMU enabled IO devices are accessed at their physical address, no
address translation is required.

For the !CONFIG_MMU case then define the IO_ADDRESS() macro to return the
physical address.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/mach-versatile/versatile_dt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 3c8d39c..8cfa05a 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -37,7 +37,11 @@
 #include <asm/mach/map.h>
 
 /* macro to get at MMIO space when running virtually */
+#ifdef CONFIG_MMU
 #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
+#else
+#define IO_ADDRESS(x)		(x)
+#endif
 #define __io_address(n)		((void __iomem __force *)IO_ADDRESS(n))
 
 /*
-- 
1.9.1
