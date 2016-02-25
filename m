From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Feb 2016 15:42:15 -0800
Subject: [PATCH v9 2/6] clk: hisilicon: add CRG driver for hi3519 soc
In-Reply-To: <1456127280-23275-3-git-send-email-xuejiancheng@huawei.com>
References: <1456127280-23275-1-git-send-email-xuejiancheng@huawei.com>
 <1456127280-23275-3-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20160225234215.GK28849@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22, Jiancheng Xue wrote:
> diff --git a/Documentation/devicetree/bindings/clock/hi3519-crg.txt b/Documentation/devicetree/bindings/clock/hi3519-crg.txt
> new file mode 100644
> index 0000000..2d23950
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/hi3519-crg.txt
> @@ -0,0 +1,46 @@
> +Example: CRG nodes
> +CRG: clock-reset-controller at 12010000 {
> +	compatible = "hisilicon,hi3519-crg";

Indentation is off here.

> +        reg = <0x12010000 0x10000>;
> +        #clock-cells = <1>;
> +        #reset-cells = <2>;
> +};
> +
> +Example: consumer nodes
> +i2c0: i2c at 12110000 {
> +	compatible = "hisilicon,hi3519-i2c";
> +        reg = <0x12110000 0x1000>;
> +        clocks = <&CRG HI3519_I2C0_RST>;*/
> +        resets = <&CRG 0xe4 0>;
> +};
> diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
> index e434854..296371f 100644
> --- a/drivers/clk/hisilicon/Kconfig
> +++ b/drivers/clk/hisilicon/Kconfig
> @@ -1,3 +1,11 @@
> +config COMMON_CLK_HI3519
> +	tristate "Hi3519 Clock Driver"
> +	depends on ARCH_HISI || COMPILE_TEST
> +	select RESET_HISI
> +	default y

default ARCH_HISI

> +	help
> +	  Build the clock driver for hi3519.
> +
> diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
> new file mode 100644
> index 0000000..50e00e7
> --- /dev/null
> +++ b/drivers/clk/hisilicon/reset.c
> +
> +int hisi_reset_init(struct device_node *np)
> +{
> +	struct hisi_reset_controller *rstc;
> +
> +	rstc = kzalloc(sizeof(*rstc), GFP_KERNEL);
> +	if (!rstc)
> +		return -ENOMEM;
> +
> +	rstc->membase = of_iomap(np, 0);

Any reason why we can't pass the platform device here and map the
register space with platform device APIs?

> +	if (!rstc->membase)
> +		return -EINVAL;
> +
> +	spin_lock_init(&rstc->lock);
> +
> +	rstc->rcdev.owner = THIS_MODULE;
> +	rstc->rcdev.ops = &hisi_reset_ops;
> +	rstc->rcdev.of_node = np;
> +	rstc->rcdev.of_reset_n_cells = 2;
> +	rstc->rcdev.of_xlate = hisi_reset_of_xlate;
> +
> +	return reset_controller_register(&rstc->rcdev);
> +}
> +EXPORT_SYMBOL(hisi_reset_init);

Why not GPL?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
