From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 18 Feb 2014 08:59:11 -0800
Subject: [PATCH v4 1/2] usb: musb: dsps, debugfs files
In-Reply-To: <20140218162054.GE9878@saruman.home>
References: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
 <1389950556-6453-2-git-send-email-mpa@pengutronix.de>
 <20140218162054.GE9878@saruman.home>
Message-ID: <20140218165911.GA17486@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 10:20:54AM -0600, Felipe Balbi wrote:
> On Fri, Jan 17, 2014 at 10:22:35AM +0100, Markus Pargmann wrote:
> > debugfs files to show the contents of important dsps registers.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/usb/musb/musb_dsps.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> > 
> > diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> > index 593d3c9..d0a97d6 100644
> > --- a/drivers/usb/musb/musb_dsps.c
> > +++ b/drivers/usb/musb/musb_dsps.c
> > @@ -46,6 +46,8 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/usb/of.h>
> >  
> > +#include <linux/debugfs.h>
> > +
> >  #include "musb_core.h"
> >  
> >  static const struct of_device_id musb_dsps_of_match[];
> > @@ -137,6 +139,26 @@ struct dsps_glue {
> >  	unsigned long last_timer;    /* last timer data for each instance */
> >  
> >  	struct dsps_context context;
> > +	struct debugfs_regset32 regset;
> > +	struct dentry *dbgfs_root;
> > +};
> > +
> > +static const struct debugfs_reg32 dsps_musb_regs[] = {
> > +	{ "revision",		0x00 },
> > +	{ "control",		0x14 },
> > +	{ "status",		0x18 },
> > +	{ "eoi",		0x24 },
> > +	{ "intr0_stat",		0x30 },
> > +	{ "intr1_stat",		0x34 },
> > +	{ "intr0_set",		0x38 },
> > +	{ "intr1_set",		0x3c },
> > +	{ "txmode",		0x70 },
> > +	{ "rxmode",		0x74 },
> > +	{ "autoreq",		0xd0 },
> > +	{ "srpfixtime",		0xd4 },
> > +	{ "tdown",		0xd8 },
> > +	{ "phy_utmi",		0xe0 },
> > +	{ "mode",		0xe8 },
> >  };
> >  
> >  static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
> > @@ -369,6 +391,30 @@ out:
> >  	return ret;
> >  }
> >  
> > +static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glue *glue)
> > +{
> > +	struct dentry *root;
> > +	struct dentry *file;
> > +	char buf[128];
> > +
> > +	sprintf(buf, "%s.dsps", dev_name(musb->controller));
> > +	root = debugfs_create_dir(buf, NULL);
> > +	if (!root)
> 
> wrong, you should be using IS_ERR()

!root is fine, IS_ERR() will fail if CONFIG_DEBUGFS is not enabled.
