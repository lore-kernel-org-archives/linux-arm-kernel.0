From: John.Youn@synopsys.com (John Youn)
Date: Wed, 1 Feb 2017 03:37:07 +0000
Subject: [PATCH v5 1/5] usb: dwc2: Add support for STM32F429/439/469 USB
 OTG HS/FS in FS mode (internal PHY)
References: <20170201012547.76158-1-bruherrera@gmail.com>
 <20170201012547.76158-2-bruherrera@gmail.com>
Message-ID: <2B3535C5ECE8B5419E3ECBE300772909021B411720@US01WEMBX2.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/31/2017 5:26 PM, Bruno Herrera wrote:
> This patch introduces a new parameter to activate USB OTG HS/FS core
> embedded phy transceiver. The STM32F4x9 SoC uses the GGPIO register
> to enable the transceiver.
> Also add the dwc2_set_params function for stm32f4 otg fs.
>
> Signed-off-by: Bruno Herrera <bruherrera@gmail.com>

Acked-by: John Youn <johnyoun@synopsys.com>

Regards,
John


> ---
>  drivers/usb/dwc2/core.h   |  5 +++++
>  drivers/usb/dwc2/hcd.c    | 15 ++++++++++++++-
>  drivers/usb/dwc2/hw.h     |  2 ++
>  drivers/usb/dwc2/params.c | 19 +++++++++++++++++++
>  4 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index b9b62f1..252400b 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -423,6 +423,10 @@ enum dwc2_ep0_state {
>   *			needed.
>   *			0 - No (default)
>   *			1 - Yes
> + * @activate_stm_fs_transceiver: Activate internal transceiver using GGPIO
> + *			register.
> + *			0 - Deactivate the transceiver (default)
> + *			1 - Activate the transceiver
>   * @g_dma:              Enables gadget dma usage (default: autodetect).
>   * @g_dma_desc:         Enables gadget descriptor DMA (default: autodetect).
>   * @g_rx_fifo_size:	The periodic rx fifo size for the device, in
> @@ -477,6 +481,7 @@ struct dwc2_core_params {
>  	bool uframe_sched;
>  	bool external_id_pin_ctl;
>  	bool hibernation;
> +	bool activate_stm_fs_transceiver;
>  	u16 max_packet_count;
>  	u32 max_transfer_size;
>  	u32 ahbcfg;
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index a73722e..b5a70b6 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -121,7 +121,7 @@ static void dwc2_init_fs_ls_pclk_sel(struct dwc2_hsotg *hsotg)
>
>  static int dwc2_fs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
>  {
> -	u32 usbcfg, i2cctl;
> +	u32 usbcfg, ggpio, i2cctl;
>  	int retval = 0;
>
>  	/*
> @@ -145,6 +145,19 @@ static int dwc2_fs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
>  				return retval;
>  			}
>  		}
> +
> +		if (hsotg->params.activate_stm_fs_transceiver) {
> +			ggpio = dwc2_readl(hsotg->regs + GGPIO);
> +			if (!(ggpio & GGPIO_STM32_OTG_GCCFG_PWRDWN)) {
> +				dev_dbg(hsotg->dev, "Activating transceiver\n");
> +				/*
> +				 * STM32F4x9 uses the GGPIO register as general
> +				 * core configuration register.
> +				 */
> +				ggpio |= GGPIO_STM32_OTG_GCCFG_PWRDWN;
> +				dwc2_writel(ggpio, hsotg->regs + GGPIO);
> +			}
> +		}
>  	}
>
>  	/*
> diff --git a/drivers/usb/dwc2/hw.h b/drivers/usb/dwc2/hw.h
> index bde7248..4592012 100644
> --- a/drivers/usb/dwc2/hw.h
> +++ b/drivers/usb/dwc2/hw.h
> @@ -225,6 +225,8 @@
>
>  #define GPVNDCTL			HSOTG_REG(0x0034)
>  #define GGPIO				HSOTG_REG(0x0038)
> +#define GGPIO_STM32_OTG_GCCFG_PWRDWN	BIT(16)
> +
>  #define GUID				HSOTG_REG(0x003c)
>  #define GSNPSID				HSOTG_REG(0x0040)
>  #define GHWCFG1				HSOTG_REG(0x0044)
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 2990c34..9cd8722 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -120,6 +120,22 @@ static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)
>  	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 << GAHBCFG_HBSTLEN_SHIFT;
>  }
>
> +static void dwc2_set_stm32f4x9_fsotg_params(struct dwc2_hsotg *hsotg)
> +{
> +	struct dwc2_core_params *p = &hsotg->params;
> +
> +	p->otg_cap = DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE;
> +	p->speed = DWC2_SPEED_PARAM_FULL;
> +	p->host_rx_fifo_size = 128;
> +	p->host_nperio_tx_fifo_size = 96;
> +	p->host_perio_tx_fifo_size = 96;
> +	p->max_packet_count = 256;
> +	p->phy_type = DWC2_PHY_TYPE_PARAM_FS;
> +	p->i2c_enable = false;
> +	p->uframe_sched = false;
> +	p->activate_stm_fs_transceiver = true;
> +}
> +
>  const struct of_device_id dwc2_of_match_table[] = {
>  	{ .compatible = "brcm,bcm2835-usb", .data = dwc2_set_bcm_params },
>  	{ .compatible = "hisilicon,hi6220-usb", .data = dwc2_set_his_params  },
> @@ -133,6 +149,9 @@ const struct of_device_id dwc2_of_match_table[] = {
>  	{ .compatible = "amlogic,meson-gxbb-usb",
>  	  .data = dwc2_set_amlogic_params },
>  	{ .compatible = "amcc,dwc-otg", .data = dwc2_set_amcc_params },
> +	{ .compatible = "st,stm32f4x9-fsotg",
> +	  .data = dwc2_set_stm32f4x9_fsotg_params },
> +	{ .compatible = "st,stm32f4x9-hsotg" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
>
