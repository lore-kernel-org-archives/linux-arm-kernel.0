From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 9 Jun 2013 06:23:00 +0300
Subject: [PATCH 2/2] i2c: designware: Add i2c-designware-hs
In-Reply-To: <1370745402-11844-3-git-send-email-zhangfei.gao@linaro.org>
References: <1370745402-11844-1-git-send-email-zhangfei.gao@linaro.org>
 <1370745402-11844-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20130609032300.GB4312@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhangfei Gao,

On Sun, Jun 09, 2013 at 10:36:42AM +0800, Zhangfei Gao wrote:
> Add support hisilicon i2c driver, which reuse designware i2c ip
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  .../devicetree/bindings/i2c/i2c-designware-hs.txt  |   30 +++
>  drivers/i2c/busses/Kconfig                         |   10 +
>  drivers/i2c/busses/Makefile                        |    1 +
>  drivers/i2c/busses/i2c-designware-hs.c             |  194 ++++++++++++++++++++
>  4 files changed, 235 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-designware-hs.txt
>  create mode 100644 drivers/i2c/busses/i2c-designware-hs.c
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware-hs.txt b/Documentation/devicetree/bindings/i2c/i2c-designware-hs.txt
> new file mode 100644
> index 0000000..08908fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware-hs.txt
> @@ -0,0 +1,30 @@
> +* Hisilicon I2C Controller
> +
> +Required properties :
> +
> + - compatible : should be "hisilicon,designware-i2c"
> + - reg : Offset and length of the register set for the device
> + - interrupts : <IRQ> where IRQ is the interrupt number.
> +
> +Example :
> +
> +	i2c0: i2c at fcb08000 {
> +		compatible = "hs,designware-i2c";

A few comments on this one:

1. You should Cc devicetree-discuss at lists.ozlabs.org on patches touching ftd 
   bindings (added to Cc)

2. The convention is to use the IC block designer in the "compatible" property 
   prefix, in this case Symopsys (snps)

3. This does not match the compatible property in hs_dw_i2c_of_match[] below 
   where you use "hisilicon,designware-i2c"

4. Please update Documentation/devicetree/bindings/vendor-prefixes.txt when 
   adding new vendor prefixes

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0xfcb08000 0x1000>;
> +		interrupts = <0 28 4>;
> +		clocks = <&pclk>;
> +		status = "disabled";
> +	};
> +
> +	Client in i2c0 bus with add 0x58 could be added as example
> +	i2c0: i2c at fcb08000 {
> +		status = "ok";

The convention is to use "okay".

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
> +		i2c_client1: i2c_client at 58 {
> +			compatible = "hisilicon,i2c_client_tpa2028";
> +			reg = <0x58>;
> +		};
> +	};

[...]

The code below looks like a direct copy of i2c-designware-platdrv.c. Is there 
any reason you can't use that code instead?

> +static struct i2c_algorithm hs_i2c_dw_algo = {
> +	.master_xfer	= i2c_dw_xfer,
> +	.functionality	= i2c_dw_func,
> +};
> +static u32 hs_i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
> +{
> +	return clk_get_rate(dev->clk)/1000;
> +}
> +
> +static int hs_dw_i2c_probe(struct platform_device *pdev)
> +{
> +	struct dw_i2c_dev *d;
> +	struct i2c_adapter *adap;
> +	struct resource *iores;
> +	struct pinctrl *pinctrl;
> +	int r;
> +
> +	d = devm_kzalloc(&pdev->dev, sizeof(struct dw_i2c_dev), GFP_KERNEL);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	/* NOTE: driver uses the static register mapping */
> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!iores)
> +		return -EINVAL;
> +
> +	d->base = devm_request_and_ioremap(&pdev->dev, iores);
> +	if (!d->base)
> +		return -EADDRNOTAVAIL;
> +
> +	d->irq = platform_get_irq(pdev, 0);
> +	if (d->irq < 0) {
> +		dev_err(&pdev->dev, "no irq resource?\n");
> +		return d->irq; /* -ENXIO */
> +	}

[...]

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
