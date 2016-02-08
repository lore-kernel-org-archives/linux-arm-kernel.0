From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  8 Feb 2016 15:34:21 +0100
Subject: [PATCH] lkdtm: mark execute_location as noinline
Message-ID: <1454942069-2780643-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel sometimes fails to link when lkdrm is built-in and
compiled with clang:

relocation truncated to fit: R_ARM_THM_CALL against `.bss'

The reason here is that a relocation from .text to .bss fails to
generate a trampoline because .bss is not an executable section.

Marking the function 'noinline' turns the relative branch to .bss
into an absolute branch to the function argument, and that works
fine.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/lkdtm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm.c b/drivers/misc/lkdtm.c
index 11fdadc68e53..5c1351b19029 100644
--- a/drivers/misc/lkdtm.c
+++ b/drivers/misc/lkdtm.c
@@ -335,7 +335,7 @@ static noinline void corrupt_stack(void)
 	memset((void *)data, 0, 64);
 }
 
-static void execute_location(void *dst)
+static void noinline execute_location(void *dst)
 {
 	void (*func)(void) = dst;
 
-- 
2.7.0
