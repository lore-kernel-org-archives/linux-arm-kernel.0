From: kishorek.kadiyala@gmail.com (Kishore Kadiyala)
Date: Wed, 9 Feb 2011 02:26:16 +0530
Subject: [PATCH] OMAP2: add regulator for MMC1
In-Reply-To: <1297094927-727-1-git-send-email-balajitk@ti.com>
References: <1297094927-727-1-git-send-email-balajitk@ti.com>
Message-ID: <AANLkTinGOQ6-FmVG=LbQHjYPZ_tm3yDtVdDLx7EqhHpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 7, 2011 at 9:38 PM, Balaji T K <balajitk@ti.com> wrote:
> Add regulator VMMC1 used by SD/MMC card slot1 in 2430sdp.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

Tested-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

Regards,
Kishore

> ---
> Tested on OMAP2430 SDP with busybox filesystem mounted on MMC1
>
> ?arch/arm/mach-omap2/board-2430sdp.c | ? 21 +++++++++++++++++++++
> ?1 files changed, 21 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index e066177..361f6cb 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -22,6 +22,7 @@
> ?#include <linux/mmc/host.h>
> ?#include <linux/delay.h>
> ?#include <linux/i2c/twl.h>
> +#include <linux/regulator/machine.h>
> ?#include <linux/err.h>
> ?#include <linux/clk.h>
> ?#include <linux/io.h>
> @@ -148,6 +149,25 @@ static void __init omap_2430sdp_init_irq(void)
> ? ? ? ?omap_init_irq();
> ?}
>
> +static struct regulator_consumer_supply sdp2430_vmmc1_supplies[] = {
> + ? ? ? REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0"),
> +};
> +
> +/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
> +static struct regulator_init_data sdp2430_vmmc1 = {
> + ? ? ? .constraints = {
> + ? ? ? ? ? ? ? .min_uV ? ? ? ? ? ? ? ? = 1850000,
> + ? ? ? ? ? ? ? .max_uV ? ? ? ? ? ? ? ? = 3150000,
> + ? ? ? ? ? ? ? .valid_modes_mask ? ? ? = REGULATOR_MODE_NORMAL
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | REGULATOR_MODE_STANDBY,
> + ? ? ? ? ? ? ? .valid_ops_mask ? ? ? ? = REGULATOR_CHANGE_VOLTAGE
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | REGULATOR_CHANGE_MODE
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | REGULATOR_CHANGE_STATUS,
> + ? ? ? },
> + ? ? ? .num_consumer_supplies ?= ARRAY_SIZE(sdp2430_vmmc1_supplies),
> + ? ? ? .consumer_supplies ? ? ?= &sdp2430_vmmc1_supplies[0],
> +};
> +
> ?static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
> ? ? ? ?.gpio_base ? ? ?= OMAP_MAX_GPIO_LINES,
> ? ? ? ?.irq_base ? ? ? = TWL4030_GPIO_IRQ_BASE,
> @@ -160,6 +180,7 @@ static struct twl4030_platform_data sdp2430_twldata = {
>
> ? ? ? ?/* platform_data for children goes here */
> ? ? ? ?.gpio ? ? ? ? ? = &sdp2430_gpio_data,
> + ? ? ? .vmmc1 ? ? ? ? ?= &sdp2430_vmmc1,
> ?};
>
> ?static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
