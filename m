From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Feb 2011 21:32:11 -0800
Subject: [PATCH 5/7] ARM: tegra: timer: Enable timer and rtc clocks
In-Reply-To: <1298342392-21236-6-git-send-email-ccross@android.com>
References: <1298342392-21236-1-git-send-email-ccross@android.com>
	<1298342392-21236-6-git-send-email-ccross@android.com>
Message-ID: <AANLkTim=TZaqZFSJwOAN2gntvu=fiHVPQVn12=WyF9Wi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Mon, Feb 21, 2011 at 6:39 PM, Colin Cross <ccross@android.com> wrote:
> Enable the timer and rtc clocks to prevent them being
> turned off by the bootloader clock disabling code.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
> ?arch/arm/mach-tegra/timer.c | ? 14 ++++++++++++--
> ?1 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
> index ffa6a68..31b4f56 100644
> --- a/arch/arm/mach-tegra/timer.c
> +++ b/arch/arm/mach-tegra/timer.c
> @@ -18,6 +18,7 @@
> ?*/
>
> ?#include <linux/init.h>
> +#include <linux/err.h>
> ?#include <linux/sched.h>
> ?#include <linux/time.h>
> ?#include <linux/interrupt.h>
> @@ -193,9 +194,20 @@ static struct irqaction tegra_timer_irq = {
>
> ?static void __init tegra_init_timer(void)
> ?{
> + ? ? ? struct clk *clk;
> ? ? ? ?unsigned long rate = clk_measure_input_freq();
> ? ? ? ?int ret;
>
> + ? ? ? clk = clk_get_sys("timer", NULL);
> + ? ? ? BUG_ON(IS_ERR(clk));
> + ? ? ? clk_enable(clk);
> + ? ? ? clk_put(clk);
> +
> + ? ? ? clk = clk_get_sys("rtc-tegra", NULL);
> + ? ? ? BUG_ON(IS_ERR(clk));
> + ? ? ? clk_enable(clk);
> + ? ? ? clk_put(clk);

Why initialize the rtc clock here? Not all boards use it and instead
use the rtc on the pmic. Seems wasteful to clock it unless the driver
for it is probed and configured.


-Olof
