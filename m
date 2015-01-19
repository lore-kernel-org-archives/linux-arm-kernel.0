From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Jan 2015 23:04:27 +0000
Subject: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
In-Reply-To: <20150119190142.GA9451@kroah.com>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
 <20150119190142.GA9451@kroah.com>
Message-ID: <20150119230427.GH26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 03:01:42AM +0800, Greg Kroah-Hartman wrote:
> On Mon, Jan 19, 2015 at 07:55:56PM +0100, Wolfram Sang wrote:
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 39d25a8cb1ad..15cc5902cf89 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -41,7 +41,6 @@
> >  #include <linux/of_device.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/clk/clk-conf.h>
> > -#include <linux/completion.h>
> >  #include <linux/hardirq.h>
> >  #include <linux/irqflags.h>
> >  #include <linux/rwsem.h>
> > @@ -1184,8 +1183,7 @@ EXPORT_SYMBOL_GPL(i2c_new_dummy);
> >  
> >  static void i2c_adapter_dev_release(struct device *dev)
> >  {
> > -	struct i2c_adapter *adap = to_i2c_adapter(dev);
> > -	complete(&adap->dev_released);
> > +	/* empty, but the driver core insists we need a release function */
> 
> Yeah, it does, but I hate to see this in "real" code as something is
> probably wrong with it if it happens.
> 
> Please move the rest of 'i2c_del_adapter' into the release function
> (what was after the wait_for_completion() call), and then all should be
> fine.

Are you sure about that?  Some drivers do this, eg,

        i2c_del_adapter(&drv_data->adapter);
        free_irq(drv_data->irq, drv_data);

where drv_data was allocated using devm_kzalloc(), and so will be
released when the ->remove callback (which calls the above
i2c_del_adapter()) returns... freeing the embedded device struct.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
