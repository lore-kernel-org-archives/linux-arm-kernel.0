From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:30 +0000
Subject: [RFC v3 PATCH 12/25] ARM: tlbflush: drop dependency on CONFIG_SMP
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-13-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While building NOMMU and UP following errors show up:

arch/arm/mach-mvebu/pmsu.c: In function 'armada_370_xp_pmsu_idle_enter':
arch/arm/mach-mvebu/pmsu.c:291:2: error: implicit declaration of function 'local_flush_tlb_all' [-Werror=implicit-function-declaration]
  local_flush_tlb_all();
  ^
  CC      arch/arm/mach-omap2/control.o
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-mvebu/pmsu.o] Error 1

...

arch/arm/mach-imx/pm-imx5.c: In function 'mx5_suspend_enter':
arch/arm/mach-imx/pm-imx5.c:227:3: error: implicit declaration of function 'local_flush_tlb_all' [-Werror=implicit-function-declaration]
   local_flush_tlb_all();
   ^
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-imx/pm-imx5.o] Error 1

...

arch/arm/mach-imx/pm-imx6.c: In function 'imx6q_suspend_finish':
arch/arm/mach-imx/pm-imx6.c:354:3: error: implicit declaration of function 'local_flush_tlb_all' [-Werror=implicit-function-declaration]
   local_flush_tlb_all();
   ^
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-imx/pm-imx6.o] Error 1

Make local_* stuff available for UP (even though it doesn't make
sense) so build can progress.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/tlbflush.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index def9e57..d9a6e2e 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -641,7 +641,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 
 #endif
 
-#elif defined(CONFIG_SMP)	/* !CONFIG_MMU */
+#else /* !CONFIG_MMU */
 
 #ifndef __ASSEMBLY__
 
-- 
1.7.9.5
