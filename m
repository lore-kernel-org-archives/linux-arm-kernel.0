From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 8 Jun 2011 09:48:41 -0700
Subject: [PATCH] ARM: tegra/harmony: enable USB host ports
In-Reply-To: <1307528018-14454-1-git-send-email-marc.zyngier@arm.com>
References: <1307528018-14454-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498E1CDC5@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote at Wednesday, June 08, 2011 4:14 AM:
> The Harmony board code doesn't have any support for USB, leaving
> the board without any ethernet support. Add the necessary
> declarations to have it up and running, at least for the J6 and J25
> connectors, as well as the ethernet port.
> 
> The OTG port is left unused, short of any documentation.
> 
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Olof Johansson <olofj@google.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Not sure if this is the right time to send this, as this should
> eventually be handled by the device tree. May be useful to some
> people in the meantime.

I believe Colin isn't accepting board changes for this kernel merge
window. I'm not sure what plans are after that. Perhaps device tree?

In the ChromeOS 2.6.38 kernel, the following platform data definitions
are used for tegra_ehci3_device:

+static struct tegra_utmip_config utmi_phy_config = {
+       .hssync_start_delay = 0,
+       .idle_wait_delay = 17,
+       .elastic_limit = 16,
+       .term_range_adj = 6,
+       .xcvr_setup = 9,
+       .xcvr_lsfslew = 2,
+       .xcvr_lsrslew = 2,
+};
+
+static struct tegra_ehci_platform_data tegra_ehci_pdata = {
+       .phy_config = &utmi_phy_config,
+       .operating_mode = TEGRA_USB_HOST,
+       .power_down_on_bus_suspend = 1,
+};

And also this clock is configured:

+       { "usb3",       "clk_m",        12000000,       true },

I'm not sure if that platform data is appropriate for tegra_ehci1_device;
the ChromeOS kernel doesn't enable that port.

You can find that at either:

http://git.chromium.org/chromiumos/third_party/kernel.git

or commit 0d7ae83b763bb3727e6b6189b49925cd3ab2e204
http://avon.wwwdotorg.org/downloads/kernel.git asoc_for-2.6.40_plus_harmony

> Patch against v3.0-rc2.
> 
>  arch/arm/mach-tegra/board-harmony.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-
> tegra/board-harmony.c
> index 30e18bc..b95156a 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -26,6 +26,7 @@
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-tegra.h>
> +#include <linux/platform_data/tegra_usb.h>
> 
>  #include <sound/wm8903.h>
> 
> @@ -143,6 +144,8 @@ static struct platform_device *harmony_devices[]
> __initdata = {
>  	&tegra_das_device,
>  	&tegra_pcm_device,
>  	&harmony_audio_device,
> +	&tegra_ehci1_device,
> +	&tegra_ehci3_device,
>  };
> 
>  static void __init tegra_harmony_fixup(struct machine_desc *desc,
> @@ -185,6 +188,10 @@ static struct tegra_sdhci_platform_data sdhci_pdata4
> = {
>  	.is_8bit	= 1,
>  };
> 
> +static struct tegra_ehci_platform_data ehci_data = {
> +	.operating_mode = TEGRA_USB_HOST,
> +};
> +
>  static void __init tegra_harmony_init(void)
>  {
>  	tegra_clk_init_from_table(harmony_clk_init_table);
> @@ -195,6 +202,9 @@ static void __init tegra_harmony_init(void)
>  	tegra_sdhci_device2.dev.platform_data = &sdhci_pdata2;
>  	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
> 
> +	tegra_ehci1_device.dev.platform_data = &ehci_data;
> +	tegra_ehci3_device.dev.platform_data = &ehci_data;
> +
>  	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
>  	harmony_i2c_init();
>  	harmony_regulator_init();
> --
> 1.7.0.4

-- 
nvpublic
