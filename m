From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 15:43:52 +0100
Subject: [PATCH] mm: export "high_memory" symbol on !MMU
Message-ID: <2715923.qFZi90ffep@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From f391eb37fafc8a22d7fd9574b8d220f0d90a91d0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Aug 2014 16:24:41 +0200
Subject: [PATCH] mm: export "high_memory" symbol on !MMU

The symbol 'high_memory' is provided on both MMU- and NOMMU-kernels,
but only one of them is exported, which leads to module build errors
in drivers that work fine built-in:

ERROR: "high_memory" [drivers/net/virtio_net.ko] undefined!
ERROR: "high_memory" [drivers/net/ppp/ppp_mppe.ko] undefined!
ERROR: "high_memory" [drivers/mtd/nand/nand.ko] undefined!
ERROR: "high_memory" [crypto/tcrypt.ko] undefined!
ERROR: "high_memory" [crypto/cts.ko] undefined!

This exports the symbol to get these to work on NOMMU as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/mm/nommu.c b/mm/nommu.c
index e9228cbe46de..7bdeb281ad0e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -59,6 +59,7 @@
 #endif
 
 void *high_memory;
+EXPORT_SYMBOL(high_memory);
 struct page *mem_map;
 unsigned long max_mapnr;
 unsigned long highest_memmap_pfn;
