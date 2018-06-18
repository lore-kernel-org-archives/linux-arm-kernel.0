From: gerg@linux-m68k.org (Greg Ungerer)
Date: Tue, 19 Jun 2018 00:19:03 +1000
Subject: [PATCHv4 2/4] ARM: versatile: define empty debug_ll_io_init() for
 no-MMU
In-Reply-To: <20180618141905.7789-1-gerg@linux-m68k.org>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
Message-ID: <20180618141905.7789-3-gerg@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No-MMU configured targets have no definition for debug_ll_io_init().
Not all machines use this and it will only be required if CONFIG_DEBUG_LL
is enabled.

But when compiling for a target that uses it and it is configured for
no-MMU (!CONFIG_MMU), for example the versatile machine, you will get:

  CC      arch/arm/mach-versatile/versatile_dt.o
arch/arm/mach-versatile/versatile_dt.c: In function ?versatile_map_io?:
arch/arm/mach-versatile/versatile_dt.c:283:2: error: implicit declaration of function ?debug_ll_io_init? [-Werror=implicit-function-declaration]
  debug_ll_io_init();
  ^

Fix by adding a macro for it to the !CONFIG_MMU path in map.h.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/mach/map.h | 1 +
 1 file changed, 1 insertion(+)

v2: no change
v3: rebase on top of linux-4.10
v4: rebase in top of linux-4.17

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 9b7c328fb207..b1fe9c8b5c3e 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -62,6 +62,7 @@ extern int ioremap_page(unsigned long virt, unsigned long phys,
 #else
 #define iotable_init(map,num)	do { } while (0)
 #define vm_reserve_area_early(a,s,c)	do { } while (0)
+#define debug_ll_io_init()	do { } while (0)
 #endif
 
 #endif
-- 
2.17.1
