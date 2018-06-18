From: gerg@linux-m68k.org (Greg Ungerer)
Date: Tue, 19 Jun 2018 00:19:02 +1000
Subject: [PATCHv4 1/4] ARM: versatile: support no-MMU mode addressing
In-Reply-To: <20180618141905.7789-1-gerg@linux-m68k.org>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
Message-ID: <20180618141905.7789-2-gerg@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently for the versatile boards the IO_ADDRESS() macro applies static
virtual address mapping for built-in IO devices. When operating without
the MMU enabled IO devices are accessed at their physical address, no
address translation is required.

For the !CONFIG_MMU case then define the IO_ADDRESS() macro to return the
physical address.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/arm/mach-versatile/versatile_dt.c | 4 ++++
 1 file changed, 4 insertions(+)

v2: no change
v3: rebase on top of linux-4.10
v4: rebase on top of linux-4.17

diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 3c8d39c12909..8cfa05a37295 100644
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
2.17.1
