From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 20 Sep 2010 22:43:33 +0800
Subject: [PATCH 06/11] ARM: pxa: Colibri PXA320 PCMCIA driver
In-Reply-To: <1284604382-23683-6-git-send-email-marek.vasut@gmail.com>
References: <1284604382-23683-1-git-send-email-marek.vasut@gmail.com>
	<1284604382-23683-6-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTi=X5CiJn5G+QrNXhYBeYiFpnQmTAOk5UOdWgB=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 10:32 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Acked-by: Daniel Mack <daniel@caiaq.de>
> ---
> ?arch/arm/mach-pxa/colibri-pxa320.c | ? 21 +++++++++++++++++++++
> ?drivers/pcmcia/Kconfig ? ? ? ? ? ? | ? ?3 ++-
> ?drivers/pcmcia/Makefile ? ? ? ? ? ?| ? ?1 +
> ?drivers/pcmcia/pxa2xx_colibri.c ? ?| ? 17 ++++++++++++++++-
> ?4 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
> index 7c003cd..6cd83fa 100644
> --- a/arch/arm/mach-pxa/colibri-pxa320.c
> +++ b/arch/arm/mach-pxa/colibri-pxa320.c
> @@ -73,6 +73,27 @@ static mfp_cfg_t colibri_pxa320_evalboard_pin_config[] __initdata = {
> ? ? ? ?/* I2C */
> ? ? ? ?GPIO32_I2C_SCL,
> ? ? ? ?GPIO33_I2C_SDA,
> +
> + ? ? ? /* PCMCIA */
> + ? ? ? MFP_CFG(GPIO59, AF7), ? /* PRST ; AF7 to tristate */
> + ? ? ? MFP_CFG(GPIO61, AF7), ? /* PCE1 ; AF7 to tristate */
> + ? ? ? MFP_CFG(GPIO60, AF7), ? /* PCE2 ; AF7 to tristate */
> + ? ? ? MFP_CFG(GPIO62, AF7), ? /* PCD ; AF7 to tristate */
> + ? ? ? MFP_CFG(GPIO56, AF7), ? /* PSKTSEL ; AF7 to tristate */

If this is useful for other platforms, making them macros would be helpful.

And using MFP_CFG() directly is not encouraged, any specific reason
to use this?

> + ? ? ? GPIO27_GPIO, ? ? ? ? ? ?/* RDnWR ; input/tristate */
> + ? ? ? GPIO50_GPIO, ? ? ? ? ? ?/* PREG ; input/tristate */
> + ? ? ? GPIO2_RDY,
> + ? ? ? GPIO5_NPIOR,
> + ? ? ? GPIO6_NPIOW,
> + ? ? ? GPIO7_NPIOS16,
> + ? ? ? GPIO8_NPWAIT,
> + ? ? ? GPIO29_GPIO, ? ? ? ? ? ?/* PRDY (READY GPIO) */
> + ? ? ? GPIO57_GPIO, ? ? ? ? ? ?/* PPEN (POWER GPIO) */
> + ? ? ? GPIO81_GPIO, ? ? ? ? ? ?/* PCD (DETECT GPIO) */
> + ? ? ? GPIO77_GPIO, ? ? ? ? ? ?/* PRST (RESET GPIO) */
> + ? ? ? GPIO53_GPIO, ? ? ? ? ? ?/* PBVD1 */
> + ? ? ? GPIO79_GPIO, ? ? ? ? ? ?/* PBVD2 */
> + ? ? ? GPIO54_GPIO, ? ? ? ? ? ?/* POE */
> ?};
> ?#else
> ?static mfp_cfg_t colibri_pxa320_evalboard_pin_config[] __initdata = {};
> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index e9acf03..de886f3 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -215,7 +215,8 @@ config PCMCIA_PXA2XX
> ? ? ? ?depends on (ARCH_LUBBOCK || MACH_MAINSTONE || PXA_SHARPSL \
> ? ? ? ? ? ? ? ? ? ?|| MACH_ARMCORE || ARCH_PXA_PALM || TRIZEPS_PCMCIA \
> ? ? ? ? ? ? ? ? ? ?|| ARCOM_PCMCIA || ARCH_PXA_ESERIES || MACH_STARGATE2 \
> - ? ? ? ? ? ? ? ? ? || MACH_VPAC270 || MACH_BALLOON3 || MACH_COLIBRI)
> + ? ? ? ? ? ? ? ? ? || MACH_VPAC270 || MACH_BALLOON3 || MACH_COLIBRI \
> + ? ? ? ? ? ? ? ? ? || MACH_COLIBRI320)
> ? ? ? ?select PCMCIA_SOC_COMMON
> ? ? ? ?help
> ? ? ? ? ?Say Y here to include support for the PXA2xx PCMCIA controller
> diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
> index 2fee7ef..9a44a90 100644
> --- a/drivers/pcmcia/Makefile
> +++ b/drivers/pcmcia/Makefile
> @@ -71,6 +71,7 @@ pxa2xx-obj-$(CONFIG_MACH_STARGATE2) ? ? ? ? ? += pxa2xx_stargate2.o
> ?pxa2xx-obj-$(CONFIG_MACH_VPAC270) ? ? ? ? ? ? ?+= pxa2xx_vpac270.o
> ?pxa2xx-obj-$(CONFIG_MACH_BALLOON3) ? ? ? ? ? ? += pxa2xx_balloon3.o
> ?pxa2xx-obj-$(CONFIG_MACH_COLIBRI) ? ? ? ? ? ? ?+= pxa2xx_colibri.o
> +pxa2xx-obj-$(CONFIG_MACH_COLIBRI320) ? ? ? ? ? += pxa2xx_colibri.o
>
> ?obj-$(CONFIG_PCMCIA_PXA2XX) ? ? ? ? ? ? ? ? ? ?+= pxa2xx_base.o $(pxa2xx-obj-y)
>
> diff --git a/drivers/pcmcia/pxa2xx_colibri.c b/drivers/pcmcia/pxa2xx_colibri.c
> index 4ed876c..c3f7219 100644
> --- a/drivers/pcmcia/pxa2xx_colibri.c
> +++ b/drivers/pcmcia/pxa2xx_colibri.c
> @@ -27,6 +27,13 @@
> ?#define ? ? ? ?COLIBRI270_DETECT_GPIO ?84
> ?#define ? ? ? ?COLIBRI270_READY_GPIO ? 1
>
> +#define ? ? ? ?COLIBRI320_RESET_GPIO ? 77
> +#define ? ? ? ?COLIBRI320_PPEN_GPIO ? ?57
> +#define ? ? ? ?COLIBRI320_BVD1_GPIO ? ?53
> +#define ? ? ? ?COLIBRI320_BVD2_GPIO ? ?79
> +#define ? ? ? ?COLIBRI320_DETECT_GPIO ?81
> +#define ? ? ? ?COLIBRI320_READY_GPIO ? 29
> +
> ?static struct {
> ? ? ? ?int ? ? reset_gpio;
> ? ? ? ?int ? ? ppen_gpio;
> @@ -186,6 +193,14 @@ static int __init colibri_pcmcia_init(void)
> ? ? ? ? ? ? ? ?colibri_pcmcia_gpio.bvd2_gpio ? = COLIBRI270_BVD2_GPIO;
> ? ? ? ? ? ? ? ?colibri_pcmcia_gpio.detect_gpio = COLIBRI270_DETECT_GPIO;
> ? ? ? ? ? ? ? ?colibri_pcmcia_gpio.ready_gpio ?= COLIBRI270_READY_GPIO;
> + ? ? ? /* Colibri PXA320 */
> + ? ? ? } else if (machine_is_colibri320()) {
> + ? ? ? ? ? ? ? colibri_pcmcia_gpio.reset_gpio ?= COLIBRI320_RESET_GPIO;
> + ? ? ? ? ? ? ? colibri_pcmcia_gpio.ppen_gpio ? = COLIBRI320_PPEN_GPIO;
> + ? ? ? ? ? ? ? colibri_pcmcia_gpio.bvd1_gpio ? = COLIBRI320_BVD1_GPIO;
> + ? ? ? ? ? ? ? colibri_pcmcia_gpio.bvd2_gpio ? = COLIBRI320_BVD2_GPIO;
> + ? ? ? ? ? ? ? colibri_pcmcia_gpio.detect_gpio = COLIBRI320_DETECT_GPIO;
> + ? ? ? ? ? ? ? colibri_pcmcia_gpio.ready_gpio ?= COLIBRI320_READY_GPIO;
> ? ? ? ?}
>
> ? ? ? ?ret = platform_device_add_data(colibri_pcmcia_device,
> @@ -209,6 +224,6 @@ module_init(colibri_pcmcia_init);
> ?module_exit(colibri_pcmcia_exit);
>
> ?MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
> -MODULE_DESCRIPTION("PCMCIA support for Toradex Colibri PXA270");
> +MODULE_DESCRIPTION("PCMCIA support for Toradex Colibri PXA270/PXA320");
> ?MODULE_ALIAS("platform:pxa2xx-pcmcia");
> ?MODULE_LICENSE("GPL");
> --
> 1.7.1
>
>
