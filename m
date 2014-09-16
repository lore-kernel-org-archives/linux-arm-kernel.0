From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 16 Sep 2014 13:09:30 +0800
Subject: [RFC] change keep_initrd and free_initrd_mem into .init section
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB49160E@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch change keep_initrd to __initdata section,
and free_initrd_mem to __init section so that they can be freed by
free_initmem, free_initrd_mem is only called by free_initrd function,
so it's safe to free it after use.

Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 arch/arm/mm/init.c   | 4 ++--
 arch/arm64/mm/init.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 659c75d..907dee1 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -631,9 +631,9 @@ void free_initmem(void)
 
 #ifdef CONFIG_BLK_DEV_INITRD
 
-static int keep_initrd;
+static int __initdata keep_initrd;
 
-void free_initrd_mem(unsigned long start, unsigned long end)
+void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (!keep_initrd) {
 		poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5472c24..7268d57 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -330,9 +330,9 @@ void free_initmem(void)
 
 #ifdef CONFIG_BLK_DEV_INITRD
 
-static int keep_initrd;
+static int __initdata keep_initrd;
 
-void free_initrd_mem(unsigned long start, unsigned long end)
+void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (!keep_initrd)
 		free_reserved_area((void *)start, (void *)end, 0, "initrd");
-- 
2.1.0
