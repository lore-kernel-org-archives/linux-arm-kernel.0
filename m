From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 24 Jun 2013 17:27:49 +0800
Subject: [PATCH v2] arch: arm64: kernel: add '#ifdef CONFIG_COMPAT' for
 aarch32_break_handler()
In-Reply-To: <51C53C06.7050205@asianux.com>
References: <51C53C06.7050205@asianux.com>
Message-ID: <51C81115.4070803@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


If 'COMPAT' not defined, aarch32_break_handler() cannot pass compiling,
and it can work independent with 'COMPAT', so remove dummy definition.

The related make:

  make ARCH=arm64 randconfig
  make ARCH=arm64 menuconfig
  make ARCH=arm64 V=1 EXTRA_CFLAGS=-W

The related error:

  arch/arm64/kernel/debug-monitors.c:249:5: error: redefinition of ?aarch32_break_handler?
  In file included from arch/arm64/kernel/debug-monitors.c:29:0:
  /root/linux-next/arch/arm64/include/asm/debug-monitors.h:89:12: note: previous definition of ?aarch32_break_handler? was here



Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/include/asm/debug-monitors.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index ef8235c..a2232d0 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -83,14 +83,7 @@ static inline int reinstall_suspended_bps(struct pt_regs *regs)
 }
 #endif
 
-#ifdef CONFIG_COMPAT
 int aarch32_break_handler(struct pt_regs *regs);
-#else
-static int aarch32_break_handler(struct pt_regs *regs)
-{
-	return -EFAULT;
-}
-#endif
 
 #endif	/* __ASSEMBLY */
 #endif	/* __KERNEL__ */
-- 
1.7.7.6
