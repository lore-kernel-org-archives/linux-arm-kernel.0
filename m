From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 5 May 2014 12:45:45 -0700
Subject: [RFC PATCH 1/5] watchdog: Add API to trigger reboots
In-Reply-To: <20140505183606.GJ17875@saruman.home>
References: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
 <1398958893-30049-2-git-send-email-linux@roeck-us.net>
 <20140505183606.GJ17875@saruman.home>
Message-ID: <20140505194545.GA30333@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 01:36:06PM -0500, Felipe Balbi wrote:
> On Thu, May 01, 2014 at 08:41:29AM -0700, Guenter Roeck wrote:
> > Some hardware implements reboot through its watchdog hardware,
> > for example by triggering a watchdog timeout. Platform specific
> > code starts to spread into watchdog drivers, typically by setting
> > pointers to a callback functions which is then called from the
> > platform reset handler.
> > 
> > To simplify code and provide a unified API to trigger reboots by
> > watchdog drivers, provide a single API to trigger such reboots
> > through the watchdog subsystem.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/watchdog/watchdog_core.c |   17 +++++++++++++++++
> >  include/linux/watchdog.h         |   11 +++++++++++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> > index cec9b55..4ec6e2f 100644
> > --- a/drivers/watchdog/watchdog_core.c
> > +++ b/drivers/watchdog/watchdog_core.c
> > @@ -43,6 +43,17 @@
> >  static DEFINE_IDA(watchdog_ida);
> >  static struct class *watchdog_class;
> >  
> > +static struct watchdog_device *wdd_reboot_dev;
> > +
> > +void watchdog_do_reboot(enum reboot_mode mode, const char *cmd)
> > +{
> > +	if (wdd_reboot_dev) {
> > +		if (wdd_reboot_dev->ops->reboot)
> 
> you can decrease one level of indentation:
> 
> 	if (wdd_reboot_dev && wdd_reboot_dev->ops->reboot)
> 
> also, shouldn't you test if 'ops' is valid too ? In that case:
> 
> 	if (wdd_reboot_dev && wdd_reboot_dev->ops &&
> 		wdd_reboot_dev->ops->reboot)
> 
Hmmm ... makes me think.

If ops->reboot is not set, wdd_reboot_dev should be NULL
to start with, since it is only initialized if ops->reboot
is not NULL.

It is not common in the Linux kernel to re-check pointers
if the condition can not occur, so I don't think it should
be done here.

In other words, I should probably remove the ops check as well.

Guenter
