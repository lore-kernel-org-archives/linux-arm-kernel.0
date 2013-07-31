From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 31 Jul 2013 14:58:07 +0900
Subject: [PATCH] ARM: Fix memblock_reserve() to include stext
Message-ID: <20130731055807.14054.70106.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

This fix for the ARM architecture will include stext
in the memblock_reserve() call to make sure that the
following symbols are not overwritten (from System.map):

c0008000 T _text
c0008000 T stext
...
c0008138 T secondary_startup
...
c0009000 T _stext

With this patch applied CPU Hotplug starts working
again. Without this patch code in secondary_startup
never gets reached as expected.

This issue started triggering on kernels later than
v3.10 - perhaps a side effect of the CPU Hotplug init
section rework - so this is a fix for v3.11-rc.

Tested on the sh73a0 KZM9G board with CPU Hotplug:

 # echo 0 > /sys/devices/system/cpu/cpu1/online
 CPU1: shutdown
 # echo 1 > /sys/devices/system/cpu/cpu1/online
 CPU1: Booted secondary processor

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mm/init.c
+++ work/arch/arm/mm/init.c	2013-07-31 14:17:49.000000000 +0900
@@ -346,7 +346,7 @@ void __init arm_memblock_init(struct mem
 #ifdef CONFIG_XIP_KERNEL
 	memblock_reserve(__pa(_sdata), _end - _sdata);
 #else
-	memblock_reserve(__pa(_stext), _end - _stext);
+	memblock_reserve(__pa(_text), _end - _text);
 #endif
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (phys_initrd_size &&
