From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 5 Jun 2017 10:16:34 -0400 (EDT)
Subject: [PATCH v14 4/7] usb: core: add power sequence handling for USB
 devices
In-Reply-To: <20170605065537.GE20014@b29397-desktop>
Message-ID: <Pine.LNX.4.44L0.1706051013300.1795-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Jun 2017, Peter Chen wrote:

> On Thu, May 18, 2017 at 08:49:00AM +0800, Peter Chen wrote:
> > Some hard-wired USB devices need to do power sequence to let the
> > device work normally, the typical power sequence like: enable USB
> > PHY clock, toggle reset pin, etc. But current Linux USB driver
> > lacks of such code to do it, it may cause some hard-wired USB devices
> > works abnormal or can't be recognized by controller at all.
> > 
> > In this patch, it calls power sequence library APIs to finish
> > the power sequence events. It will do power on sequence at hub's
> > probe for all devices under this hub (includes root hub).
> > At hub_disconnect, it will do power off sequence which is at powered
> > on list.
> > 
> 
> Greg, Alan, would you please help on reviewing it? It seems Rafael
> is waiting for USB MAINTAINERS's comments or ack. It resolves some
> USB HUB issues for several persons.
> 
> Peter
> 
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > Reviewed-by: Vaibhav Hiremath <hvaibhav.linux@gmail.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> > ---
> >  drivers/usb/Kconfig    |  1 +
> >  drivers/usb/core/hub.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
> >  drivers/usb/core/hub.h |  1 +
> >  3 files changed, 47 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> > index 939a63b..b6f626e 100644
> > --- a/drivers/usb/Kconfig
> > +++ b/drivers/usb/Kconfig
> > @@ -39,6 +39,7 @@ config USB
> >  	tristate "Support for Host-side USB"
> >  	depends on USB_ARCH_HAS_HCD
> >  	select USB_COMMON
> > +	select POWER_SEQUENCE
> >  	select NLS  # for UTF-8 strings
> >  	---help---
> >  	  Universal Serial Bus (USB) is a specification for a serial bus
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 9dca59e..7a67296 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/random.h>
> >  #include <linux/pm_qos.h>
> > +#include <linux/power/pwrseq.h>
> >  
> >  #include <linux/uaccess.h>
> >  #include <asm/byteorder.h>
> > @@ -1619,6 +1620,7 @@ static void hub_disconnect(struct usb_interface *intf)
> >  	hub->error = 0;
> >  	hub_quiesce(hub, HUB_DISCONNECT);
> >  
> > +	of_pwrseq_off_list(&hub->pwrseq_on_list);

Things like this look a little peculiar -- you are passing an "on_list" 
to a function named "...off_list".

How about naming the new field hub->pwrseq_list instead?

Alan Stern
