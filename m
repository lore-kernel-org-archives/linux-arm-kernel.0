From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Thu, 20 Feb 2014 23:53:56 -0300
Subject: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <5306BFC4.5000005@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

El 20/02/14 21:38, Bjorn Andersson escribi?:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm SOCs.
> The Qualcomm Universal Peripheral Engine (QUP) is a general purpose data path
> engine with input/output FIFOs and an embedded i2c mini-core. The driver
> supports FIFO mode (for low bandwidth applications) and block mode (interrupt
> generated for each block-size data transfer).
>
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---

I'm not familiar with the subsystem nor the hardware, so I had a look 
around for general stuff. I have some minor comments to make on the 
probe code.

(snip)
> +static int qup_i2c_probe(struct platform_device *pdev)
> +{
> +	static const int blk_sizes[] = {4, 16, 32};
> +	struct device_node *node = pdev->dev.of_node;
> +	struct qup_i2c_dev *qup;
> +	unsigned long one_bit_t;
> +	struct resource *res;
> +	u32 val, io_mode, hw_ver, size;
> +	int ret, fs_div, hs_div;
> +	int src_clk_freq;
> +	int clk_freq;
> +
> +	qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
> +	if (!qup)
> +		return -ENOMEM;
> +
> +	qup->dev = &pdev->dev;
> +	init_completion(&qup->xfer);
> +	platform_set_drvdata(pdev, qup);
> +
> +	clk_freq = 100000;
> +	if (!of_property_read_u32(node, "clock-frequency", &val))
> +		clk_freq = val;

val will be modified only if no error occurs, so you may rewrite this 
bit as

+	u32 clk_freq = 100000;
...
+	of_property_read_u32(node, "clock-frequency", &clk_freq)

> +
> +	/* We support frequencies up to FAST Mode (400KHz) */
> +	if (clk_freq <= 0 || clk_freq > 400000) {

And you can drop the < check when it's unsigned.

> +		dev_err(qup->dev, "clock frequency not supported %d\n",
> +			clk_freq);
> +		return -EIO;

EIO?

Cheers,

Emilio
