From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 May 2016 10:50:37 +0200
Subject: [PATCH v3] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <1464067268-35299-1-git-send-email-navam@xilinx.com>
References: <1464067268-35299-1-git-send-email-navam@xilinx.com>
Message-ID: <14123451.MsNvJvqaJX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 24, 2016 10:51:08 AM CEST Nava kishore Manne wrote:
> diff --git a/Documentation/devicetree/bindings/usb/udc-xilinx.txt b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> index 47b4e39..09df757 100644
> --- a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> +++ b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> @@ -1,18 +1,23 @@
>  Xilinx USB2 device controller
>  
>  Required properties:
> -- compatible		: Should be "xlnx,usb2-device-4.00.a"
> +- compatible		: Should be "xlnx,usb2-device-4.00.a" or
> +			  "xlnx,usb2-device-5.00"
>  - reg			: Physical base address and size of the USB2
>  			  device registers map.
>  - interrupts		: Should contain single irq line of USB2 device
>  			  controller
>  - xlnx,has-builtin-dma	: if DMA is included
> +- dma-ranges		: Should be as the following
> +			  <child-bus-address, parent-bus-address, length>

A USB host should not have any children that are DMA capable, I think, so this
property doesn't make sense here. It should be part of the parent bus.

> +- xlnx,addrwidth	: Should be the dma addressing size in bits(ex: 64 bits)

I'm still unconvinced about the property definition here. What are the possible
options for the IP block? I don't think I ever saw a reply from you to my earlier
questions.

> @@ -214,6 +223,20 @@ static const struct usb_endpoint_descriptor config_bulk_out_desc = {
>  	.wMaxPacketSize		= cpu_to_le16(EP0_MAX_PACKET),
>  };
>  
> +/**
> + * xudc_write64 - write 64bit value to device registers
> + * @addr: base addr of device registers
> + * @offset: register offset
> + * @val: data to be written
> + **/
> +static void xudc_write64(struct xusb_ep *ep, u32 offset, u64 val)
> +{
> +	struct xusb_udc *udc = ep->udc;
> +
> +	udc->write_fn(udc->addr, offset, lower_32_bits(val));
> +	udc->write_fn(udc->addr, offset+0x04, upper_32_bits(val));
> +}
> +
>  /**
>   * xudc_write32 - little endian write to device registers
>   * @addr: base addr of device registers
> @@ -330,8 +353,13 @@ static int xudc_start_dma(struct xusb_ep *ep, dma_addr_t src,
>  	 * destination registers and then set the length
>  	 * into the DMA length register.
>  	 */
> -	udc->write_fn(udc->addr, XUSB_DMA_DSAR_ADDR_OFFSET, src);
> -	udc->write_fn(udc->addr, XUSB_DMA_DDAR_ADDR_OFFSET, dst);
> +	if (udc->dma_addrwidth > 32) {
> +		xudc_write64(ep, XUSB_DMA_DSAR_ADDR_OFFSET_LSB, src);
> +		xudc_write64(ep, XUSB_DMA_DDAR_ADDR_OFFSET_LSB, dst);
> +	} else {
> +		udc->write_fn(udc->addr, XUSB_DMA_DSAR_ADDR_OFFSET, src);
> +		udc->write_fn(udc->addr, XUSB_DMA_DDAR_ADDR_OFFSET, dst);
> +	}
>  	udc->write_fn(udc->addr, XUSB_DMA_LENGTH_OFFSET, length);
>  

This looks good.

	Arnd
