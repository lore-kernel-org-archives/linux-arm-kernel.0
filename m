From: jaume@fqingenieria.es (Jaume Ribot)
Date: Fri, 26 Nov 2010 16:04:58 +0100
Subject: [PATCH 28/51] ARM: mx25: dynamically allocate mxc-ehci devices
In-Reply-To: <1290029419-21435-28-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
	<1290029419-21435-28-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4CEFCC9A.2020500@fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Uwe,

I think there is an error in the Freescale documentation, as new 0x200 
offset (as it might be according reference manual) makes usbh2 stops 
working.

Other users have experienced simmilar issues:
http://forums.freescale.com/t5/i-MX-Microprocessors/i-MX25-USBOH-host-core-port-on-chip-serial-PHY-Control/m-p/59365

I think old 0x400 offset value were correct.
Anyone can confirm?

On 17/11/2010 22:29, Uwe Kleine-K?nig wrote:
> According to the reference manual of the i.MX25 the host controller uses an
> offset of 0x200 not 0x400 as was specified in the resources for mxc_usbh2.
>
> Needs-Testing: yes
> Signed-off-by: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
> ---
>   arch/arm/mach-mx25/Kconfig                    |    6 ++-
>   arch/arm/mach-mx25/devices-imx25.h            |    7 ++++
>   arch/arm/mach-mx25/devices.c                  |   44 ++----------------------
>   arch/arm/mach-mx25/devices.h                  |    2 -
>   arch/arm/mach-mx25/mach-cpuimx25.c            |    9 ++---
>   arch/arm/mach-mx25/mach-mx25_3ds.c            |    2 +-
>   arch/arm/plat-mxc/devices/platform-mxc-ehci.c |    7 ++++
>   arch/arm/plat-mxc/ehci.c                      |    4 +-
>   arch/arm/plat-mxc/include/mach/mx25.h         |    6 +++-
>   9 files changed, 34 insertions(+), 53 deletions(-)
>
> diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
> index 38ca09a..b55585b 100644
> --- a/arch/arm/mach-mx25/Kconfig
> +++ b/arch/arm/mach-mx25/Kconfig
> @@ -5,16 +5,18 @@ comment "MX25 platforms:"
>   config MACH_MX25_3DS
>   	bool "Support MX25PDK (3DS) Platform"
>   	select IMX_HAVE_PLATFORM_IMX_UART
> +	select IMX_HAVE_PLATFORM_MXC_EHCI
>   	select IMX_HAVE_PLATFORM_MXC_NAND
>   	select IMX_HAVE_PLATFORM_ESDHC
>
>   config MACH_EUKREA_CPUIMX25
>   	bool "Support Eukrea CPUIMX25 Platform"
> +	select IMX_HAVE_PLATFORM_ESDHC
> +	select IMX_HAVE_PLATFORM_FLEXCAN
>   	select IMX_HAVE_PLATFORM_IMX_I2C
>   	select IMX_HAVE_PLATFORM_IMX_UART
> +	select IMX_HAVE_PLATFORM_MXC_EHCI
>   	select IMX_HAVE_PLATFORM_MXC_NAND
> -	select IMX_HAVE_PLATFORM_FLEXCAN
> -	select IMX_HAVE_PLATFORM_ESDHC
>   	select MXC_ULPI if USB_ULPI
>
>   choice
> diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
> index f62ce93..ac343ae 100644
> --- a/arch/arm/mach-mx25/devices-imx25.h
> +++ b/arch/arm/mach-mx25/devices-imx25.h
> @@ -39,6 +39,13 @@ extern const struct imx_imx_uart_1irq_data imx25_imx_uart_data[] __initconst;
>   #define imx25_add_imx_uart3(pdata)	imx25_add_imx_uart(3, pdata)
>   #define imx25_add_imx_uart4(pdata)	imx25_add_imx_uart(4, pdata)
>
> +extern const struct imx_mxc_ehci_data imx25_mxc_ehci_otg_data __initconst;
> +#define imx25_add_mxc_ehci_otg(pdata)	\
> +	imx_add_mxc_ehci(&imx25_mxc_ehci_otg_data, pdata)
> +extern const struct imx_mxc_ehci_data imx25_mxc_ehci_hs_data __initconst;
> +#define imx25_add_mxc_ehci_hs(pdata)	\
> +	imx_add_mxc_ehci(&imx25_mxc_ehci_hs_data, pdata)
> +
>   extern const struct imx_mxc_nand_data imx25_mxc_nand_data __initconst;
>   #define imx25_add_mxc_nand(pdata)	\
>   	imx_add_mxc_nand(&imx25_mxc_nand_data, pdata)
> diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
> index 92eb1a9..4611c76 100644
> --- a/arch/arm/mach-mx25/devices.c
> +++ b/arch/arm/mach-mx25/devices.c
> @@ -26,27 +26,16 @@ static u64 otg_dmamask = DMA_BIT_MASK(32);
>
>   static struct resource mxc_otg_resources[] = {
>   	{
> -		.start = MX25_OTG_BASE_ADDR,
> -		.end = MX25_OTG_BASE_ADDR + 0x1ff,
> +		.start = MX25_USB_OTG_BASE_ADDR,
> +		.end = MX25_USB_OTG_BASE_ADDR + 0x1ff,
>   		.flags = IORESOURCE_MEM,
>   	}, {
> -		.start = 37,
> -		.end = 37,
> +		.start = MX25_INT_USB_OTG,
> +		.end = MX25_INT_USB_OTG,
>   		.flags = IORESOURCE_IRQ,
>   	},
>   };
>
> -struct platform_device mxc_otg = {
> -	.name = "mxc-ehci",
> -	.id = 0,
> -	.dev = {
> -		.coherent_dma_mask = 0xffffffff,
> -		.dma_mask =&otg_dmamask,
> -	},
> -	.resource = mxc_otg_resources,
> -	.num_resources = ARRAY_SIZE(mxc_otg_resources),
> -};
> -
>   /* OTG gadget device */
>   struct platform_device otg_udc_device = {
>   	.name = "fsl-usb2-udc",
> @@ -59,31 +48,6 @@ struct platform_device otg_udc_device = {
>   	.num_resources = ARRAY_SIZE(mxc_otg_resources),
>   };
>
> -static u64 usbh2_dmamask = DMA_BIT_MASK(32);
> -
> -static struct resource mxc_usbh2_resources[] = {
> -	{
> -		.start = MX25_OTG_BASE_ADDR + 0x400,
> -		.end = MX25_OTG_BASE_ADDR + 0x5ff,
> -		.flags = IORESOURCE_MEM,
> -	}, {
> -		.start = 35,
> -		.end = 35,
> -		.flags = IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device mxc_usbh2 = {
> -	.name = "mxc-ehci",
> -	.id = 1,
> -	.dev = {
> -		.coherent_dma_mask = 0xffffffff,
> -		.dma_mask =&usbh2_dmamask,
> -	},
> -	.resource = mxc_usbh2_resources,
> -	.num_resources = ARRAY_SIZE(mxc_usbh2_resources),
> -};
> -
>   static struct resource mxc_pwm_resources0[] = {
>   	{
>   		.start	= 0x53fe0000,
> diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
> index 7b70a43..e6ad640 100644
> --- a/arch/arm/mach-mx25/devices.h
> +++ b/arch/arm/mach-mx25/devices.h
> @@ -1,6 +1,4 @@
> -extern struct platform_device mxc_otg;
>   extern struct platform_device otg_udc_device;
> -extern struct platform_device mxc_usbh2;
>   extern struct platform_device mxc_pwm_device0;
>   extern struct platform_device mxc_pwm_device1;
>   extern struct platform_device mxc_pwm_device2;
> diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
> index f6f9ad6..0ee0fe7 100644
> --- a/arch/arm/mach-mx25/mach-cpuimx25.c
> +++ b/arch/arm/mach-mx25/mach-cpuimx25.c
> @@ -39,7 +39,6 @@
>   #include<mach/mx25.h>
>   #include<mach/mxc_nand.h>
>   #include<mach/imxfb.h>
> -#include<mach/mxc_ehci.h>
>   #include<mach/iomux-mx25.h>
>
>   #include "devices-imx25.h"
> @@ -87,12 +86,12 @@ static struct i2c_board_info eukrea_cpuimx25_i2c_devices[] = {
>   	},
>   };
>
> -static struct mxc_usbh_platform_data otg_pdata = {
> +static const struct mxc_usbh_platform_data otg_pdata __initconst = {
>   	.portsc	= MXC_EHCI_MODE_UTMI,
>   	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
>   };
>
> -static struct mxc_usbh_platform_data usbh2_pdata = {
> +static const struct mxc_usbh_platform_data usbh2_pdata __initconst = {
>   	.portsc	= MXC_EHCI_MODE_SERIAL,
>   	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
>   		  MXC_EHCI_IPPUE_DOWN,
> @@ -134,11 +133,11 @@ static void __init eukrea_cpuimx25_init(void)
>   	imx25_add_imx_i2c0(&eukrea_cpuimx25_i2c0_data);
>
>   	if (otg_mode_host)
> -		mxc_register_device(&mxc_otg,&otg_pdata);
> +		imx25_add_mxc_ehci_otg(&otg_pdata);
>   	else
>   		mxc_register_device(&otg_udc_device,&otg_device_pdata);
>
> -	mxc_register_device(&mxc_usbh2,&usbh2_pdata);
> +	imx25_add_mxc_ehci_hs(&usbh2_pdata);
>
>   #ifdef CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD
>   	eukrea_mbimxsd25_baseboard_init();
> diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
> index f8be1eb..574c41f 100644
> --- a/arch/arm/mach-mx25/mach-mx25_3ds.c
> +++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
> @@ -192,7 +192,7 @@ static void __init mx25pdk_init(void)
>   			ARRAY_SIZE(mx25pdk_pads));
>
>   	imx25_add_imx_uart0(&uart_pdata);
> -	mxc_register_device(&mxc_usbh2, NULL);
> +	imx25_add_mxc_ehci_hs(NULL);
>   	imx25_add_mxc_nand(&mx25pdk_nand_board_info);
>   	mxc_register_device(&mx25_rtc_device, NULL);
>   	mxc_register_device(&mx25_fb_device,&mx25pdk_fb_pdata);
> diff --git a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
> index 0cb67bb..825a048ca 100644
> --- a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
> +++ b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
> @@ -16,6 +16,13 @@
>   		.irq = soc ## _INT_USB_ ## hs,				\
>   	}
>
> +#ifdef CONFIG_ARCH_MX25
> +const struct imx_mxc_ehci_data imx25_mxc_ehci_otg_data __initconst =
> +	imx_mxc_ehci_data_entry_single(MX25, 0, OTG);
> +const struct imx_mxc_ehci_data imx25_mxc_ehci_hs_data __initconst =
> +	imx_mxc_ehci_data_entry_single(MX25, 1, HS);
> +#endif /* ifdef CONFIG_ARCH_MX25 */
> +
>   #ifdef CONFIG_SOC_IMX27
>   const struct imx_mxc_ehci_data imx27_mxc_ehci_otg_data __initconst =
>   	imx_mxc_ehci_data_entry_single(MX27, 0, OTG);
> diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
> index 9915607..f699235 100644
> --- a/arch/arm/plat-mxc/ehci.c
> +++ b/arch/arm/plat-mxc/ehci.c
> @@ -71,7 +71,7 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
>   	unsigned int v;
>   #if defined(CONFIG_ARCH_MX25)
>   	if (cpu_is_mx25()) {
> -		v = readl(MX25_IO_ADDRESS(MX25_OTG_BASE_ADDR +
> +		v = readl(MX25_IO_ADDRESS(MX25_USB_BASE_ADDR +
>   				     USBCTRL_OTGBASE_OFFSET));
>
>   		switch (port) {
> @@ -108,7 +108,7 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
>   			return -EINVAL;
>   		}
>
> -		writel(v, MX25_IO_ADDRESS(MX25_OTG_BASE_ADDR +
> +		writel(v, MX25_IO_ADDRESS(MX25_USB_BASE_ADDR +
>   				     USBCTRL_OTGBASE_OFFSET));
>   		return 0;
>   	}
> diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
> index a2404b0..0d31f82 100644
> --- a/arch/arm/plat-mxc/include/mach/mx25.h
> +++ b/arch/arm/plat-mxc/include/mach/mx25.h
> @@ -43,7 +43,9 @@
>   #define MX25_LCDC_BASE_ADDR		0x53fbc000
>   #define MX25_KPP_BASE_ADDR		0x43fa8000
>   #define MX25_SDMA_BASE_ADDR		0x53fd4000
> -#define MX25_OTG_BASE_ADDR		0x53ff4000
> +#define MX25_USB_BASE_ADDR		0x53ff4000
> +#define MX25_USB_OTG_BASE_ADDR			(MX25_USB_BASE_ADDR + 0x0000)
> +#define MX25_USB_HS_BASE_ADDR			(MX25_USB_BASE_ADDR + 0x0200)
>   #define MX25_CSI_BASE_ADDR		0x53ff8000
>
>   #define MX25_IO_P2V(x)			IMX_IO_P2V(x)
> @@ -67,6 +69,8 @@
>   #define MX25_INT_UART2		32
>   #define MX25_INT_NFC		33
>   #define MX25_INT_SDMA		34
> +#define MX25_INT_USB_HS		35
> +#define MX25_INT_USB_OTG	37
>   #define MX25_INT_LCDC		39
>   #define MX25_INT_UART5		40
>   #define MX25_INT_CAN1		43


-- 
Jaume Ribot Caner
R&D Engineer

FQ Ingenier?a Electr?nica, SA
Avda. de les Roquetes, 9
Pol. Industrial Vilanoveta
08812 Sant Pere de Ribes ( SPAIN )
www.fqingenieria.es

Tf  + 34 93 208 02 58
Fx  + 34 93 459 28 93
E-mail: jaume at fqingenieria.es
