From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Tue, 7 Aug 2012 09:42:05 +0800
Subject: [PATCH] Revert "ARM: OMAP3530evm: set pendown_state and debounce
 time for ads7846"
In-Reply-To: <1344284535-16717-1-git-send-email-grinberg@compulab.co.il>
References: <876298iv9s.fsf@ti.com>
 <1344284535-16717-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <5020726D.1030300@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?08?07? 04:22, Igor Grinberg ??:
> 1) The above commit introduced a common ->get_pendown_state() function
> into the generic code, but that function was board-specific for the
> OMAP3EVM and thus broke most other boards using this code.
>
> 2) The above commit was mis-merged introducing another bug which
> prevents the ads7846 driver probe function to succeed.
> The omap_ads7846_init() function frees the pendown GPIO in case there is
> no ->get_pendown_state() function set by the caller (board specific
> code), so it can be requested later by the ads7846 driver.
> The above commit add a common ->get_pendown_state() function without
> removing the gpio_free() call and thus once the ads7846 driver tries
> to use the pendown GPIO, it crashes as the pendown GPIO has not been
> requested.
>
> 3) The above commit introduces NO new functionality as
> get_pendown_state() function is already implemented in a suitable way by
> the ads7846 driver and the debounce time handling has already been
> fixed by commit 97ee9f01 (ARM: OMAP: fix the ads7846 init code).
Igor,

I suspect these two patches(this and 97ee9f01) works well, and there
is something new introduced in ads7846.c, I'll try to look at that new
stuff in this weekend.

Please refer to in-line comments:

Regards,
Zumeng
>
> This reverts commit 16aced80f6739beb2a6ff7b6f96c83ba80d331e8.
>
> Conflicts:
> 	arch/arm/mach-omap2/common-board-devices.c
>
> Solved by taking the working version prior to the above commit.
>
> Cc: Zumeng Chen <zumeng.chen@windriver.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> Kevin, sorry for the late reply.
> How about the above commit message and the below patch?
>
> The patch applies cleanly to Tony's master branch (6 Aug 2012)
> or Kevin's kevin-omap-pm/for_3.6/fixes/ads7846
> after resetting two top most commits.
>
> This patch has been tested on both above branches on cm-t3730.
> Any other board tested will be greately appreciated.
>
> Also, if after all said in the commit message, you still don't
> want to revert the original patch, feel free to post your thoughts.
>
>  arch/arm/mach-omap2/board-omap3evm.c       |    1 +
>  arch/arm/mach-omap2/common-board-devices.c |   11 -----------
>  arch/arm/mach-omap2/common-board-devices.h |    1 -
>  3 files changed, 1 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index ef230a0..0d362e9 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -58,6 +58,7 @@
>  #include "hsmmc.h"
>  #include "common-board-devices.h"
>  
> +#define OMAP3_EVM_TS_GPIO	175
>  #define OMAP3_EVM_EHCI_VBUS	22
>  #define OMAP3_EVM_EHCI_SELECT	61
>  
> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
> index 1473474..c187586 100644
> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -35,16 +35,6 @@ static struct omap2_mcspi_device_config ads7846_mcspi_config = {
>  	.turbo_mode	= 0,
>  };
>  
> -/*
> - * ADS7846 driver maybe request a gpio according to the value
> - * of pdata->get_pendown_state, but we have done this. So set
> - * get_pendown_state to avoid twice gpio requesting.
> - */
> -static int omap3_get_pendown_state(void)
> -{
> -	return !gpio_get_value(OMAP3_EVM_TS_GPIO);
> -}
> -
>  static struct ads7846_platform_data ads7846_config = {
>  	.x_max			= 0x0fff,
>  	.y_max			= 0x0fff,
> @@ -55,7 +45,6 @@ static struct ads7846_platform_data ads7846_config = {
>  	.debounce_rep		= 1,
>  	.gpio_pendown		= -EINVAL,
>  	.keep_vref_on		= 1,
> -	.get_pendown_state	= &omap3_get_pendown_state,
You remove this, then please look at the following codes:

drivers/input/touchscreen/ads7846.c

969 if (pdata->get_pendown_state) {
970 ts->get_pendown_state = pdata->get_pendown_state;
971 } else if (gpio_is_valid(pdata->gpio_pendown)) {
972
973 err = gpio_request_one(pdata->gpio_pendown, GPIOF_IN,
^^^, the driver will want to request again, then it should
be error if i'm right.

974 "ads7846_pendown");
975 if (err) {
976 dev_err(&spi->dev,
977 "failed to request/setup pendown GPIO%d: %d\n",
978 pdata->gpio_pendown, err);
979 return err;
980 }
981
982 ts->gpio_pendown = pdata->gpio_pendown;
983
984 } else {

Regards,
Zumeng
>  };
>  
>  static struct spi_board_info ads7846_spi_board_info __initdata = {
> diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
> index 4c4ef6a..a0b4a428 100644
> --- a/arch/arm/mach-omap2/common-board-devices.h
> +++ b/arch/arm/mach-omap2/common-board-devices.h
> @@ -4,7 +4,6 @@
>  #include "twl-common.h"
>  
>  #define NAND_BLOCK_SIZE	SZ_128K
> -#define OMAP3_EVM_TS_GPIO	175
>  
>  struct mtd_partition;
>  struct ads7846_platform_data;
