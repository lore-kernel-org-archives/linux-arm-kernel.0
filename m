From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 Sep 2009 12:52:55 +0100
Subject: [PATCH 1/4] [INPUT][KEYBOARD] Samsung keypad driver support
In-Reply-To: <1252494663-17624-1-git-send-email-jsgood.yang@samsung.com>
References: <1252494663-17624-1-git-send-email-jsgood.yang@samsung.com>
Message-ID: <20090909115255.GB9548@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2009 at 08:11:03PM +0900, jsgood.yang at samsung.com wrote:

> +#ifdef CONFIG_PM
> +static int s3c_keypad_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +	struct s3c_keypad *keypad = platform_get_drvdata(pdev);
> +
> +	keypad->keyifcon = readl(keypad->regs + S3C_KEYIFCON);
> +	keypad->keyiffc = readl(keypad->regs + S3C_KEYIFFC);
> +
> +	disable_irq(IRQ_KEYPAD);
> +	clk_disable(keypad->clk);
> +
> +	return 0;
> +}

This will unconditionally enable the clock but the clock is only enabled
while the input device is opened.  This may create confusion or generate
warnings with the clock API so it'd be better to avoid doing this.

A similar problem exists in the resume function.
