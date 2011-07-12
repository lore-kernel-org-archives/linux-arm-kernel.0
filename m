From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Tue, 12 Jul 2011 22:28:12 +0300
Subject: [PATCH 1/2] ARM: tegra: remove copy-and-pasted i2c platform data
	in boards
In-Reply-To: <1310336374-31727-1-git-send-email-ccross@android.com>
References: <1310336374-31727-1-git-send-email-ccross@android.com>
Message-ID: <CABpLfohW0iavFgKcBXnSWzkKYHvqL+=4vXK2Zf5oJGHkDTHdSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,
Sorry for the delay, I don't have the hardware at the moment, so I
asked Konstantin to do the testing.

On Mon, Jul 11, 2011 at 1:19 AM, Colin Cross <ccross@android.com> wrote:
> Every board file includes the same platform data definition
> for the i2c-tegra driver's bus speed. ?Move the platform data
> into devices.c, and remove it from all the board files.
>
> Signed-off-by: Colin Cross <ccross@android.com>

For the TrimSlice part:

Tested-by: Konstantin Sinyuk <kostyas@compulab.co.il>

> ---
> ?arch/arm/mach-tegra/board-harmony.c ? | ? 22 ----------------------
> ?arch/arm/mach-tegra/board-paz00.c ? ? | ? 17 -----------------
> ?arch/arm/mach-tegra/board-seaboard.c ?| ? 22 ----------------------
> ?arch/arm/mach-tegra/board-trimslice.c | ? 17 -----------------
> ?arch/arm/mach-tegra/devices.c ? ? ? ? | ? 25 +++++++++++++++++++++----
> ?5 files changed, 21 insertions(+), 82 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
> index 30e18bc..846cd7d 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -25,7 +25,6 @@
> ?#include <linux/io.h>
> ?#include <linux/gpio.h>
> ?#include <linux/i2c.h>
> -#include <linux/i2c-tegra.h>
>
> ?#include <sound/wm8903.h>
>
> @@ -83,22 +82,6 @@ static struct platform_device harmony_audio_device = {
> ? ? ? ?},
> ?};
>
> -static struct tegra_i2c_platform_data harmony_i2c1_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> -static struct tegra_i2c_platform_data harmony_i2c2_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> -static struct tegra_i2c_platform_data harmony_i2c3_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> -static struct tegra_i2c_platform_data harmony_dvc_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> ?static struct wm8903_platform_data harmony_wm8903_pdata = {
> ? ? ? ?.irq_active_low = 0,
> ? ? ? ?.micdet_cfg = 0,
> @@ -121,11 +104,6 @@ static struct i2c_board_info __initdata wm8903_board_info = {
>
> ?static void __init harmony_i2c_init(void)
> ?{
> - ? ? ? tegra_i2c_device1.dev.platform_data = &harmony_i2c1_platform_data;
> - ? ? ? tegra_i2c_device2.dev.platform_data = &harmony_i2c2_platform_data;
> - ? ? ? tegra_i2c_device3.dev.platform_data = &harmony_i2c3_platform_data;
> - ? ? ? tegra_i2c_device4.dev.platform_data = &harmony_dvc_platform_data;
> -
> ? ? ? ?platform_device_register(&tegra_i2c_device1);
> ? ? ? ?platform_device_register(&tegra_i2c_device2);
> ? ? ? ?platform_device_register(&tegra_i2c_device3);
> diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
> index 1b076f6..465768e 100644
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@ -26,7 +26,6 @@
> ?#include <linux/pda_power.h>
> ?#include <linux/io.h>
> ?#include <linux/i2c.h>
> -#include <linux/i2c-tegra.h>
> ?#include <linux/platform_data/tegra_usb.h>
>
> ?#include <asm/mach-types.h>
> @@ -74,24 +73,8 @@ static struct platform_device *paz00_devices[] __initdata = {
> ? ? ? ?&tegra_sdhci_device4,
> ?};
>
> -static struct tegra_i2c_platform_data paz00_i2c1_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> -static struct tegra_i2c_platform_data paz00_i2c2_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> -static struct tegra_i2c_platform_data paz00_dvc_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> ?static void paz00_i2c_init(void)
> ?{
> - ? ? ? tegra_i2c_device1.dev.platform_data = &paz00_i2c1_platform_data;
> - ? ? ? tegra_i2c_device2.dev.platform_data = &paz00_i2c2_platform_data;
> - ? ? ? tegra_i2c_device4.dev.platform_data = &paz00_dvc_platform_data;
> -
> ? ? ? ?platform_device_register(&tegra_i2c_device1);
> ? ? ? ?platform_device_register(&tegra_i2c_device2);
> ? ? ? ?platform_device_register(&tegra_i2c_device4);
> diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
> index 783de17..46d5df9 100644
> --- a/arch/arm/mach-tegra/board-seaboard.c
> +++ b/arch/arm/mach-tegra/board-seaboard.c
> @@ -19,7 +19,6 @@
> ?#include <linux/platform_device.h>
> ?#include <linux/serial_8250.h>
> ?#include <linux/i2c.h>
> -#include <linux/i2c-tegra.h>
> ?#include <linux/delay.h>
> ?#include <linux/input.h>
> ?#include <linux/io.h>
> @@ -66,22 +65,6 @@ static __initdata struct tegra_clk_init_table seaboard_clk_init_table[] = {
> ? ? ? ?{ NULL, ? ? ? ? NULL, ? ? ? ? ? 0, ? ? ? ? ? ? ?0},
> ?};
>
> -static struct tegra_i2c_platform_data seaboard_i2c1_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000.
> -};
> -
> -static struct tegra_i2c_platform_data seaboard_i2c2_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> -static struct tegra_i2c_platform_data seaboard_i2c3_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> -static struct tegra_i2c_platform_data seaboard_dvc_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> ?static struct gpio_keys_button seaboard_gpio_keys_buttons[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.code ? ? ? ? ? = SW_LID,
> @@ -161,11 +144,6 @@ static void __init seaboard_i2c_init(void)
>
> ? ? ? ?i2c_register_board_info(4, &adt7461_device, 1);
>
> - ? ? ? tegra_i2c_device1.dev.platform_data = &seaboard_i2c1_platform_data;
> - ? ? ? tegra_i2c_device2.dev.platform_data = &seaboard_i2c2_platform_data;
> - ? ? ? tegra_i2c_device3.dev.platform_data = &seaboard_i2c3_platform_data;
> - ? ? ? tegra_i2c_device4.dev.platform_data = &seaboard_dvc_platform_data;
> -
> ? ? ? ?platform_device_register(&tegra_i2c_device1);
> ? ? ? ?platform_device_register(&tegra_i2c_device2);
> ? ? ? ?platform_device_register(&tegra_i2c_device3);
> diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
> index a8fff42..e1d7e67 100644
> --- a/arch/arm/mach-tegra/board-trimslice.c
> +++ b/arch/arm/mach-tegra/board-trimslice.c
> @@ -24,7 +24,6 @@
> ?#include <linux/serial_8250.h>
> ?#include <linux/io.h>
> ?#include <linux/i2c.h>
> -#include <linux/i2c-tegra.h>
> ?#include <linux/platform_data/tegra_usb.h>
> ?#include <linux/gpio.h>
>
> @@ -92,18 +91,6 @@ static struct platform_device *trimslice_devices[] __initdata = {
> ? ? ? ?&trimslice_audio_device,
> ?};
>
> -static struct tegra_i2c_platform_data trimslice_i2c1_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> -static struct tegra_i2c_platform_data trimslice_i2c2_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> -static struct tegra_i2c_platform_data trimslice_i2c3_platform_data = {
> - ? ? ? .bus_clk_rate ? = 400000,
> -};
> -
> ?static struct i2c_board_info trimslice_i2c3_board_info[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?I2C_BOARD_INFO("tlv320aic23", 0x1a),
> @@ -115,10 +102,6 @@ static struct i2c_board_info trimslice_i2c3_board_info[] = {
>
> ?static void trimslice_i2c_init(void)
> ?{
> - ? ? ? tegra_i2c_device1.dev.platform_data = &trimslice_i2c1_platform_data;
> - ? ? ? tegra_i2c_device2.dev.platform_data = &trimslice_i2c2_platform_data;
> - ? ? ? tegra_i2c_device3.dev.platform_data = &trimslice_i2c3_platform_data;
> -
> ? ? ? ?platform_device_register(&tegra_i2c_device1);
> ? ? ? ?platform_device_register(&tegra_i2c_device2);
> ? ? ? ?platform_device_register(&tegra_i2c_device3);
> diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
> index 1528f9d..066eaf9 100644
> --- a/arch/arm/mach-tegra/devices.c
> +++ b/arch/arm/mach-tegra/devices.c
> @@ -22,6 +22,7 @@
> ?#include <linux/dma-mapping.h>
> ?#include <linux/fsl_devices.h>
> ?#include <linux/serial_8250.h>
> +#include <linux/i2c-tegra.h>
> ?#include <asm/pmu.h>
> ?#include <mach/irqs.h>
> ?#include <mach/iomap.h>
> @@ -79,13 +80,29 @@ static struct resource i2c_resource4[] = {
> ? ? ? ?},
> ?};
>
> +static struct tegra_i2c_platform_data tegra_i2c1_platform_data = {
> + ? ? ? .bus_clk_rate ? = 400000,
> +};
> +
> +static struct tegra_i2c_platform_data tegra_i2c2_platform_data = {
> + ? ? ? .bus_clk_rate ? = 400000,
> +};
> +
> +static struct tegra_i2c_platform_data tegra_i2c3_platform_data = {
> + ? ? ? .bus_clk_rate ? = 400000,
> +};
> +
> +static struct tegra_i2c_platform_data tegra_dvc_platform_data = {
> + ? ? ? .bus_clk_rate ? = 400000,
> +};
> +
> ?struct platform_device tegra_i2c_device1 = {
> ? ? ? ?.name ? ? ? ? ? = "tegra-i2c",
> ? ? ? ?.id ? ? ? ? ? ? = 0,
> ? ? ? ?.resource ? ? ? = i2c_resource1,
> ? ? ? ?.num_resources ?= ARRAY_SIZE(i2c_resource1),
> ? ? ? ?.dev = {
> - ? ? ? ? ? ? ? .platform_data = 0,
> + ? ? ? ? ? ? ? .platform_data = &tegra_i2c1_platform_data,
> ? ? ? ?},
> ?};
>
> @@ -95,7 +112,7 @@ struct platform_device tegra_i2c_device2 = {
> ? ? ? ?.resource ? ? ? = i2c_resource2,
> ? ? ? ?.num_resources ?= ARRAY_SIZE(i2c_resource2),
> ? ? ? ?.dev = {
> - ? ? ? ? ? ? ? .platform_data = 0,
> + ? ? ? ? ? ? ? .platform_data = &tegra_i2c2_platform_data,
> ? ? ? ?},
> ?};
>
> @@ -105,7 +122,7 @@ struct platform_device tegra_i2c_device3 = {
> ? ? ? ?.resource ? ? ? = i2c_resource3,
> ? ? ? ?.num_resources ?= ARRAY_SIZE(i2c_resource3),
> ? ? ? ?.dev = {
> - ? ? ? ? ? ? ? .platform_data = 0,
> + ? ? ? ? ? ? ? .platform_data = &tegra_i2c3_platform_data,
> ? ? ? ?},
> ?};
>
> @@ -115,7 +132,7 @@ struct platform_device tegra_i2c_device4 = {
> ? ? ? ?.resource ? ? ? = i2c_resource4,
> ? ? ? ?.num_resources ?= ARRAY_SIZE(i2c_resource4),
> ? ? ? ?.dev = {
> - ? ? ? ? ? ? ? .platform_data = 0,
> + ? ? ? ? ? ? ? .platform_data = &tegra_dvc_platform_data,
> ? ? ? ?},
> ?};
>
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>



-- 
Sincerely Yours,
Mike.
