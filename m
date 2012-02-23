From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 23 Feb 2012 09:12:35 +0100
Subject: [PATCH v3 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <201202221634.45159.arnd@arndb.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-3-git-send-email-thierry.reding@avionic-design.de>
 <201202221634.45159.arnd@arndb.de>
Message-ID: <20120223081235.GC8621@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann wrote:
> On Wednesday 22 February 2012, Thierry Reding wrote:
> 
> >  #include <linux/module.h>
> > +#include <linux/of_pwm.h>
> >  #include <linux/pwm.h>
> 
> You should probably reorder the patches for bisectability, or move the
> of_* related changes out of this patch into patch 3. At the point
> where patch 2 is applied, linux/of_pwm.h does not exist yet.

You're right. The correct thing would be to move the include into patch 3.
I'll make sure to check for bisectability in the next series.

> > +/**
> > + * pwmchip_find() - iterator for locating a specific pwm_chip
> > + * @data: data to pass to match function
> > + * @match: callback function to check pwm_chip
> > + */
> > +struct pwm_chip *pwmchip_find(void *data, int (*match)(struct pwm_chip *chip,
> > +						       void *data))
> > +{
> > +	struct pwm_chip *ret = NULL;
> > +	struct pwm_chip *chip;
> > +
> > +	mutex_lock(&pwm_lock);
> > +
> > +	list_for_each_entry(chip, &pwm_chips, list) {
> > +		if (match(chip, data)) {
> > +			ret = chip;
> > +			break;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&pwm_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pwmchip_find);
> 
> Is this only used for the device tree functions? If so, I would recommend
> making it less generic and always search for a device node.

It is currently only used to look up a struct pwm_chip for a given struct
device_node, yes. But I can see other uses for this. For instance this could
be useful if we ever want to provide an alternative way of requesting a PWM
on a per-chip basis.

> > +static int pwm_show(struct seq_file *s, void *unused)
> > +{
> > +	const char *prefix = "";
> > +	struct pwm_chip *chip;
> > +
> > +	list_for_each_entry(chip, &pwm_chips, list) {
> > +		struct device *dev = chip->dev;
> > +
> > +		seq_printf(s, "%s%s/%s, %d PWM devices\n", prefix,
> > +			   dev->bus ? dev->bus->name : "no-bus",
> > +			   dev_name(dev), chip->npwm);
> > +
> > +		if (chip->ops->dbg_show)
> > +			chip->ops->dbg_show(chip, s);
> > +		else
> > +			pwm_dbg_show(chip, s);
> > +
> > +		prefix = "\n";
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int pwm_open(struct inode *inode, struct file *file)
> > +{
> > +	return single_open(file, pwm_show, NULL);
> > +}
> 
> When you have a seq_file with a (possibly long) list of entries, better
> use seq_open instead of single_open and print each item in the
> ->next() callback function.

Yes, that should work better. I just noticed that pwm_show() is actually
missing mutex_lock() and mutex_unlock() to protect against chip removal. With
the iterator interface that should be easy to add.

I was again basically looking at gpiolib for inspiration (maybe I should stop
doing that :-). Maybe gpiolib should be reworked to use seq_file's iterator
interface as well? Just in case anybody else turns to gpiolib for
inspiration.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/3dca4417/attachment.sig>
