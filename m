From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Feb 2016 17:29:45 +0100
Subject: [PATCH] target: fix cast from pointer to phys_addr_t
Message-ID: <3114027.BKdWsaRxO0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uio_mem structure has a member that is a phys_addr_t, but can
be a number of other types too. The target core driver attempts
to assign a pointer from vmalloc() to it, by casting it to
phys_addr_t, but that causes a warning when phys_addr_t is longer
than a pointer:

drivers/target/target_core_user.c: In function 'tcmu_configure_device':
drivers/target/target_core_user.c:906:22: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

This adds another cast to uintptr_t to shut up the warning.
A nicer fix might be to have additional fields in uio_mem
for the different purposes, so we can assign a pointer directly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This has been around for a long while, but did not trigger in
my randconfig testing until now, don't know why.

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index dd600e5ead71..94f5154ac788 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -903,7 +903,7 @@ static int tcmu_configure_device(struct se_device *dev)
 	info->version = __stringify(TCMU_MAILBOX_VERSION);
 
 	info->mem[0].name = "tcm-user command & data buffer";
-	info->mem[0].addr = (phys_addr_t) udev->mb_addr;
+	info->mem[0].addr = (phys_addr_t)(uintptr_t)udev->mb_addr;
 	info->mem[0].size = TCMU_RING_SIZE;
 	info->mem[0].memtype = UIO_MEM_VIRTUAL;
 
