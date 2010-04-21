From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 21 Apr 2010 02:23:07 +0200
Subject: [PATCHv6 2.6.34-rc5 2/5] mx5: Add USB device definitions for
	Freescale MX51 Babbage HW
In-Reply-To: <1271805567-23068-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1271805567-23068-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1271805567-23068-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20100421002307.GN30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Tue, Apr 20, 2010 at 06:19:24PM -0500, Dinh.Nguyen at freescale.com wrote:
> This patch is part of enabling USB for Freescale MX51 Babbage HW. This
> patch adds device structures for USB Host1 and OTG port, and adds
> clocking information for USB HW.
> 
> This patch applies to 2.6.34-rc5.

Hmm, this one still doesn't apply for me. Can you double-check with a
fresh checkout of 2.6.34-rc5 please?

Other than that, I'm ok with the patches now. Sascha, do you have more
objections? I couldn't test the whole thing as I lack mx5 hardware, but
it looks sane now, and it doesn't break anything for mx3.

> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>

For the patches 3/5 and 4/5 of this series, you can have my

Reviewed-by: Daniel Mack <daniel@caiaq.de>

Thanks,
Daniel

> ---
>  arch/arm/mach-mx5/clock-mx51.c |    8 ++++++
>  arch/arm/mach-mx5/devices.c    |   49 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-mx5/devices.h    |    2 +
>  3 files changed, 59 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
> index 8f85f73..dcca330 100644
> --- a/arch/arm/mach-mx5/clock-mx51.c
> +++ b/arch/arm/mach-mx5/clock-mx51.c
> @@ -761,6 +761,10 @@ DEFINE_CLOCK(gpt_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG9_OFFSET,
>  DEFINE_CLOCK(gpt_ipg_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG10_OFFSET,
>  	NULL,  NULL, &ipg_clk, NULL);
>  
> +/* USB */
> +DEFINE_CLOCK(usboh3_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG14_OFFSET,
> +	NULL, NULL, &pll3_sw_clk, NULL);
> +
>  /* FEC */
>  DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
>  	NULL,  NULL, &ipg_clk, NULL);
> @@ -778,6 +782,10 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
>  	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
>  	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
> +	_REGISTER_CLOCK("mxc-ehci.0", "usb", usboh3_clk)
> +	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", ahb_clk)
> +	_REGISTER_CLOCK("mxc-ehci.1", "usb", usboh3_clk)
> +	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", ahb_clk)
>  };
>  
>  static void clk_tree_init(void)
> diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
> index 5070ae1..e6262f3 100644
> --- a/arch/arm/mach-mx5/devices.c
> +++ b/arch/arm/mach-mx5/devices.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/gpio.h>
>  #include <mach/hardware.h>
>  #include <mach/imx-uart.h>
> @@ -92,6 +93,54 @@ struct platform_device mxc_fec_device = {
>  	.resource = mxc_fec_resources,
>  };
>  
> +static u64 usb_dma_mask = DMA_BIT_MASK(32);
> +
> +static struct resource usbotg_resources[] = {
> +	{
> +		.start = MX51_OTG_BASE_ADDR,
> +		.end = MX51_OTG_BASE_ADDR + 0x1ff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.start = MX51_MXC_INT_USB_OTG,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device mxc_usbdr_host_device = {
> +	.name = "mxc-ehci",
> +	.id = 0,
> +	.num_resources = ARRAY_SIZE(usbotg_resources),
> +	.resource = usbotg_resources,
> +	.dev = {
> +		.dma_mask = &usb_dma_mask,
> +		.coherent_dma_mask = DMA_BIT_MASK(32),
> +	},
> +};
> +
> +static struct resource usbh1_resources[] = {
> +	{
> +		.start = MX51_OTG_BASE_ADDR + 0x200,
> +		.end = MX51_OTG_BASE_ADDR + 0x200 + 0x1ff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.start = MX51_MXC_INT_USB_H1,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device mxc_usbh1_device = {
> +	.name = "mxc-ehci",
> +	.id = 1,
> +	.num_resources = ARRAY_SIZE(usbh1_resources),
> +	.resource = usbh1_resources,
> +	.dev = {
> +		.dma_mask = &usb_dma_mask,
> +		.coherent_dma_mask = DMA_BIT_MASK(32),
> +	},
> +};
> +
>  static struct mxc_gpio_port mxc_gpio_ports[] = {
>  	{
>  		.chip.label = "gpio-0",
> diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
> index f339ab8..95c45f9 100644
> --- a/arch/arm/mach-mx5/devices.h
> +++ b/arch/arm/mach-mx5/devices.h
> @@ -2,3 +2,5 @@ extern struct platform_device mxc_uart_device0;
>  extern struct platform_device mxc_uart_device1;
>  extern struct platform_device mxc_uart_device2;
>  extern struct platform_device mxc_fec_device;
> +extern struct platform_device mxc_usbdr_host_device;
> +extern struct platform_device mxc_usbh1_device;
> -- 
> 1.6.0.4
> 
