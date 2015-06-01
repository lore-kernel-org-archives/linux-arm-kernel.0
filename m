From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  1 Jun 2015 13:40:34 +0200
Subject: [PATCH for-v4.2 4/4] arm64: drop sleep_idmap_phys and clean up
 cpu_resume()
In-Reply-To: <1433158834-25238-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1433158834-25238-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1433158834-25238-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two cleanups of the asm function cpu_resume():
- The global variable sleep_idmap_phys always points to idmap_pg_dir,
  so we can just use that value directly in the CPU resume path.
- Unclutter the load of sleep_save_sp::save_ptr_stash_phys.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/sleep.S   | 7 ++-----
 arch/arm64/kernel/suspend.c | 3 ---
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 811e61a2d847..803cfea41962 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -164,15 +164,12 @@ ENTRY(cpu_resume)
 #else
 	mov	x7, xzr
 #endif
-	adrp	x0, sleep_save_sp
-	add	x0, x0, #:lo12:sleep_save_sp
-	ldr	x0, [x0, #SLEEP_SAVE_SP_PHYS]
+	ldr_l	x0, sleep_save_sp + SLEEP_SAVE_SP_PHYS
 	ldr	x0, [x0, x7, lsl #3]
 	/* load sp from context */
 	ldr	x2, [x0, #CPU_CTX_SP]
-	adrp	x1, sleep_idmap_phys
 	/* load physical address of identity map page table in x1 */
-	ldr	x1, [x1, #:lo12:sleep_idmap_phys]
+	adrp	x1, idmap_pg_dir
 	mov	sp, x2
 	/*
 	 * cpu_do_resume expects x0 to contain context physical address
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index d7daf45ae7a2..f6073c27d65f 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -118,7 +118,6 @@ int __cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 }
 
 struct sleep_save_sp sleep_save_sp;
-phys_addr_t sleep_idmap_phys;
 
 static int __init cpu_suspend_init(void)
 {
@@ -132,9 +131,7 @@ static int __init cpu_suspend_init(void)
 
 	sleep_save_sp.save_ptr_stash = ctx_ptr;
 	sleep_save_sp.save_ptr_stash_phys = virt_to_phys(ctx_ptr);
-	sleep_idmap_phys = virt_to_phys(idmap_pg_dir);
 	__flush_dcache_area(&sleep_save_sp, sizeof(struct sleep_save_sp));
-	__flush_dcache_area(&sleep_idmap_phys, sizeof(sleep_idmap_phys));
 
 	return 0;
 }
-- 
1.9.1
