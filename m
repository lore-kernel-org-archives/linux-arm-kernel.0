From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 7 Oct 2011 13:59:40 +0800
Subject: [PATCH 08/26] ARM: pxa: move z2 to generic cpu_suspend
In-Reply-To: <1317499438-14058-9-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-9-git-send-email-arnd@arndb.de>
Message-ID: <CAMPhdO-tz2HgBYQGOUW6hrA6fC=x+CQJ3dwbW_0AazFB=cjvbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 2, 2011 at 4:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The cpu_suspend code on pxa has recently changed, and the
> z2 board did not get updated yet. This makes it do the
> same as the other boards.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> ?arch/arm/mach-pxa/z2.c | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index 6c9275a..109447b 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -31,6 +31,7 @@
> ?#include <linux/regulator/machine.h>
> ?#include <linux/i2c/pxa-i2c.h>
>
> +#include <asm/suspend.h>
> ?#include <asm/mach-types.h>
> ?#include <asm/mach/arch.h>
>
> @@ -686,7 +687,7 @@ static void z2_power_off(void)
> ? ? ? ? */
> ? ? ? ?PSPR = 0x0;
> ? ? ? ?local_irq_disable();
> - ? ? ? pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP, PLAT_PHYS_OFFSET - PAGE_OFFSET);
> + ? ? ? cpu_suspend(PWRMODE_DEEPSLEEP, pxa27x_finish_suspend);
> ?}
> ?#else
> ?#define z2_power_off ? NULL
> --
> 1.7.5.4
>

This might not be the safest way to convert. I've proposed a patch weeks ago
as below:

commit 3f7961cbd3428c8639d42d1a51870466e4cbb0eb
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Sun Sep 11 17:19:11 2011 +0800

    ARM: pxa/z2: fix building error of pxa27x_cpu_suspend() no longer available

    Cc: Vasily Khoruzhick <anarsoul@gmail.com>
    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 6c9275a..6fa4e74 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -679,6 +679,8 @@ static inline void z2_pmic_init(void) {}
 #endif

 #ifdef CONFIG_PM
+extern void pxa27x_cpu_pm_enter(suspend_state_t state);
+
 static void z2_power_off(void)
 {
 	/* We're using deep sleep as poweroff, so clear PSPR to ensure that
@@ -686,7 +688,8 @@ static void z2_power_off(void)
 	 */
 	PSPR = 0x0;
 	local_irq_disable();
-	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	pxa27x_set_pwrmode(PWRMODE_DEEPSLEEP);
+	pxa27x_cpu_pm_enter(PM_SUSPEND_MEM);
 }
 #else
 #define z2_power_off   NULL

>
