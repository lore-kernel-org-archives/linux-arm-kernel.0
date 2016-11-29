From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 29 Nov 2016 12:40:02 +0000
Subject: [RFC v2 PATCH 20/23] IB: add dependency on MMU
In-Reply-To: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480423205-48436-21-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While building for NOMMU several link time issues were seen:

mm/built-in.o: In function `do_mmu_notifier_register':
usercopy.c:(.text+0x34d10): undefined reference to `mm_take_all_locks'
usercopy.c:(.text+0x34d9c): undefined reference to `mm_drop_all_locks'
usercopy.c:(.text+0x34de4): undefined reference to `mm_take_all_locks'
...
ERROR: "zap_vma_ptes" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
ERROR: "zap_vma_ptes" [drivers/infiniband/hw/mlx4/mlx4_ib.ko] undefined!
ERROR: "can_do_mlock" [drivers/infiniband/core/ib_core.ko] undefined!
...
ERROR: "can_do_mlock" [drivers/infiniband/core/ib_core.ko] undefined!
...
ERROR: "zap_vma_ptes" [drivers/infiniband/hw/mlx4/mlx4_ib.ko] undefined!

It seems that Infiniband assumes that is it used in MMU configurations
only, so add dependency on CONFUG_MMU.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/infiniband/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index fb3fb89..5f17955 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -4,6 +4,7 @@ menuconfig INFINIBAND
 	depends on HAS_IOMEM
 	depends on NET
 	depends on INET
+	depends on MMU
 	depends on m || IPV6 != m
 	select IRQ_POLL
 	---help---
-- 
1.7.9.5
