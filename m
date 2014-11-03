From: balbi@ti.com (Felipe Balbi)
Date: Mon, 3 Nov 2014 11:59:54 -0600
Subject: [PATCH v3 09/47] mfd: palmas: Register with kernel power-off
 handler
In-Reply-To: <20141103175645.GT12011@x1>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-10-git-send-email-linux@roeck-us.net>
 <20141103175645.GT12011@x1>
Message-ID: <20141103175954.GT27425@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 05:56:45PM +0000, Lee Jones wrote:
> On Mon, 27 Oct 2014, Guenter Roeck wrote:
> 
> > Register with kernel power-off handler instead of setting pm_power_off
> > directly. Register with low priority to reflect that the original code
> > only sets pm_power_off if it was not already set.
> > 
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v3:
> > - Replace poweroff in all newly introduced variables and in text
> >   with power_off or power-off as appropriate
> > - Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
> > v2:
> > - Use define to specify poweroff handler priority
> > - Use devm_register_power_off_handler
> > - Use dev_warn instead of dev_err
> > 
> >  drivers/mfd/palmas.c       | 31 +++++++++++++++++--------------
> >  include/linux/mfd/palmas.h |  3 +++
> >  2 files changed, 20 insertions(+), 14 deletions(-)
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

missed lakml and linux-omap.

> 
> > diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> > index 28cb048..99c488e 100644
> > --- a/drivers/mfd/palmas.c
> > +++ b/drivers/mfd/palmas.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > +#include <linux/pm.h>
> >  #include <linux/regmap.h>
> >  #include <linux/err.h>
> >  #include <linux/mfd/core.h>
> > @@ -425,20 +426,18 @@ static void palmas_dt_to_pdata(struct i2c_client *i2c,
> >  			"ti,system-power-controller");
> >  }
> >  
> > -static struct palmas *palmas_dev;
> > -static void palmas_power_off(void)
> > +static int palmas_power_off(struct notifier_block *this, unsigned long unused1,
> > +			    void *unused2)
> >  {
> > +	struct palmas *palmas = container_of(this, struct palmas, power_off_nb);
> >  	unsigned int addr;
> >  	int ret, slave;
> >  
> > -	if (!palmas_dev)
> > -		return;
> > -
> >  	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PMU_CONTROL_BASE);
> >  	addr = PALMAS_BASE_TO_REG(PALMAS_PMU_CONTROL_BASE, PALMAS_DEV_CTRL);
> >  
> >  	ret = regmap_update_bits(
> > -			palmas_dev->regmap[slave],
> > +			palmas->regmap[slave],
> >  			addr,
> >  			PALMAS_DEV_CTRL_DEV_ON,
> >  			0);
> > @@ -446,6 +445,8 @@ static void palmas_power_off(void)
> >  	if (ret)
> >  		pr_err("%s: Unable to write to DEV_CTRL_DEV_ON: %d\n",
> >  				__func__, ret);
> > +
> > +	return NOTIFY_DONE;
> >  }
> >  
> >  static unsigned int palmas_features = PALMAS_PMIC_FEATURE_SMPS10_BOOST;
> > @@ -668,9 +669,16 @@ no_irq:
> >  		ret = of_platform_populate(node, NULL, NULL, &i2c->dev);
> >  		if (ret < 0) {
> >  			goto err_irq;
> > -		} else if (pdata->pm_off && !pm_power_off) {
> > -			palmas_dev = palmas;
> > -			pm_power_off = palmas_power_off;
> > +		} else if (pdata->pm_off) {
> > +			int ret2;
> > +
> > +			palmas->power_off_nb.notifier_call = palmas_power_off;
> > +			palmas->power_off_nb.priority = POWER_OFF_PRIORITY_LOW;
> > +			ret2 = devm_register_power_off_handler(palmas->dev,
> > +							&palmas->power_off_nb);
> > +			if (ret2)
> > +				dev_warn(palmas->dev,
> > +					 "Failed to register power-off handler");
> >  		}
> >  	}
> >  
> > @@ -698,11 +706,6 @@ static int palmas_i2c_remove(struct i2c_client *i2c)
> >  			i2c_unregister_device(palmas->i2c_clients[i]);
> >  	}
> >  
> > -	if (palmas == palmas_dev) {
> > -		pm_power_off = NULL;
> > -		palmas_dev = NULL;
> > -	}
> > -
> >  	return 0;
> >  }
> >  
> > diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> > index fb0390a..7dbfe24 100644
> > --- a/include/linux/mfd/palmas.h
> > +++ b/include/linux/mfd/palmas.h
> > @@ -18,6 +18,7 @@
> >  
> >  #include <linux/usb/otg.h>
> >  #include <linux/leds.h>
> > +#include <linux/notifier.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/driver.h>
> >  #include <linux/extcon.h>
> > @@ -68,6 +69,8 @@ struct palmas {
> >  	struct i2c_client *i2c_clients[PALMAS_NUM_CLIENTS];
> >  	struct regmap *regmap[PALMAS_NUM_CLIENTS];
> >  
> > +	struct notifier_block power_off_nb;
> > +
> >  	/* Stored chip id */
> >  	int id;
> >  
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/8e5a43da/attachment.sig>
