From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 26 May 2010 22:07:26 +0800
Subject: [PATCH 6/8] ARM: pxa/colibri-pxa270: split module and base board
	code
In-Reply-To: <1274480980-10109-7-git-send-email-marek.vasut@gmail.com>
References: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
	<1274480980-10109-7-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTim09vmtc2WYqQP4eIwwgn5CKli0nxedgIb96NUR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 22, 2010 at 6:29 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> From: Daniel Mack <daniel@caiaq.de>
>
> Follow the idea of several MX31 based boards and split code that is
> related to the module from code that is baseboard specific. This makes
> adding new base board support easier, while avoiding code duplication.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/Kconfig ? ? ? ? ? ? ? ? ? ?| ? ?4 +
> ?arch/arm/mach-pxa/Makefile ? ? ? ? ? ? ? ? ? | ? ?3 +-
> ?arch/arm/mach-pxa/colibri-pxa270-evalboard.c | ?111 ++++++++++++++++++++++++++
> ?arch/arm/mach-pxa/colibri-pxa270.c ? ? ? ? ? | ?107 +++++--------------------
> ?arch/arm/mach-pxa/include/mach/colibri.h ? ? | ? 14 +++
> ?5 files changed, 151 insertions(+), 88 deletions(-)
> ?create mode 100644 arch/arm/mach-pxa/colibri-pxa270-evalboard.c
>
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 3b51741..819b44f 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -238,6 +238,10 @@ config MACH_COLIBRI
> ? ? ? ?bool "Toradex Colibri PXA270"
> ? ? ? ?select PXA27x
>
> +config MACH_COLIBRI_PXA270_EVALBOARD
> + ? ? ? bool "Toradex Colibri Evaluation Carrier Board support (PXA270)"
> + ? ? ? depends on MACH_COLIBRI
> +
> ?config MACH_COLIBRI300
> ? ? ? ?bool "Toradex Colibri PXA300/310"
> ? ? ? ?select PXA3xx
> diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> index b8f1f4b..4751c9d 100644
> --- a/arch/arm/mach-pxa/Makefile
> +++ b/arch/arm/mach-pxa/Makefile
> @@ -58,7 +58,8 @@ obj-$(CONFIG_MACH_TRIZEPS4) ? += trizeps4.o
> ?obj-$(CONFIG_MACH_LOGICPD_PXA270) ? ? ?+= lpd270.o
> ?obj-$(CONFIG_MACH_PCM027) ? ? ? ? ? ? ?+= pcm027.o
> ?obj-$(CONFIG_MACH_PCM990_BASEBOARD) ? ?+= pcm990-baseboard.o
> -obj-$(CONFIG_MACH_COLIBRI) ? ? += colibri-pxa270.o
> +obj-$(CONFIG_MACH_COLIBRI) ? ? ? ? ? ? ? ? ? ? += colibri-pxa270.o
> +obj-$(CONFIG_MACH_COLIBRI_PXA270_EVALBOARD) ? ?+= colibri-pxa270-evalboard.o
> ?obj-$(CONFIG_MACH_COLIBRI300) ?+= colibri-pxa3xx.o colibri-pxa300.o
> ?obj-$(CONFIG_MACH_COLIBRI320) ?+= colibri-pxa3xx.o colibri-pxa320.o
> ?obj-$(CONFIG_MACH_VPAC270) ? ? += vpac270.o
> diff --git a/arch/arm/mach-pxa/colibri-pxa270-evalboard.c b/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> new file mode 100644
> index 0000000..0f3b632
> --- /dev/null
> +++ b/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> @@ -0,0 +1,111 @@
> +/*
> + * ?linux/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> + *
> + * ?Support for Toradex PXA270 based Colibri Evaluation Carrier Board
> + * ?Daniel Mack <daniel@caiaq.de>
> + * ?Marek Vasut <marek.vasut@gmail.com>
> + *
> + * ?This program is free software; you can redistribute it and/or modify
> + * ?it under the terms of the GNU General Public License version 2 as
> + * ?published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysdev.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <asm/mach-types.h>
> +#include <mach/hardware.h>
> +#include <asm/mach/arch.h>
> +
> +#include <mach/pxa27x.h>
> +#include <mach/colibri.h>
> +#include <mach/mmc.h>
> +#include <mach/ohci.h>
> +#include <mach/pxa27x-udc.h>
> +
> +#include "generic.h"
> +#include "devices.h"
> +
> +/******************************************************************************
> + * Pin configuration
> + ******************************************************************************/
> +static mfp_cfg_t colibri_pxa270_evalboard_pin_config[] __initdata = {
> + ? ? ? /* MMC */
> + ? ? ? GPIO32_MMC_CLK,
> + ? ? ? GPIO92_MMC_DAT_0,
> + ? ? ? GPIO109_MMC_DAT_1,
> + ? ? ? GPIO110_MMC_DAT_2,
> + ? ? ? GPIO111_MMC_DAT_3,
> + ? ? ? GPIO112_MMC_CMD,
> + ? ? ? GPIO0_GPIO, ? ? /* SD detect */
> +
> + ? ? ? /* FFUART */
> + ? ? ? GPIO39_FFUART_TXD,
> + ? ? ? GPIO34_FFUART_RXD,
> +
> + ? ? ? /* UHC */
> + ? ? ? GPIO88_USBH1_PWR,
> + ? ? ? GPIO89_USBH1_PEN,
> + ? ? ? GPIO119_USBH2_PWR,
> + ? ? ? GPIO120_USBH2_PEN,
> +};
> +
> +/******************************************************************************
> + * SD/MMC card controller
> + ******************************************************************************/
> +#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
> +static struct pxamci_platform_data colibri_pxa270_mci_platform_data = {
> + ? ? ? .ocr_mask ? ? ? ? ? ? ? = MMC_VDD_32_33 | MMC_VDD_33_34,
> + ? ? ? .gpio_power ? ? ? ? ? ? = -1,
> + ? ? ? .gpio_card_detect ? ? ? = GPIO0_COLIBRI_PXA270_SD_DETECT,
> + ? ? ? .gpio_card_ro ? ? ? ? ? = -1,
> + ? ? ? .detect_delay_ms ? ? ? ?= 200,
> +};
> +
> +static void __init colibri_pxa270_mmc_init(void)
> +{
> + ? ? ? pxa_set_mci_info(&colibri_pxa270_mci_platform_data);
> +}
> +#else
> +static inline void colibri_pxa270_mmc_init(void) {}
> +#endif
> +
> +/******************************************************************************
> + * USB Host
> + ******************************************************************************/
> +#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> +static int colibri_pxa270_ohci_init(struct device *dev)
> +{
> + ? ? ? UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
> + ? ? ? return 0;
> +}
> +
> +static struct pxaohci_platform_data colibri_pxa270_ohci_info = {
> + ? ? ? .port_mode ? ? ?= PMM_PERPORT_MODE,
> + ? ? ? .flags ? ? ? ? ?= ENABLE_PORT1 | ENABLE_PORT2 |
> + ? ? ? ? ? ? ? ? ? ? ? ? POWER_CONTROL_LOW | POWER_SENSE_LOW,
> + ? ? ? .init ? ? ? ? ? = colibri_pxa270_ohci_init,
> +};
> +
> +static void __init colibri_pxa270_uhc_init(void)
> +{
> + ? ? ? pxa_set_ohci_info(&colibri_pxa270_ohci_info);
> +}
> +#else
> +static inline void colibri_pxa270_uhc_init(void) {}
> +#endif
> +
> +void __init colibri_pxa270_evalboard_init(void)
> +{
> + ? ? ? pxa2xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa270_evalboard_pin_config));
> + ? ? ? pxa_set_ffuart_info(NULL);
> + ? ? ? pxa_set_btuart_info(NULL);
> + ? ? ? pxa_set_stuart_info(NULL);
> +
> + ? ? ? colibri_pxa270_mmc_init();
> + ? ? ? colibri_pxa270_uhc_init();
> +}
> +
> diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
> index 6e0d623..c1b8880 100644
> --- a/arch/arm/mach-pxa/colibri-pxa270.c
> +++ b/arch/arm/mach-pxa/colibri-pxa270.c
> @@ -11,36 +11,26 @@
> ?*/
>
> ?#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/platform_device.h>
> -#include <linux/sysdev.h>
> ?#include <linux/interrupt.h>
> -#include <linux/bitops.h>
> -#include <linux/ioport.h>
> -#include <linux/delay.h>
> +#include <linux/kernel.h>
> ?#include <linux/mtd/mtd.h>
> ?#include <linux/mtd/partitions.h>
> ?#include <linux/mtd/physmap.h>
> -#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysdev.h>
> ?#include <linux/ucb1400.h>
> -#include <asm/mach-types.h>
> -#include <mach/hardware.h>
> -#include <asm/irq.h>
> -#include <asm/sizes.h>
> +
> ?#include <asm/mach/arch.h>
> -#include <asm/mach/map.h>
> -#include <asm/mach/irq.h>
> ?#include <asm/mach/flash.h>
> +#include <asm/mach-types.h>
> +#include <asm/sizes.h>
>
> ?#include <mach/audio.h>
> -#include <mach/pxa27x.h>
> ?#include <mach/colibri.h>
> -#include <mach/mmc.h>
> -#include <mach/ohci.h>
> -#include <mach/pxa27x-udc.h>
> +#include <mach/pxa27x.h>
>
> -#include "generic.h"
> ?#include "devices.h"
> +#include "generic.h"
>
> ?/******************************************************************************
> ?* Pin configuration
> @@ -50,25 +40,6 @@ static mfp_cfg_t colibri_pxa270_pin_config[] __initdata = {
> ? ? ? ?GPIO78_nCS_2, ? /* Ethernet CS */
> ? ? ? ?GPIO114_GPIO, ? /* Ethernet IRQ */
>
> - ? ? ? /* MMC */
> - ? ? ? GPIO32_MMC_CLK,
> - ? ? ? GPIO92_MMC_DAT_0,
> - ? ? ? GPIO109_MMC_DAT_1,
> - ? ? ? GPIO110_MMC_DAT_2,
> - ? ? ? GPIO111_MMC_DAT_3,
> - ? ? ? GPIO112_MMC_CMD,
> - ? ? ? GPIO0_GPIO, ? ? /* SD detect */
> -
> - ? ? ? /* FFUART */
> - ? ? ? GPIO39_FFUART_TXD,
> - ? ? ? GPIO34_FFUART_RXD,
> -
> - ? ? ? /* UHC */
> - ? ? ? GPIO88_USBH1_PWR,
> - ? ? ? GPIO89_USBH1_PEN,
> - ? ? ? GPIO119_USBH2_PWR,
> - ? ? ? GPIO120_USBH2_PEN,
> -
> ? ? ? ?/* AC97 */
> ? ? ? ?GPIO28_AC97_BITCLK,
> ? ? ? ?GPIO29_AC97_SDATA_IN_0,
> @@ -172,51 +143,6 @@ static inline void colibri_pxa270_eth_init(void) {}
> ?#endif
>
> ?/******************************************************************************
> - * SD/MMC card controller
> - ******************************************************************************/
> -#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
> -static struct pxamci_platform_data colibri_pxa270_mci_platform_data = {
> - ? ? ? .ocr_mask ? ? ? ? ? ? ? = MMC_VDD_32_33 | MMC_VDD_33_34,
> - ? ? ? .gpio_power ? ? ? ? ? ? = -1,
> - ? ? ? .gpio_card_detect ? ? ? = GPIO0_COLIBRI_PXA270_SD_DETECT,
> - ? ? ? .gpio_card_ro ? ? ? ? ? = -1,
> - ? ? ? .detect_delay_ms ? ? ? ?= 200,
> -};
> -
> -static void __init colibri_pxa270_mmc_init(void)
> -{
> - ? ? ? pxa_set_mci_info(&colibri_pxa270_mci_platform_data);
> -}
> -#else
> -static inline void colibri_pxa270_mmc_init(void) {}
> -#endif
> -
> -/******************************************************************************
> - * USB Host
> - ******************************************************************************/
> -#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> -static int colibri_pxa270_ohci_init(struct device *dev)
> -{
> - ? ? ? UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
> - ? ? ? return 0;
> -}
> -
> -static struct pxaohci_platform_data colibri_pxa270_ohci_info = {
> - ? ? ? .port_mode ? ? ?= PMM_PERPORT_MODE,
> - ? ? ? .flags ? ? ? ? ?= ENABLE_PORT1 | ENABLE_PORT2 |
> - ? ? ? ? ? ? ? ? ? ? ? POWER_CONTROL_LOW | POWER_SENSE_LOW,
> - ? ? ? .init ? ? ? ? ? = colibri_pxa270_ohci_init,
> -};
> -
> -static void __init colibri_pxa270_uhc_init(void)
> -{
> - ? ? ? pxa_set_ohci_info(&colibri_pxa270_ohci_info);
> -}
> -#else
> -static inline void colibri_pxa270_uhc_init(void) {}
> -#endif
> -
> -/******************************************************************************
> ?* Audio and Touchscreen
> ?******************************************************************************/
> ?#if ? ?defined(CONFIG_TOUCHSCREEN_UCB1400) || \
> @@ -246,18 +172,25 @@ static void __init colibri_pxa270_tsc_init(void)
> ?static inline void colibri_pxa270_tsc_init(void) {}
> ?#endif
>
> +static int colibri_pxa270_baseboard;
> +core_param(colibri_pxa270_baseboard, colibri_pxa270_baseboard, int, 0444);
> +
> ?static void __init colibri_pxa270_init(void)
> ?{
> ? ? ? ?pxa2xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa270_pin_config));
> - ? ? ? pxa_set_ffuart_info(NULL);
> - ? ? ? pxa_set_btuart_info(NULL);
> - ? ? ? pxa_set_stuart_info(NULL);
>
> ? ? ? ?colibri_pxa270_nor_init();
> ? ? ? ?colibri_pxa270_eth_init();
> - ? ? ? colibri_pxa270_mmc_init();
> - ? ? ? colibri_pxa270_uhc_init();
> ? ? ? ?colibri_pxa270_tsc_init();
> +
> + ? ? ? switch (colibri_pxa270_baseboard) {
> + ? ? ? case COLIBRI_PXA270_EVALBOARD:
> + ? ? ? ? ? ? ? colibri_pxa270_evalboard_init();
> + ? ? ? ? ? ? ? break;
> + ? ? ? default:
> + ? ? ? ? ? ? ? printk(KERN_ERR "Illegal colibri_pxa270_baseboard type %d\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? colibri_pxa270_baseboard);
> + ? ? ? }
> ?}
>
> ?MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
> diff --git a/arch/arm/mach-pxa/include/mach/colibri.h b/arch/arm/mach-pxa/include/mach/colibri.h
> index 8579b10..6434f66 100644
> --- a/arch/arm/mach-pxa/include/mach/colibri.h
> +++ b/arch/arm/mach-pxa/include/mach/colibri.h
> @@ -5,6 +5,20 @@
> ?#include <mach/mfp.h>
>
> ?/*
> + * base board glue for PXA270 module
> + */
> +
> +enum {
> + ? ? ? COLIBRI_PXA270_EVALBOARD = 0,
> +};
> +
> +#if defined(CONFIG_MACH_COLIBRI_PXA270_EVALBOARD)
> +extern void colibri_pxa270_evalboard_init(void);
> +#else
> +static inline void colibri_pxa270_evalboard_init(void) {}
> +#endif
> +
> +/*
> ?* common settings for all modules
> ?*/
>
> --
> 1.7.0
>
>
