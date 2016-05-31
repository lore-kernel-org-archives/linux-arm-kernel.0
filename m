From: shubhrajyoti.datta@gmail.com (Shubhrajyoti Datta)
Date: Tue, 31 May 2016 07:59:01 +0530
Subject: [PATCH v4] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <1464626798-1334-1-git-send-email-navam@xilinx.com>
References: <1464626798-1334-1-git-send-email-navam@xilinx.com>
Message-ID: <CAKfKVtF1hOn9QwiqtjqqPYtUz5PscTBs4kBC1zRH6FY-4vVoUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 10:16 PM, Nava kishore Manne
<nava.manne@xilinx.com> wrote:
> This patch updates the driver to support 64-bit DMA addressing.
>
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
> Changes for v4:
>                 -Used boolen property insted of addrwith property in the DT
>                  as suggested by Arnd Bergmann.
>                 -Adopt the DT relevant changes into the driver.
>
> Changes for v3:
>                 -Added new compatable string for 5.00 IP version as suggested by
>                  Arnd Bergmann.
>                 -Used write_fn() insted of lo_hi_writeq() as suggested by
>                  Arnd Bergmann.
>
> Changes for v2:
>                 -Added dma-ranges property in device tree as suggested by Arnd Bergmann.
>                 -Modified the driver code based on the xlnx,addrwidth.
>
>  .../devicetree/bindings/usb/udc-xilinx.txt         |  5 ++-
>  drivers/usb/gadget/udc/udc-xilinx.c                | 52 +++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/udc-xilinx.txt b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> index 47b4e39..d08d972 100644
> --- a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> +++ b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> @@ -1,12 +1,14 @@
>  Xilinx USB2 device controller
>
>  Required properties:
> -- compatible           : Should be "xlnx,usb2-device-4.00.a"
> +- compatible           : Should be "xlnx,usb2-device-4.00.a" or
> +                         "xlnx,usb2-device-5.00"
>  - reg                  : Physical base address and size of the USB2
>                           device registers map.
>  - interrupts           : Should contain single irq line of USB2 device
>                           controller
>  - xlnx,has-builtin-dma : if DMA is included
> +- xlnx,has-64bit-dma   : if DMA is included 64-bit addressing support.
>
>  Example:
>                 axi-usb2-device at 42e00000 {
> @@ -14,5 +16,6 @@ Example:
>                          interrupts = <0x0 0x39 0x1>;
>                          reg = <0x42e00000 0x10000>;
>                          xlnx,has-builtin-dma;
> +                       xlnx,has-64bit-dma;
>                  };
>
> diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
> index 1cbb0ac..6fb80c6 100644
> --- a/drivers/usb/gadget/udc/udc-xilinx.c
> +++ b/drivers/usb/gadget/udc/udc-xilinx.c
> @@ -47,6 +47,15 @@
>  #define XUSB_DMA_LENGTH_OFFSET         0x0210  /* DMA Length Register */
>  #define XUSB_DMA_STATUS_OFFSET         0x0214  /* DMA Status Register */
>
> +/* DMA source Address Reg for LSB */
> +#define XUSB_DMA_DSAR_ADDR_OFFSET_LSB   0x0308
> +/* DMA source Address Reg for MSB */
> +#define XUSB_DMA_DSAR_ADDR_OFFSET_MSB   0x030C
> +/* DMA destination Addr Reg LSB */
> +#define XUSB_DMA_DDAR_ADDR_OFFSET_LSB   0x0310
> +/* DMA destination Addr Reg MSB */
> +#define XUSB_DMA_DDAR_ADDR_OFFSET_MSB   0x0314
> +
>  /* Endpoint Configuration Space offsets */
>  #define XUSB_EP_CFGSTATUS_OFFSET       0x00    /* Endpoint Config Status  */
>  #define XUSB_EP_BUF0COUNT_OFFSET       0x08    /* Buffer 0 Count */
> @@ -169,6 +178,7 @@ struct xusb_ep {
>   * @setup: usb_ctrlrequest structure for control requests
>   * @req: pointer to dummy request for get status command
>   * @dev: pointer to device structure in gadget
> + * @is_extend_dma: flag indiacting whether the dma is 64-bit support or not.
>   * @usb_state: device in suspended state or not
>   * @remote_wkp: remote wakeup enabled by host
>   * @setupseqtx: tx status
> @@ -186,6 +196,7 @@ struct xusb_udc {
>         struct usb_ctrlrequest setup;
>         struct xusb_req *req;
>         struct device *dev;
> +       bool is_extend_dma;
>         u32 usb_state;
>         u32 remote_wkp;
>         u32 setupseqtx;
> @@ -215,6 +226,20 @@ static const struct usb_endpoint_descriptor config_bulk_out_desc = {
>  };
>
>  /**
> + * xudc_write64 - write 64bit value to device registers
> + * @ep: pointer to the usb device endpoint structure.
> + * @offset: register offset
> + * @val: data to be written
> + **/
> +static void xudc_write64(struct xusb_ep *ep, u32 offset, u64 val)
> +{
> +       struct xusb_udc *udc = ep->udc;
> +
> +       udc->write_fn(udc->addr, offset, lower_32_bits(val));
> +       udc->write_fn(udc->addr, offset+0x04, upper_32_bits(val));

can we move this to a single 64 bit write?
> +}
> +
> +/**
