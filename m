From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 8 Apr 2016 11:20:11 -0700
Subject: [Xen-devel] [PATCH 2/6] ARM: xen: Register with kernel restart
 handler
In-Reply-To: <20160408152257.GJ15411@char.us.oracle.com>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
 <1460120039-2497-3-git-send-email-linux@roeck-us.net>
 <20160408152257.GJ15411@char.us.oracle.com>
Message-ID: <20160408182011.GA7083@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2016 at 11:22:57AM -0400, Konrad Rzeszutek Wilk wrote:
> On Fri, Apr 08, 2016 at 05:53:55AM -0700, Guenter Roeck wrote:
> > Register with kernel restart handler instead of setting arm_pm_restart
> > directly.
> > 
> > Select a high priority of 192 to ensure that default restart handlers
> 
> Is there some macro for that magic value?
> 
No, only guidelines in kernel/reboot.c.

Guenter

> > are replaced if Xen is running.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  arch/arm/xen/enlighten.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > index 75cd7345c654..76a1d12fd27e 100644
> > --- a/arch/arm/xen/enlighten.c
> > +++ b/arch/arm/xen/enlighten.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/cpu.h>
> >  #include <linux/console.h>
> >  #include <linux/pvclock_gtod.h>
> > +#include <linux/reboot.h>
> >  #include <linux/time64.h>
> >  #include <linux/timekeeping.h>
> >  #include <linux/timekeeper_internal.h>
> > @@ -193,14 +194,22 @@ after_register_vcpu_info:
> >  	put_cpu();
> >  }
> >  
> > -static void xen_restart(enum reboot_mode reboot_mode, const char *cmd)
> > +static int xen_restart(struct notifier_block *nb, unsigned long action,
> > +		       void *data)
> >  {
> >  	struct sched_shutdown r = { .reason = SHUTDOWN_reboot };
> >  	int rc;
> >  	rc = HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
> >  	BUG_ON(rc);
> > +
> > +	return NOTIFY_DONE;
> >  }
> >  
> > +static struct notifier_block xen_restart_nb = {
> > +	.notifier_call = xen_restart,
> > +	.priority = 192,
> > +};
> > +
> >  static void xen_power_off(void)
> >  {
> >  	struct sched_shutdown r = { .reason = SHUTDOWN_poweroff };
> > @@ -370,7 +379,7 @@ static int __init xen_pm_init(void)
> >  		return -ENODEV;
> >  
> >  	pm_power_off = xen_power_off;
> > -	arm_pm_restart = xen_restart;
> > +	register_restart_handler(&xen_restart_nb);
> >  	if (!xen_initial_domain()) {
> >  		struct timespec64 ts;
> >  		xen_read_wallclock(&ts);
> > -- 
> > 2.5.0
> > 
> > 
> > _______________________________________________
> > Xen-devel mailing list
> > Xen-devel at lists.xen.org
> > http://lists.xen.org/xen-devel
