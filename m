From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 19:35:05 -0600
Subject: [PATCH v5 3/3] USB3/DWC3: Enable undefined length INCR burst type
In-Reply-To: <20180306085911.5930-3-ran.wang_1@nxp.com>
References: <20180306085911.5930-1-ran.wang_1@nxp.com>
 <20180306085911.5930-3-ran.wang_1@nxp.com>
Message-ID: <20180308013505.lyrmkdz54iyghbsf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 04:59:11PM +0800, Ran Wang wrote:
> Enable the undefined length INCR burst type and set INCRx.
> Different platform may has the different burst size type.
> In order to get best performance, we need to tune the burst size to
> one special value, instead of the default value.
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v5:
>   - no change
> Changes in v4:
>   - Modify the codes according to the definition of this property.
> Changes in v3:
>   - add new property for INCR burst in usb node to reset GSBUSCFG0.
> Changes in v2:
>   - split patch
>   - create one new function to handle soc bus configuration register.
> 
>  drivers/usb/dwc3/core.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h |    7 ++++
>  2 files changed, 90 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index f1d838a..8ea2bc8 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -741,6 +741,87 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
>  static int dwc3_core_get_phy(struct dwc3 *dwc);
>  static int dwc3_core_ulpi_init(struct dwc3 *dwc);
>  
> +/* set global soc bus configuration registers */
> +static void dwc3_set_soc_bus_cfg(struct dwc3 *dwc)
> +{
> +	struct device *dev = dwc->dev;
> +	u32 *vals;
> +	u32 cfg;
> +	int ntype;
> +	int ret;
> +	int i;
> +
> +	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
> +
> +	/*
> +	 * Handle property "snps,incr-burst-type-adjustment".
> +	 * Get the number of value from this property:
> +	 * result <= 0, means this property is not supported.
> +	 * result = 1, means INCRx burst mode supported.
> +	 * result > 1, means undefined length burst mode supported.
> +	 */
> +	ntype = device_property_read_u32_array(dev,
> +			"snps,incr-burst-type-adjustment", NULL, 0);

Can't you just do:

if (ntype <= 0)
    return;

> +	if (ntype > 0) {

And then save a level of indentation.

> +		vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
> +		if (!vals) {
> +			dev_err(dev, "Error to get memory\n");
> +			return;
> +		}
> +		/* Get INCR burst type, and parse it */
> +		ret = device_property_read_u32_array(dev,
> +			"snps,incr-burst-type-adjustment", vals, ntype);
> +		if (ret) {
> +			dev_err(dev, "Error to get property\n");
> +			return;
> +		}
> +		*(dwc->incrx_type + 1) = vals[0];
> +		if (ntype > 1) {
> +			*dwc->incrx_type = 1;
> +			for (i = 1; i < ntype; i++) {
> +				if (vals[i] > *(dwc->incrx_type + 1))
> +					*(dwc->incrx_type + 1) = vals[i];
> +			}
> +		} else
> +			*dwc->incrx_type = 0;

This code is hard to follow. Why do you have an array to store a boolean 
(INCR burst enable) and the burst size. 2 elements with more descriptive 
names would be better.


> +
> +		/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
> +		cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
> +		if (*dwc->incrx_type)
> +			cfg |= DWC3_GSBUSCFG0_INCRBRSTENA;
> +		switch (*(dwc->incrx_type + 1)) {
> +		case 256:
> +			cfg |= DWC3_GSBUSCFG0_INCR256BRSTENA;
> +			break;
> +		case 128:
> +			cfg |= DWC3_GSBUSCFG0_INCR128BRSTENA;
> +			break;
> +		case 64:
> +			cfg |= DWC3_GSBUSCFG0_INCR64BRSTENA;
> +			break;
> +		case 32:
> +			cfg |= DWC3_GSBUSCFG0_INCR32BRSTENA;
> +			break;
> +		case 16:
> +			cfg |= DWC3_GSBUSCFG0_INCR16BRSTENA;
> +			break;
> +		case 8:
> +			cfg |= DWC3_GSBUSCFG0_INCR8BRSTENA;
> +			break;
> +		case 4:
> +			cfg |= DWC3_GSBUSCFG0_INCR4BRSTENA;
> +			break;
> +		case 1:
> +			break;
> +		default:
> +			dev_err(dev, "Invalid property\n");
> +			break;
> +		}
> +	}
> +
> +	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
> +}
> +
>  /**
>   * dwc3_core_init - Low-level initialization of DWC3 Core
>   * @dwc: Pointer to our controller context structure
> @@ -803,6 +884,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  	/* Adjust Frame Length */
>  	dwc3_frame_length_adjustment(dwc);
>  
> +	dwc3_set_soc_bus_cfg(dwc);
> +
>  	usb_phy_set_suspend(dwc->usb2_phy, 0);
>  	usb_phy_set_suspend(dwc->usb3_phy, 0);
>  	ret = phy_power_on(dwc->usb2_generic_phy);
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 8f97f61..565d7ec 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -806,6 +806,7 @@ struct dwc3_scratchpad_array {
>   * @regs: base address for our registers
>   * @regs_size: address space size
>   * @fladj: frame length adjustment
> + * @incrx_type: INCR burst type adjustment
>   * @irq_gadget: peripheral controller's IRQ number
>   * @nr_scratch: number of scratch buffers
>   * @u1u2: only used on revisions <1.83a for workaround
> @@ -939,6 +940,12 @@ struct dwc3 {
>  	enum usb_phy_interface	hsphy_mode;
>  
>  	u32			fladj;
> +	/*
> +	 * For INCR burst type.
> +	 * First field: for undefined length INCR burst type enable.
> +	 * Second field: for INCRx burst type enable
> +	 */
> +	u32			incrx_type[2];
>  	u32			irq_gadget;
>  	u32			nr_scratch;
>  	u32			u1u2;
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
