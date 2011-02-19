From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Feb 2011 13:26:42 +0000
Subject: [PATCH 1/2] PRUSS UIO driver support
In-Reply-To: <1298041530-26855-2-git-send-email-pratheesh@ti.com>
References: <1298041530-26855-1-git-send-email-pratheesh@ti.com>
	<1298041530-26855-2-git-send-email-pratheesh@ti.com>
Message-ID: <20110219132642.GD29493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 08:35:29PM +0530, Pratheesh Gangadhar wrote:
> +static int __devinit pruss_probe(struct platform_device *dev)
> +{
> +	int ret = -ENODEV;
> +	int count = 0;
> +	struct resource *regs_pruram, *regs_l3ram, *regs_ddr;
> +	char *string;
> +
> +	/* Power on PRU in case its not done as part of boot-loader */
> +	pruss_clk = clk_get(&dev->dev, "pruss");
> +	if (IS_ERR(pruss_clk)) {
> +		dev_err(&dev->dev, "Failed to get clock\n");
> +		ret = PTR_ERR(pruss_clk);
> +		pruss_clk = NULL;

Delete this line.

...
> +out_free:
> +	for (count = 0; count < MAX_PRUSS_EVTOUT_INSTANCE; count++)
> +		kfree(info[count]);
> +
> +	if (pruss_clk != NULL)

	if (!IS_ERR(pruss_clk))

> +		clk_put(pruss_clk);
...
> +static int __devexit pruss_remove(struct platform_device *dev)
...
> +	platform_set_drvdata(dev, NULL);
> +
> +	if (pruss_clk != NULL)

	if (!IS_ERR(pruss_clk))

> +		clk_put(pruss_clk);
