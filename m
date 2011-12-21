From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Dec 2011 10:39:58 +0900
Subject: [PATCH 06/12] ARM: restart: S5PC100: use new restart hook
In-Reply-To: <1324385316-6052-7-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <1324385316-6052-7-git-send-email-kgene.kim@samsung.com>
Message-ID: <05dd01ccbf81$72d1a4d0$5874ee70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pc100/common.c              |    9 +++++++++
>  arch/arm/mach-s5pc100/common.h              |    2 ++
>  arch/arm/mach-s5pc100/include/mach/system.h |    2 --
>  arch/arm/mach-s5pc100/mach-smdkc100.c       |    1 +
>  4 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
> index e6eadac..73594a2 100644
> --- a/arch/arm/mach-s5pc100/common.c
> +++ b/arch/arm/mach-s5pc100/common.c
> @@ -45,6 +45,7 @@
>  #include <plat/iic-core.h>
>  #include <plat/onenand-core.h>
>  #include <plat/regs-serial.h>
> +#include <plat/watchdog-reset.h>
> 
>  #include "common.h"
> 
> @@ -221,3 +222,11 @@ void __init s5pc100_init_uarts(struct s3c2410_uartcfg *cfg, int no)
>  {
>  	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
>  }
> +
> +void s5pc100_restart(char mode, const char *cmd)
> +{
> +	if (mode != 's')
> +		arch_wdt_reset();
> +
> +	soft_restart(0);
> +}
> diff --git a/arch/arm/mach-s5pc100/common.h b/arch/arm/mach-s5pc100/common.h
> index 4822b87..9fbd3ae 100644
> --- a/arch/arm/mach-s5pc100/common.h
> +++ b/arch/arm/mach-s5pc100/common.h
> @@ -18,6 +18,8 @@ void s5pc100_init_irq(void);
>  void s5pc100_register_clocks(void);
>  void s5pc100_setup_clocks(void);
> 
> +void s5pc100_restart(char mode, const char *cmd);
> +
>  #ifdef CONFIG_CPU_S5PC100
> 
>  extern  int s5pc100_init(void);
> diff --git a/arch/arm/mach-s5pc100/include/mach/system.h b/arch/arm/mach-s5pc100/include/mach/system.h
> index a9ea57c..afc96c2 100644
> --- a/arch/arm/mach-s5pc100/include/mach/system.h
> +++ b/arch/arm/mach-s5pc100/include/mach/system.h
> @@ -11,8 +11,6 @@
>  #ifndef __ASM_ARCH_SYSTEM_H
>  #define __ASM_ARCH_SYSTEM_H __FILE__
> 
> -#include <plat/system-reset.h>
> -
>  static void arch_idle(void)
>  {
>  	/* nothing here yet */
> diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
> index 76bcc0b..674d229 100644
> --- a/arch/arm/mach-s5pc100/mach-smdkc100.c
> +++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
> @@ -256,4 +256,5 @@ MACHINE_START(SMDKC100, "SMDKC100")
>  	.map_io		= smdkc100_map_io,
>  	.init_machine	= smdkc100_machine_init,
>  	.timer		= &s3c24xx_timer,
> +	.restart	= s5pc100_restart,
>  MACHINE_END
> --
> 1.7.4.4

From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH V2 07/12] ARM: restart: S5PC100: use new restart hook

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
 - fixed the mis-deleting inclusion of <plat/system-reset.h>
   which includes arch_reset().

 arch/arm/mach-s5pc100/common.c        |    9 +++++++++
 arch/arm/mach-s5pc100/common.h        |    2 ++
 arch/arm/mach-s5pc100/mach-smdkc100.c |    1 +
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index e6eadac..73594a2 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -45,6 +45,7 @@
 #include <plat/iic-core.h>
 #include <plat/onenand-core.h>
 #include <plat/regs-serial.h>
+#include <plat/watchdog-reset.h>
 
 #include "common.h"
 
@@ -221,3 +222,11 @@ void __init s5pc100_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
 	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
 }
+
+void s5pc100_restart(char mode, const char *cmd)
+{
+	if (mode != 's')
+		arch_wdt_reset();
+
+	soft_restart(0);
+}
diff --git a/arch/arm/mach-s5pc100/common.h b/arch/arm/mach-s5pc100/common.h
index 4822b87..9fbd3ae 100644
--- a/arch/arm/mach-s5pc100/common.h
+++ b/arch/arm/mach-s5pc100/common.h
@@ -18,6 +18,8 @@ void s5pc100_init_irq(void);
 void s5pc100_register_clocks(void);
 void s5pc100_setup_clocks(void);
 
+void s5pc100_restart(char mode, const char *cmd);
+
 #ifdef CONFIG_CPU_S5PC100
 
 extern  int s5pc100_init(void);
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 76bcc0b..674d229 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -256,4 +256,5 @@ MACHINE_START(SMDKC100, "SMDKC100")
 	.map_io		= smdkc100_map_io,
 	.init_machine	= smdkc100_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s5pc100_restart,
 MACHINE_END
-- 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
