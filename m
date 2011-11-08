From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 09 Nov 2011 10:58:15 +1100
Subject: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
Message-ID: <4EB9C217.1010100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/11 21:49, Nikolaus Voss wrote:

> This driver has the following properties compared to the old driver:
> 1. Support for multiple interfaces.
> 2. Interrupt driven I/O as opposed to polling/busy waiting.
> 3. Support for _one_ repeated start (Sr) condition, which is enough
>    for most real-world applications including all SMBus transfer types.
>    (The hardware does not support issuing arbitrary Sr conditions on the
>     bus.)
> 
> Tested on Atmel G45 with BQ20Z80 battery SMBus client.
> 
> Signed-off-by: Nikolaus Voss <n.voss@weinmann.de>

<snip>

> +	dev->clk = clk_get(&pdev->dev, "twi_clk");
> +	if (IS_ERR(dev->clk)) {
> +		dev_err(&pdev->dev, "no clock defined\n");
> +		rc = -ENODEV;
> +		goto err_free_mem;
> +	}
> +	clk_enable(dev->clk);


There are now dummy clk_prepare/unprepare functions in
include/linux/clk.h, so you should be using them in this driver to
future proof it.

~Ryan
