From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 18 Jun 2013 18:22:58 +0200
Subject: [PATCH v3 2/2] i2c: designware: add two optional property
 tx/rx-fifo-size
In-Reply-To: <1370918230-24793-3-git-send-email-zhangfei.gao@linaro.org>
References: <1370918230-24793-1-git-send-email-zhangfei.gao@linaro.org>
 <1370918230-24793-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20130618162257.GF7718@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 10:37:10AM +0800, Zhangfei Gao wrote:
> rx-fifo-size and tx-fifo-size will be updated if provided from dts
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> CC: Baruch Siach <baruch@tkos.co.il>
> ---
>  .../devicetree/bindings/i2c/i2c-designware.txt     |    7 +++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c        |    3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index e42a2ee..84717fe 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -6,6 +6,11 @@ Required properties :
>   - reg : Offset and length of the register set for the device
>   - interrupts : <IRQ> where IRQ is the interrupt number.
>  
> +Optional properties:
> +
> + - rx-fifo-size : 1 cell, Rx fifo size
> + - tx-fifo-size : 1 cell, Tx fifo size
> +

I'd think the bindings are okay, yet I wonder they are not more used in
practice. So, an ack from a dt-expert would be appreciated.

>  Recommended properties :
>  
>   - clock-frequency : desired I2C bus clock frequency in Hz.
> @@ -18,5 +23,7 @@ Example :
>  		compatible = "snps,designware-i2c";
>  		reg = <0xf0000 0x1000>;
>  		interrupts = <11>;
> +		rx-fifo-size = <16>;
> +		tx-fifo-size = <16>;
>  		clock-frequency = <400000>;
>  	};
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 41659c0..6760cea 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -85,6 +85,7 @@ static int dw_i2c_probe(struct platform_device *pdev)
>  	struct dw_i2c_dev *dev;
>  	struct i2c_adapter *adap;
>  	struct resource *mem;
> +	struct device_node *np = pdev->dev.of_node;
>  	int irq, r;
>  
>  	/* NOTE: driver uses the static register mapping */
> @@ -140,6 +141,8 @@ static int dw_i2c_probe(struct platform_device *pdev)
>  		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
>  		dev->adapter.nr = pdev->id;
>  	}
> +	of_property_read_u32(np, "rx-fifo-size", &dev->rx_fifo_depth);
> +	of_property_read_u32(np, "tx-fifo-size", &dev->tx_fifo_depth);

Those can fail.

>  	r = i2c_dw_init(dev);
>  	if (r)
>  		return r;
> -- 
> 1.7.9.5
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/ddddd0da/attachment.sig>
