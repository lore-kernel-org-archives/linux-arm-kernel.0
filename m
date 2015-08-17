From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon, 17 Aug 2015 17:18:30 -0300
Subject: [PATCH v2 1/2] i2c: add i2c-lpc2k driver
In-Reply-To: <1439748617-7683-2-git-send-email-manabian@gmail.com>
References: <1439748617-7683-1-git-send-email-manabian@gmail.com>
 <1439748617-7683-2-git-send-email-manabian@gmail.com>
Message-ID: <20150817201830.GA11033@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 Aug 08:10 PM, Joachim Eastwood wrote:
[..]
> +
> +static int i2c_lpc2k_clear_arb(struct lpc2k_i2c *i2c)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> +
> +	/*
> +	 * If the transfer needs to abort for some reason, we'll try to
> +	 * force a stop condition to clear any pending bus conditions
> +	 */
> +	writel(LPC24XX_STO, i2c->base + LPC24XX_I2CONSET);
> +
> +	/* Wait for status change */
> +	while (readl(i2c->base + LPC24XX_I2STAT) != M_I2C_IDLE) {
> +		if (time_after(jiffies, timeout)) {
> +			/* Bus was not idle, try to reset adapter */
> +			i2c_lpc2k_reset(i2c);
> +			return -EBUSY;
> +		}
> +
> +		cpu_relax();
> +	}

I believe you can use readl_{relaxed}_poll_timeout_{atomic} here.

Ccing Ariel, maybe he can help with a test.

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
