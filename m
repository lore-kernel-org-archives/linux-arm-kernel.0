From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Dec 2011 20:07:50 +0000
Subject: [PATCH v4] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <1323852927-13521-1-git-send-email-Barry.Song@csr.com>
References: <1323852927-13521-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20111220200750.GA2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 04:55:27PM +0800, Barry Song wrote:
> +static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev)
> +{
> +	struct clk *clk;
> +
> +	clk = clk_get(&pdev->dev, NULL);
> +	err = clk_prepare(clk);
> +	err = clk_enable(clk);
...
> +	clk_disable(clk);
> +
> +	dev_info(&pdev->dev, " I2C adapter ready to operate\n");
> +
> +	return 0;
> +}
> +
> +static int __devexit i2c_sirfsoc_remove(struct platform_device *pdev)
> +{
> +	clk_disable(siic->clk);
> +	clk_unprepare(siic->clk);
> +	clk_put(siic->clk);

This doesn't look right - look at the state which you leave the clk in
upon successful probe, and now look at what you do when you do a remove.

It seems that you disable an already disabled clock to me.
