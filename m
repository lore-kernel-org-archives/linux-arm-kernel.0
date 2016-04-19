From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Apr 2016 14:44:21 +0200
Subject: [PATCH v2] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <1461064248-31288-1-git-send-email-navam@xilinx.com>
References: <1461064248-31288-1-git-send-email-navam@xilinx.com>
Message-ID: <7208820.t2EJm8R9jW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 April 2016 16:40:48 Nava kishore Manne wrote:
> This patch updates the driver to support 64-bit DMA
> addressing.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
> Changes for v2:
> 		-Added dma-ranges property in device tree as suggested by Arnd Bergmann.
>                 -Modified the driver code based on the xlnx,addrwidth.
>  .../devicetree/bindings/usb/udc-xilinx.txt         |  5 ++-
>  drivers/usb/gadget/udc/udc-xilinx.c                | 39 ++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/udc-xilinx.txt b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> index 47b4e39..850d792 100644
> --- a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> +++ b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> @@ -7,12 +7,15 @@ Required properties:
>  - interrupts		: Should contain single irq line of USB2 device
>  			  controller
>  - xlnx,has-builtin-dma	: if DMA is included
> -
> +- dma-ranges: Should be as the following <dma_addr cpu_addr max_len>.

This is not how dma-ranges is works. First of all, it is part of
the parent node, and the addresses are not "dma" and "cpu"
addresses but child and parent bus addresses.

> +- xlnx,addrwidth       : Should be the dma addressing size in bits(ex: 40 bits).

As I said before, the width is not the interesting question here,
the compatible string is. My guess is that version 4.00.a of the
hardware always has the registers to do 64-bit DMA, but you should
talk to the hardware designers to figure out which versions have
those, or if they are optional, and what other width may be supported.


> + * xudc_write64 - write 64bit value to device registers
> + * @addr: base addr of device registers
> + * @offset: register offset
> + * @val: data to be written
> + **/
> +static void xudc_write64(void __iomem *addr, u32 offset, u64 val)
> +{
> +	lo_hi_writeq(val, addr + offset);
> +}

This is what I suggested, but on second thought I think it's still
wrong:

>   * xudc_write32 - little endian write to device registers
>   * @addr: base addr of device registers
>   * @offset: register offset
> @@ -330,8 +352,13 @@ static int xudc_start_dma(struct xusb_ep *ep, dma_addr_t src,
>  	 * destination registers and then set the length
>  	 * into the DMA length register.
>  	 */
> -	udc->write_fn(udc->addr, XUSB_DMA_DSAR_ADDR_OFFSET, src);
> -	udc->write_fn(udc->addr, XUSB_DMA_DDAR_ADDR_OFFSET, dst);
> +	if (udc->dma_addrwidth > 32) {
> +		xudc_write64(udc->addr, XUSB_DMA_DSAR_ADDR_OFFSET_LSB, src);
> +		xudc_write64(udc->addr, XUSB_DMA_DDAR_ADDR_OFFSET_LSB, dst);
> +	} else {
> +		udc->write_fn(udc->addr, XUSB_DMA_DSAR_ADDR_OFFSET, src);
> +		udc->write_fn(udc->addr, XUSB_DMA_DDAR_ADDR_OFFSET, dst);
> +	}

I just noticed that write_fn() needs to be used to get the
correct endianess. lo_hi_writeq() always assumes a little-endian
register, so it's broken if anyone builds this device with big-endian
registers.

> @@ -2097,6 +2124,12 @@ static int xudc_probe(struct platform_device *pdev)
>  
>  	udc->dma_enabled = of_property_read_bool(np, "xlnx,has-builtin-dma");
>  
> +	ret = of_property_read_u32(np, "xlnx,addrwidth", &udc->dma_addrwidth);
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "missing xlnx,addrwidth property\n");
> +
> +	/* Set the dma mask bits */
> +	dma_set_mask(&pdev->dev, DMA_BIT_MASK(udc->dma_addrwidth));

You have to check the return code of dma_set_mask. As I said earlier, it's
possible that someone uses a device that has the 64-bit registers on a
machine that has a 32-bit bus but more than 4GB of RAM. In this case,
dma_set_mask() will fail, and you should probably fall back to the
original method for programming the DMA address then.

	Arnd
