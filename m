From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 01 Sep 2011 13:51:59 +0100
Subject: [PATCH 11/11] ARM: pm: add L2 cache cleaning for suspend
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Message-ID: <E1Qz6kR-00078p-Vs@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to ensure that state is pushed out from the L2 cache when
suspending so that the resume paths can access their data before the
MMU and caches have been re-initialized.  Add the necessary calls to
__cpu_suspend_save().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/suspend.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index c78a88f..4c95410 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -28,6 +28,9 @@ void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
 	cpu_do_suspend(ptr);
 
 	flush_cache_all();
+	outer_clean_range(*save_ptr, *save_ptr + ptrsz);
+	outer_clean_range(virt_to_phys(save_ptr),
+			  virt_to_phys(save_ptr) + sizeof(*save_ptr));
 }
 
 /*
-- 
1.7.4.4
