From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Apr 2011 12:53:30 -0300
Subject: [PATCH 4/9] ARM i.MX51 babbage: Add framebuffer support
In-Reply-To: <1303738777-27626-1-git-send-email-weitway@gmail.com>
References: <1303738777-27626-1-git-send-email-weitway@gmail.com>
Message-ID: <BANLkTinobY1LM5_ZBGE77vf=1zY_Vw9xRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Mon, Apr 25, 2011 at 10:39 AM,  <weitway@gmail.com> wrote:
> From: Jason Chen <b02280@freescale.com>
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Jason Chen <Jason.Chen@freescale.com>
> Signed-off-by: Jason Chen <Jason.Chen@linaro.org>
> ---
> ?arch/arm/mach-mx5/Kconfig ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-mx5/board-mx51_babbage.c | ? 74 ++++++++++++++++++++++++++++++++
> ?2 files changed, 75 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 799fbc4..a512364 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -70,6 +70,7 @@ config MACH_MX51_BABBAGE
> ? ? ? ?select IMX_HAVE_PLATFORM_IMX_UART
> ? ? ? ?select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> ? ? ? ?select IMX_HAVE_PLATFORM_SPI_IMX
> + ? ? ? select IMX_HAVE_PLATFORM_IMX_IPUV3
> ? ? ? ?help
> ? ? ? ? ?Include support for MX51 Babbage platform, also known as MX51EVK in
> ? ? ? ? ?u-boot. This includes specific configurations for the board and its
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index c7b3fab..5689220 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -19,10 +19,12 @@
> ?#include <linux/input.h>
> ?#include <linux/spi/flash.h>
> ?#include <linux/spi/spi.h>
> +#include <video/imx-ipu-v3.h>
>
> ?#include <mach/common.h>
> ?#include <mach/hardware.h>
> ?#include <mach/iomux-mx51.h>
> +#include <mach/ipu-v3.h>
>
> ?#include <asm/irq.h>
> ?#include <asm/setup.h>
> @@ -154,6 +156,41 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
> ? ? ? ?MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
> ? ? ? ?MX51_PAD_CSPI1_SS0__GPIO4_24,
> ? ? ? ?MX51_PAD_CSPI1_SS1__GPIO4_25,
> +
> + ? ? ? /* Display */
> + ? ? ? MX51_PAD_DISPB2_SER_DIN__GPIO3_5,
> + ? ? ? MX51_PAD_DISPB2_SER_DIO__GPIO3_6,
> + ? ? ? MX51_PAD_NANDF_D12__GPIO3_28,
> +
> + ? ? ? MX51_PAD_DISP1_DAT0__DISP1_DAT0,
> + ? ? ? MX51_PAD_DISP1_DAT1__DISP1_DAT1,
> + ? ? ? MX51_PAD_DISP1_DAT2__DISP1_DAT2,
> + ? ? ? MX51_PAD_DISP1_DAT3__DISP1_DAT3,
> + ? ? ? MX51_PAD_DISP1_DAT4__DISP1_DAT4,
> + ? ? ? MX51_PAD_DISP1_DAT5__DISP1_DAT5,
> + ? ? ? MX51_PAD_DISP1_DAT6__DISP1_DAT6,
> + ? ? ? MX51_PAD_DISP1_DAT7__DISP1_DAT7,
> + ? ? ? MX51_PAD_DISP1_DAT8__DISP1_DAT8,
> + ? ? ? MX51_PAD_DISP1_DAT9__DISP1_DAT9,
> + ? ? ? MX51_PAD_DISP1_DAT10__DISP1_DAT10,
> + ? ? ? MX51_PAD_DISP1_DAT11__DISP1_DAT11,
> + ? ? ? MX51_PAD_DISP1_DAT12__DISP1_DAT12,
> + ? ? ? MX51_PAD_DISP1_DAT13__DISP1_DAT13,
> + ? ? ? MX51_PAD_DISP1_DAT14__DISP1_DAT14,
> + ? ? ? MX51_PAD_DISP1_DAT15__DISP1_DAT15,
> + ? ? ? MX51_PAD_DISP1_DAT16__DISP1_DAT16,
> + ? ? ? MX51_PAD_DISP1_DAT17__DISP1_DAT17,
> + ? ? ? MX51_PAD_DISP1_DAT18__DISP1_DAT18,
> + ? ? ? MX51_PAD_DISP1_DAT19__DISP1_DAT19,
> + ? ? ? MX51_PAD_DISP1_DAT20__DISP1_DAT20,
> + ? ? ? MX51_PAD_DISP1_DAT21__DISP1_DAT21,
> + ? ? ? MX51_PAD_DISP1_DAT22__DISP1_DAT22,
> + ? ? ? MX51_PAD_DISP1_DAT23__DISP1_DAT23,
> +#define MX51_PAD_DI_GP4__IPU_DI2_PIN15 ? ? ? ? ? ? ? ? IOMUX_PAD(0x758, 0x350, 4, 0x0, ? 0, NO_PAD_CTRL)
> + ? ? ? MX51_PAD_DI_GP4__IPU_DI2_PIN15,
> +
> + ? ? ? /* I2C DVI enable */
> + ? ? ? MX51_PAD_CSI2_HSYNC__GPIO4_14,
> ?};
>
> ?/* Serial ports */
> @@ -331,6 +368,23 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
> ? ? ? ?.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
> ?};
>
> +static struct ipuv3_fb_platform_data babbage_fb0_data = {
> + ? ? ? .interface_pix_fmt = IPU_PIX_FMT_RGB24,
> + ? ? ? .flags = IMX_IPU_FB_USE_MODEDB | IMX_IPU_FB_USE_OVERLAY,
> + ? ? ? .display = 0,
> +};
> +
> +static struct ipuv3_fb_platform_data babbage_fb1_data = {
> + ? ? ? .interface_pix_fmt = IPU_PIX_FMT_RGB565,
> + ? ? ? .flags = IMX_IPU_FB_USE_MODEDB,
> + ? ? ? .display = 1,
> +};
> +
> +static struct imx_ipuv3_platform_data ipu_data = {
> + ? ? ? .fb_head0_platform_data = &babbage_fb0_data,
> + ? ? ? .fb_head1_platform_data = &babbage_fb1_data,
> +};
> +
> ?/*
> ?* Board specific initialization.
> ?*/
> @@ -381,6 +435,26 @@ static void __init mx51_babbage_init(void)
> ? ? ? ? ? ? ? ?ARRAY_SIZE(mx51_babbage_spi_board_info));
> ? ? ? ?imx51_add_ecspi(0, &mx51_babbage_spi_pdata);
> ? ? ? ?imx51_add_imx2_wdt(0, NULL);
> +
> +#define GPIO_DVI_DETECT ? ? ? ?(2 * 32 + 28)
> +#define GPIO_DVI_RESET (2 * 32 + 5)
> +#define GPIO_DVI_PWRDN (2 * 32 + 6)
> +#define GPIO_DVI_I2C ? (3 * 32 + 14)
> +
> + ? ? ? /* DVI Detect */
> + ? ? ? gpio_request(GPIO_DVI_DETECT, "dvi detect");
> + ? ? ? gpio_direction_input(GPIO_DVI_DETECT);
> + ? ? ? /* DVI Reset - Assert for i2c disabled mode */
> + ? ? ? gpio_request(GPIO_DVI_RESET, "dvi reset");
> + ? ? ? gpio_direction_output(GPIO_DVI_RESET, 0);
> + ? ? ? /* DVI Power-down */
> + ? ? ? gpio_request(GPIO_DVI_PWRDN, "dvi pwdn");
> + ? ? ? gpio_direction_output(GPIO_DVI_PWRDN, 1);
> +
> + ? ? ? gpio_request(GPIO_DVI_I2C, "dvi i2c");
> + ? ? ? gpio_direction_output(GPIO_DVI_I2C, 0);

Please use gpio_request_one instead of gpio_request followed by
gpio_direction calls.

Regards,

Fabio Estevam
