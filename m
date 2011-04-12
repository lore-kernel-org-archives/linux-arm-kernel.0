From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 12 Apr 2011 12:17:57 +0200
Subject: [PATCH] clkdev: add debugfs support
In-Reply-To: <20110412065558.GD7771@pengutronix.de>
References: <1302571979-11097-1-git-send-email-plagnioj@jcrosoft.com>
	<20110412065558.GD7771@pengutronix.de>
Message-ID: <20110412101757.GA4709@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 08:55 Tue 12 Apr     , Uwe Kleine-K?nig wrote:
> Hello Jean-Christophe,
> 
> On Tue, Apr 12, 2011 at 03:32:59AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > create a file in /sys/kernel/debug/clkdev
> > 
> > with the list of lookup with the con_id, dev_id and the clock rate
> > 
> > as this
> > 
> > dev_id               con_id               rate
> > (null)               clk32k                   32768 Hz
> > (null)               main                  16367660 Hz
> > (null)               plla                 199919178 Hz
> > (null)               mck                   99959589 Hz
> > at91_mci.0           mci_clk               99959589 Hz
> > at91_mci.1           mci_clk               99959589 Hz
> > atmel_spi.0          spi_clk               99959589 Hz
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > ---
> >  drivers/clk/clkdev.c |   40 ++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 40 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> > index 0fc0a79..5c3a6fb 100644
> > --- a/drivers/clk/clkdev.c
> > +++ b/drivers/clk/clkdev.c
> > @@ -19,6 +19,8 @@
> >  #include <linux/mutex.h>
> >  #include <linux/clk.h>
> >  #include <linux/clkdev.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/seq_file.h>
> >  
> >  static LIST_HEAD(clocks);
> >  static DEFINE_MUTEX(clocks_mutex);
> > @@ -174,3 +176,41 @@ void clkdev_drop(struct clk_lookup *cl)
> >  	kfree(cl);
> >  }
> >  EXPORT_SYMBOL(clkdev_drop);
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static int clkdev_clk_show(struct seq_file *s, void *unused)
> > +{
> > +	struct clk_lookup *p;
> > +
> > +	seq_printf(s, "%-20s %-20s rate\n", "dev_id", "con_id");
> > +
> > +	list_for_each_entry(p, &clocks, node) {
> > +
> > +		seq_printf(s, "%-20s %-20s %9ld Hz\n",
> > +			p->dev_id, p->con_id, clk_get_rate(p->clk));
> s/%9ld/%9lu/ ?
yeah
> 
> According to include/linux/clk.h, the result of clk_get_rate is "only
> valid once the clock source has been enabled". So it would be nice to
> find out (and tell) if a clock is on or not.
it was my idea also at the begenning as we do on at91 but the current clk api
does not allow it

if we want it we need to update the clk API and implement it
> 
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int clkdev_clk_open(struct inode *inode, struct file *file)
> > +{
> > +	return single_open(file, clkdev_clk_show, NULL);
> > +}
> > +
> > +static const struct file_operations clkdev_clk_operations = {
> > +	.open		= clkdev_clk_open,
> > +	.read		= seq_read,
> > +	.llseek		= seq_lseek,
> > +	.release	= single_release,
> > +};
> > +
> > +static int __init clkdev_clk_debugfs_init(void)
> > +{
> > +	/* /sys/kernel/debug/clkdev */
> > +	(void) debugfs_create_file("clkdev", S_IFREG | S_IRUGO, NULL, NULL,
> > +				   &clkdev_clk_operations);
> I'd be a bit more conservative here and would only allow S_IRUSR.
ok will take a look

Best Regards,
J.
