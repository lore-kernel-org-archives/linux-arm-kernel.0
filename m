From: avinashphilip@ti.com (Philip, Avinash)
Date: Wed, 13 Feb 2013 11:42:01 +0000
Subject: [PATCH v2 3/4] mtd: devices: elm: Low power transition support
In-Reply-To: <20130209102243.GH17852@n2100.arm.linux.org.uk>
References: <1360240618-11094-1-git-send-email-avinashphilip@ti.com>
 <1360240618-11094-4-git-send-email-avinashphilip@ti.com>
 <20130209102243.GH17852@n2100.arm.linux.org.uk>
Message-ID: <518397C60809E147AF5323E0420B992E3EA7491C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 09, 2013 at 15:52:44, Russell King - ARM Linux wrote:
> On Thu, Feb 07, 2013 at 06:06:57PM +0530, Philip Avinash wrote:
> > +static int elm_suspend(struct device *dev)
> > +{
> > +	struct elm_info *info = dev_get_drvdata(dev);
> > +	wait_queue_head_t wq;
> > +	DECLARE_WAITQUEUE(wait, current);
> > +
> > +	init_waitqueue_head(&wq);
> > +	while (1) {
> > +		/* Make sure that ELM not running */
> > +		if (info->idle) {
> > +			add_wait_queue(&wq, &wait);
> > +			schedule();
> > +			remove_wait_queue(&wq, &wait);
> > +		} else {
> > +			break;
> > +		}
> > +	}
> 
> The above code looks really wrong - it will just spin endlessly with the
> waitqueues doing nothing useful.  What are you trying to do here?

The intention of waitqeue is to make the suspend process really wait till
the ELM module finishes current activity. Although this type of protection
already achieved in mtd layer using nand_suspend(), this one is particularly
required for ELM module to really make sure that *any pending* corrections to
finish really before gone to suspend.

If suspend activity initiated and NAND driver requested service of ELM
module for error correction, then suspend activity has to wait till
(info->idle == false), so that ELM module finishes activity.

I can think of adding different states to ELM module and take action.
I will add following states.

RUNNING
SUSPEND

Thanks
Avinash

> 
