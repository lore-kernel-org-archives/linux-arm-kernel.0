From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 4 Mar 2011 11:49:37 +0000
Subject: CHROMIUM: arm: tegra: Add platfrom devices for Cypress
	trackpad (issue6623011)
In-Reply-To: <20cf3005123492db71049da6a54a@google.com>
References: <20cf3005123492db71049da6a54a@google.com>
Message-ID: <20110304114936.GA9995@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2011 at 11:42:54AM +0000, dudl at cypress.com wrote:
> Reviewers: ccross_android.com, konkers_android.com, olof_lixom.net,  
> linux_arm.linux.org.uk, linux-tegra_vger.kernel.org,  
> linux-arm-kernel_lists.infradead.org, linux-kernel_vger.kernel.org, Micah 
> C, dudl,
>
> Description:
> CHROMIUM: arm: tegra: Add platfrom devices for Cypress trackpad
>
> 1. Add platfrom data strcuture cyapa_platfrom_data.
> 2. Add trackpad device into platfrom I2C bus 0.
> 3. Initialize platfrom data for cyapa_platfrom_data.
> 4. This code is merged based kernel version 2.7.37-rc5.
>
>
> Change-Id: I3591317ac9c3b7d5328a9c617d662ad6be6065a2
> Signed-off-by: Du, Dudley <dudl@cypress.com>
>
> BUG=None
> TEST=Test on arm tegra2 seaborad and kaen platform
>
> Please review this at http://codereview.chromium.org/6623011/
>
> SVN Base: http://git.chromium.org/git/kernel-next.git at chromeos-2.6.37-rc5
>
> Affected files:
>   M arch/arm/mach-tegra/board-seaboard.h
>   M arch/arm/mach-tegra/board-seaboard.c
>
>
> Index: arch/arm/mach-tegra/board-seaboard.c
> diff --git a/arch/arm/mach-tegra/board-seaboard.c  
> b/arch/arm/mach-tegra/board-seaboard.c
> index  
> 75fbab68ef61c0c117bb8dafa2aaca90947a860b..de272cc73794c6600994af3c0e834dd884f6b56b 
> 100644
> --- a/arch/arm/mach-tegra/board-seaboard.c
> +++ b/arch/arm/mach-tegra/board-seaboard.c
> @@ -303,6 +303,36 @@ static struct tegra_i2c_platform_data  
> seaboard_dvc_platform_data = {
>  	.is_dvc		= true,
>  };
>
> +/* for Cypress Trackpad. */
> +#include <linux/cyapa.h>
> +
> +static int cyapa_i2c_platform_init(void)
> +{
> +	return 0;
> +}
> +
> +static int cyapa_i2c_platform_wakeup(void)
> +{
> +	return 0;
> +}
> +
> +static struct cyapa_platform_data cyapa_i2c_platform_data = {
> +	.flag = 0,
> +	.gen = CYAPA_GEN2,
> +	.power_state = CYAPA_PWR_ACTIVE,
> +	.use_absolute_mode = false,
> +	.use_polling_mode = false,
> +	.polling_interval_time_active = CYAPA_ACTIVE_POLLING_INTVAL_TIME,
> +	.polling_interval_time_lowpower = CYAPA_LOWPOWER_POLLING_INTVAL_TIME,
> +	.active_touch_timeout = CYAPA_ACTIVE_TOUCH_TIMEOUT,
> +	.name = CYAPA_I2C_NAME,
> +	.irq_gpio = TEGRA_GPIO_CYTP_INT,
> +	.report_rate = CYAPA_REPORT_RATE,
> +
> +	.wakeup = cyapa_i2c_platform_wakeup,
> +	.init = cyapa_i2c_platform_init,

if these aren't needed, then why not get the driver to check for NULL
and not call them?

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
