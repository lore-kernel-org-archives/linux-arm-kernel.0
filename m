From: marc@cpdesign.com.au (Marc Reilly)
Date: Wed, 8 Dec 2010 19:07:55 +1100
Subject: [PATCH] Added i2c support for mc13xxx-core
In-Reply-To: <AANLkTikuhKAsgY-9X+FUzeL5piv5S6Cy4_RXdiAD0efP@mail.gmail.com>
References: <201012070854.21049.marc@cpdesign.com.au>
	<1291706087-6476-2-git-send-email-marc@cpdesign.com.au>
	<AANLkTikuhKAsgY-9X+FUzeL5piv5S6Cy4_RXdiAD0efP@mail.gmail.com>
Message-ID: <201012081907.55980.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

> It's better to use git format-patch to gernerate patch for review, by
> which you can add some commit information and s-o-b stuff.

I've submitted a (slightly) better patch earlier today. (although this was 
generated via format-patch, I forgot the sob.). 

My main hope was to get some indication that I was progressing along the right 
path.

> Please see inline comments.
Thanks, replies also in-line.

snip...

> > +               if (usespi) {
> > +                       const struct spi_device_id *devid =
> > +                               spi_get_device_id(mc13xxx->spidev);
> > +                       if (!devid || devid->driver_data !=
> > mc13xxx->icid) +                               dev_warn(mc13xxx->pdev,
> > "device id doesn't " +                                              
> > "match auto detection!\n"); +               } else {
> > +                       /* TODO */
> 
> todo what? remove this or add real code here.
> 

I wasn't immediately sure of what the equivalent way to do this via the i2c 
subsystem is. I'm not sure how useful it would be anyway, so I'll leave it out 
in future.

snip ...

> > +       mutex_init(&mc13xxx->lock);
> > +       mc13xxx_lock(mc13xxx);
> > +
> > +       ret = mc13xxx_identify(mc13xxx, 0);
> > +       if (ret || (mc13xxx->icid == MC13XXX_ID_INVALID))
> > +               goto err_revision;
> > +
> > +       /* mask all irqs */
> > +       ret = mc13xxx_reg_write(mc13xxx, MC13XXX_IRQMASK0, 0x00ffffff);
> > +       if (ret)
> > +               goto err_mask;
> > +
> > +       ret = mc13xxx_reg_write(mc13xxx, MC13XXX_IRQMASK1, 0x00ffffff);
> > +       if (ret)
> > +               goto err_mask;
> > +
> > +       ret = request_threaded_irq(mc13xxx->irq, NULL,
> > mc13xxx_irq_thread, +                       IRQF_ONESHOT |
> > IRQF_TRIGGER_HIGH, "mc13xxx", mc13xxx); +
> > +       if (ret) {
> > +err_mask:
> 
> > +err_revision:
> Why two labels here?

Copied from existing code. 

> Also, if ret == 0, the lock will not be released.

The lock is released in mc13xxx_common_probe. 
Yes, it would be better in this function, before common_probe is called.

> 
> > +               mutex_unlock(&mc13xxx->lock);
> > +               kfree(mc13xxx);
> > +               return ret;
> > +       }
> > +
> > +       return mc13xxx_common_probe(mc13xxx,pdata);
> > +}
> > +
> > +static int __devexit mc13xxx_i2c_remove(struct i2c_client *client)
> > +{
> > +       struct mc13xxx *mc13xxx = dev_get_drvdata(&client->dev);
> > +
> > +       free_irq(mc13xxx->irq, mc13xxx);
> > +
> > +       mfd_remove_devices(&client->dev);
> > +
> > +       kfree(mc13xxx);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct i2c_device_id mc13xxx_i2c_idtable[] = {
> > +       { "mc13892", MC13XXX_ID_MC13892},
> > +       { }
> 
> you may want to remove empty '{}'

Again, mimicking the existing spi device table.

> 
> > +};
> > +
> > +static struct i2c_driver mc13xxx_i2c_driver = {
> > +       .driver = {
> > +               .owner = THIS_MODULE,
> > +               .name = "mc13xxx-i2c"
> > +       },
> > +       .id_table = mc13xxx_i2c_idtable,
> > +       .probe = mc13xxx_i2c_probe,
> > +       .remove = __devexit_p(mc13xxx_i2c_remove),
> >  };
> > 
> >  static int __init mc13xxx_init(void)
> >  {
> > -       return spi_register_driver(&mc13xxx_driver);
> > +       int i2cret;
> > +       int spiret;
> > +       i2cret = i2c_add_driver(&mc13xxx_i2c_driver);
> > +       spiret = spi_register_driver(&mc13xxx_driver);
> > +
> > +       return (i2cret == 0) && (spiret == 0);

For the record, I missed this, its fixed in my later patch. Return should be 0 
if both are successful.

Cheers,
Marc
