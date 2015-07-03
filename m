From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 03 Jul 2015 17:28:19 +0200
Subject: [PATCH-V2 08/12] i2c: pxa: enable/disable i2c module across msg
 xfer
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1434383399-2370-9-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <87oajtb6r0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:

>  #define _IBMR(i2c)	((i2c)->reg_ibmr)
> @@ -286,6 +287,22 @@ static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
>  static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
>  static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
>  
> +/* enable/disable i2c unit */
> +static inline int i2c_pxa_is_enabled(struct pxa_i2c *i2c)
> +{
> +	return (readl(_ICR(i2c)) & ICR_IUE);
> +}
> +
> +static inline void i2c_pxa_enable(struct pxa_i2c *i2c, bool enable)
> +{
> +	if (enable && !i2c_pxa_is_enabled(i2c)) {
> +		writel(readl(_ICR(i2c)) | ICR_IUE, _ICR(i2c));
> +		udelay(100);
> +	} else {
> +		writel(readl(_ICR(i2c)) & ~ICR_IUE, _ICR(i2c));
> +	}
> +}
> +
>  static inline int i2c_pxa_is_slavemode(struct pxa_i2c *i2c)
>  {
>  	return !(readl(_ICR(i2c)) & ICR_SCLE);
> @@ -482,8 +499,7 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>  	i2c_pxa_set_slave(i2c, 0);
>  
>  	/* enable unit */
> -	writel(readl(_ICR(i2c)) | ICR_IUE, _ICR(i2c));
> -	udelay(100);
> +	i2c_pxa_enable(i2c, true);
>  }
>  
>  
> @@ -840,6 +856,9 @@ static int i2c_pxa_pio_xfer(struct i2c_adapter *adap,
>  	struct pxa_i2c *i2c = adap->algo_data;
>  	int ret, i;
>  
> +	/* Enable i2c unit */
> +	i2c_pxa_enable(i2c, true);
> +
>  	/* If the I2C controller is disabled we need to reset it
>  	  (probably due to a suspend/resume destroying state). We do
>  	  this here as we can then avoid worrying about resuming the
> @@ -860,6 +879,11 @@ static int i2c_pxa_pio_xfer(struct i2c_adapter *adap,
>  	ret = -EREMOTEIO;
>   out:
>  	i2c_pxa_set_slave(i2c, ret);
> +
> +	/* disable i2c unit */
> +	if (i2c->disable_after_xfer)
> +		i2c_pxa_enable(i2c, false);
> +
>  	return ret;
>  }
>  
> @@ -1075,6 +1099,9 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
>  	struct pxa_i2c *i2c = adap->algo_data;
>  	int ret, i;
>  
> +	/* Enable i2c unit */
> +	i2c_pxa_enable(i2c, true);
Okay, what happens in master mode when we get there on the 2nd xfer :
 - i2c is enabled AFAIU.
 - as a consequence i2c_pxa_is_enabled() returns true
 - as a consequence, i2c_pxa_enable() _disables_ the i2c, right ?
 - as a consequence i2c is broken

Is this correct, because if it is the patch needs a rework ?

Cheers.

--
Robert
