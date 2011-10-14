From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 14 Oct 2011 15:11:47 -0300
Subject: [PATCH] ARM: mm/alignment.c: Fix build error
Message-ID: <1318615907-25391-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_PROC_FS is not set the following error is generated because
'cpu_is_v6_unaligned' definition is protected by CONFIG_PROC_FS:

CC      arch/arm/mm/alignment.o
arch/arm/mm/alignment.c: In function 'alignment_init':
arch/arm/mm/alignment.c:964: error: implicit declaration of function 'cpu_is_v6_unaligned'
arch/arm/mm/alignment.c:968: error: implicit declaration of function 'safe_usermode'
make[1]: *** [arch/arm/mm/alignment.o] Error 1
make: *** [arch/arm/mm] Error 2

This build error was triggered by 'make randconfig'.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mm/alignment.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index cfbcf8b..38b270a 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -959,7 +959,6 @@ static int __init alignment_init(void)
 			  &alignment_proc_fops);
 	if (!res)
 		return -ENOMEM;
-#endif
 
 	if (cpu_is_v6_unaligned()) {
 		cr_alignment &= ~CR_A;
@@ -968,6 +967,7 @@ static int __init alignment_init(void)
 		ai_usermode = safe_usermode(ai_usermode, false);
 	}
 
+#endif
 	hook_fault_code(1, do_alignment, SIGBUS, BUS_ADRALN,
 			"alignment exception");
 
-- 
1.7.1
