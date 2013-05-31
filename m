From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 31 May 2013 10:34:59 -0700
Subject: [PATCH 11/11] i2c: omap: enhance pinctrl support
In-Reply-To: <1369995191-20855-12-git-send-email-gururaja.hebbar@ti.com>
 (Hebbar Gururaja's message of "Fri, 31 May 2013 15:43:11 +0530")
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <1369995191-20855-12-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <87k3mf2gu4.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hebbar Gururaja <gururaja.hebbar@ti.com> writes:

> Amend the I2C omap pin controller to optionally take a pin control
> handle and set the state of the pins to:
>
> - "default" on boot, resume and before performing an i2c transfer
> - "idle" after initial default, after resume default, and after each
> i2c xfer
> - "sleep" on suspend()
>
> By optionally putting the pins into sleep state in the suspend callback
> we can accomplish two things.
> - One is to minimize current leakage from pins and thus save power,
> - second, we can prevent the IP from driving pins output in an
> uncontrolled manner, which may happen if the power domain drops the
> domain regulator.
>
> Note:
> A .suspend & .resume callback is added which simply puts the pins to sleep
> state upon suspend & are moved to default & idle state upon resume.
>
> If any of the above pin states are missing in dt, a warning message
> about the missing state is displayed.
> If certain pin-states are not available, to remove this warning message
> pass respective state name with null phandler.
>
> (Changes based on i2c-nomadik.c)
>
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-omap at vger.kernel.org
> Cc: linux-i2c at vger.kernel.org

[...]

> @@ -664,7 +673,13 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  
>  out:
>  	pm_runtime_mark_last_busy(dev->dev);
> +
>  	pm_runtime_put_autosuspend(dev->dev);
> +	/* Optionally let pins go into idle state */
> +	if (!IS_ERR(dev->pins_idle))
> +		if (pinctrl_select_state(dev->pinctrl, dev->pins_idle))
> +			dev_err(dev->dev, "could not set pins to idle state\n");

This is wrong.  You're changing the muxing before the device actually
goes idle.  Anything you want to happen when the device actually idles
for real has to be in runtime PM callbacks.

Looking below, I see it's already in the callbacks, so why is it here also?

[...]

> @@ -1300,6 +1348,10 @@ static int omap_i2c_runtime_suspend(struct device *dev)
>  		omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
>  	}
>  
> +	if (!IS_ERR(_dev->pins_idle))
> +		if (pinctrl_select_state(_dev->pinctrl, _dev->pins_idle))
> +			dev_err(dev, "could not set pins to idle state\n");
> +
>  	return 0;
>  }
>  

Kevin
