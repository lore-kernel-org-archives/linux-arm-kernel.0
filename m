From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 16 Aug 2011 13:46:12 -0700
Subject: [RFC PATCH v2 02/13] arm/tegra: Avoid duplicate gpio/pinmux
	devices with dt
In-Reply-To: <1313440100-17131-3-git-send-email-swarren@nvidia.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<1313440100-17131-3-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA25449@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Monday, August 15, 2011 2:28 PM:
> A future change will set up gpio and pinmux platform device registration
> in device-tree files, via board-dt.c. When board-dt.c calls into
> harmony/seaboard_pinmux_init(), this will cause a duplicate registration
> of those platform devices, which will cause kernel boot failure.

It looks like this patch, and the subsequent revert, aren't actually needed.

The boot failure I saw earlier was actually due to the pinmux driver crashing
if pdev->dev.of_node==NULL during probe.

With that fixed, with this patch series as is, there are then warnings due
to tegra-gpio and tegra-pinmux each being registered twice, due to the
following patch setting up AUXDATA and causing the device-tree-registered
and platform-device-registered devices to have the same name.

However, I'm dropping the AUXDATA patch, so that issue doesn't occur.

And hence, I will drop this patch, and its subsequent revert. This will
cause the GPIO and pinmux drivers to be temporarily instantiated twice.
However, that doesn't actually cause any problems, and will be solved af
ew patches later anyway.

(Let me know if anyone thinks this patch should stay in).

> To solve this, modify harmony/seaboard_pinmux_init() so that they only
> register the platform devices when actually running on Harmony/Seaboard;
> when board-dt.c is in use, a different machine type is used.
> 
> This change is a temporary measure to ensure git bisectability. It will
> be reverted when board-dt.c no longer calls harmony/seaboard_pinmux_init().
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/mach-tegra/board-harmony-pinmux.c  |    5 ++++-
>  arch/arm/mach-tegra/board-seaboard-pinmux.c |    5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
> index e99b456..130018d 100644
> --- a/arch/arm/mach-tegra/board-harmony-pinmux.c
> +++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
> @@ -14,6 +14,8 @@
>   *
>   */
> 
> +#include <asm/mach-types.h>
> +
>  #include <linux/kernel.h>
>  #include <linux/gpio.h>
>  #include <mach/pinmux.h>
> @@ -161,7 +163,8 @@ static struct tegra_gpio_table gpio_table[] = {
> 
>  void harmony_pinmux_init(void)
>  {
> -	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
> +	if (machine_is_harmony())
> +		platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
> 
>  	tegra_pinmux_config_table(harmony_pinmux, ARRAY_SIZE(harmony_pinmux));
> 
> diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
> index f092298..bc4dc17 100644
> --- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
> +++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
> @@ -12,6 +12,8 @@
>   *
>   */
> 
> +#include <asm/mach-types.h>
> +
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/gpio.h>
> @@ -176,7 +178,8 @@ static struct tegra_gpio_table gpio_table[] = {
> 
>  void __init seaboard_pinmux_init(void)
>  {
> -	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
> +	if (machine_is_seaboard())
> +		platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
> 
>  	tegra_pinmux_config_table(seaboard_pinmux, ARRAY_SIZE(seaboard_pinmux));
> 
> --
> 1.7.0.4

-- 
nvpublic
