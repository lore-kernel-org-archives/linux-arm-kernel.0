From: b32955@freescale.com (Huang Shijie)
Date: Wed, 22 May 2013 16:30:03 +0800
Subject: [PATCH 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <20130520131827.GB32299@pengutronix.de>
References: <1369039742-10893-1-git-send-email-b32955@freescale.com>
 <1369039742-10893-2-git-send-email-b32955@freescale.com>
 <20130520131827.GB32299@pengutronix.de>
Message-ID: <519C820B.2080800@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?05?20? 21:18, Sascha Hauer ??:
> On Mon, May 20, 2013 at 04:48:57PM +0800, Huang Shijie wrote:
>> 			weim-cs-index.
>> +
>> +Example for an i.MX6q-sabreauto board:
>> +	weim: weim at 021b8000 {
>> +		compatible = "fsl,imx6q-weim";
>> +		reg =<0x021b8000 0x4000>;
>> +		interrupts =<0 14 0x04>;
>> +		clocks =<&clks 196>;
>> +		#address-cells =<2>;
> Why is address cells 2 in this example?
Must be set to 2 to allow memory address translation.
>> +		#size-cells =<1>;
>> +		ranges =<0 0 0x08000000 0x08000000>;
>> +
>> +		nor at 0,0 {
>> +			compatible = "cfi-flash";
>> +			reg =<0 0 0x02000000>;
>> +			#address-cells =<1>;
>> +			#size-cells =<1>;
>> +			bank-width =<2>;
>> +
>> +			weim-cs-index =<0>;
>> +			weim-cs-timing =<0x00620081 0x00000001 0x1C022000
>> +					0x0000C000 0x1404a38e 0x00000000>;
>> +			partition at 0 {
>> +				label = "U-Boot";
>> +				reg =<0x0 0x40000>;
>> +			};
>> +
>> +			partition at 40000 {
>> +				label = "U-Boot-ENV";
>> +				reg =<0x40000 0x10000>;
>> +				read-only;
>> +			};
>> +
>> +			partition at 50000 {
>> +				label = "Kernel";
>> +				reg =<0x50000 0x3b0000>;
>> +			};
> The partitions are unnecessary to understand the example. Please drop them.
okay.
>> +#define CS_TIMING_LEN 6
>> +#define CS_REG_RANGE  0x18
>> +/* Parse and set the timing for this device. */
>> +static int weim_timing(struct platform_device *pdev, struct device_node *np)
>> +{
>> +	struct imx_weim *weim = platform_get_drvdata(pdev);
>> +	u32 value[CS_TIMING_LEN];
>> +	u32 cs_idx;
>> +	int ret;
>> +	int i;
>> +
>> +	ret = of_property_read_u32(np, "weim-cs-index",&cs_idx);
>> +	if (ret)
>> +		goto weim_parse_err;
> It would be nice to check for cs_idx being valid.
>
>> +
>> +	ret = of_property_read_u32_array(np, "weim-cs-timing",
>> +					value, CS_TIMING_LEN);
>> +	if (ret)
>> +		goto weim_parse_err;
>> +
>> +	/* set the timing for WEIM */
>> +	for (i = 0; i<  CS_TIMING_LEN; i++)
>> +		writel(value[i], weim->base + cs_idx * CS_REG_RANGE + i * 4);
>> +	return 0;
>> +
>> +weim_parse_err:
>> +	return ret;
>> +}
>> +
>> +static int weim_parse_dt(struct platform_device *pdev)
>> +{
>> +	struct device_node *child;
>> +	int ret;
>> +
>> +	/* We only support the Parallel NOR now. We may add more in future. */
>> +	child = of_find_node_by_name(NULL, "nor");
>> +	if (child) {
>> +		ret = weim_timing(pdev, child);
>> +		if (ret)
>> +			goto parse_fail;
>> +
>> +		if (!of_platform_device_create(child, NULL,&pdev->dev)) {
>> +			ret = -EINVAL;
>> +			goto parse_fail;
>> +		}
>> +	}
> What you want to do here is:
>
> - iterate over your child nodes
> - call weim_timing() for each of them
> - call of_platform_device_create for each child (or even
>    of_platform_populate() with the parent node)
>
yes.
>> +	return 0;
>> +
>> +parse_fail:
>> +	return ret;
>> +}
>> +
>> +static int weim_probe(struct platform_device *pdev)
>> +{
>> +	struct imx_weim *weim;
>> +	struct resource *res;
>> +	int ret = -EINVAL;
>> +
>> +	weim = devm_kzalloc(&pdev->dev, sizeof(*weim), GFP_KERNEL);
>> +	if (!weim) {
>> +		ret = -ENOMEM;
>> +		goto weim_err;
>> +	}
>> +	platform_set_drvdata(pdev, weim);
>> +
>> +	/* get the resource */
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		ret = -ENOENT;
>> +		goto weim_err;
>> +	}
> No need to do error checking here. devm_ioremap_resource() will do this
> for you and also print an error message.
>
>> +
>> +	weim->base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(weim->base)) {
>> +		ret = PTR_ERR(weim->base);
>> +		goto weim_err;
>> +	}
>> +
>> +	/* get the clock */
>> +	weim->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(weim->clk))
>> +		goto weim_err;
>> +
>> +	clk_prepare_enable(weim->clk);
> what is this clock used for? Is it necessary for the register access or
> is it necessary for the chipselects on the WEIM to work?
>
>
yes. We need this clock.

in actually, this clock is just a clock gate for several clocks, 
including clock for register access, and
other necessary clocks.

thanks
Huang Shijie
.
