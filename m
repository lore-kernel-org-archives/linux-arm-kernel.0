From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 13 Apr 2016 19:24:54 +0800
Subject: [PATCH 3/6] ARM: PSCI: Register with kernel restart handler
In-Reply-To: <20160413110519.GE32018@leverpostej>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
 <1460120039-2497-4-git-send-email-linux@roeck-us.net>
 <20160413110519.GE32018@leverpostej>
Message-ID: <20160413192454.778c3df4@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,

On Wed, 13 Apr 2016 12:05:19 +0100 Mark Rutland wrote:

> On Fri, Apr 08, 2016 at 05:53:56AM -0700, Guenter Roeck wrote:
> > Register with kernel restart handler instead of setting arm_pm_restart
> > directly. This enables support for replacing the PSCI restart handler
> > with a different handler if necessary for a specific board.
> > 
> > Select a priority of 129 to indicate a higher than default priority, but
> > keep it as low as possible since PSCI reset is known to fail on some
> > boards.  
> 
> For reference, which boards?
> 
> It's unfortunate that that a PSCI 0.2+ implementation would be lacking a
> working SYSTEM_RESET implementation, and it's certainly a mistake to
> discourage.

I may understand the case: on some platforms, the only reset way is
to trigger the wdt, for various reason the underly firmware isn't
convenient to touch the wdt.

But I'd like 127 or lower for the default priority for the above case, because
various wdt reset_handler priority is 128.

Thanks,
Jisheng

> 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > It might make sense to introduce a restart-priority property for devicetree
> > based configurations, but I am not sure if this would be acceptable.  
> 
> From the DT side, I'm not keen on properties for priorities. They're
> incredibly fragile and don't really encode a HW property.
> 
> A better option would be to have a property to describe how the PSCI
> implementation is broken (e.g. broken-system-reset), and not register
> the handler at all in that case.
> 
> Thanks,
> Mark.
> 
> >  drivers/firmware/psci.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> > index 11bfee8b79a9..99fab3ac3fd5 100644
> > --- a/drivers/firmware/psci.c
> > +++ b/drivers/firmware/psci.c
> > @@ -231,11 +231,18 @@ static int get_set_conduit_method(struct device_node *np)
> >  	return 0;
> >  }
> >  
> > -static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
> > +static int psci_sys_reset(struct notifier_block *np, unsigned long action,
> > +			  void *data)
> >  {
> >  	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
> > +	return NOTIFY_DONE;
> >  }
> >  
> > +static struct notifier_block psci_sys_reset_nb = {
> > +	.notifier_call = psci_sys_reset,
> > +	.priority = 129,
> > +};
> > +
> >  static void psci_sys_poweroff(void)
> >  {
> >  	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
> > @@ -461,7 +468,7 @@ static void __init psci_0_2_set_functions(void)
> >  
> >  	psci_ops.migrate_info_type = psci_migrate_info_type;
> >  
> > -	arm_pm_restart = psci_sys_reset;
> > +	register_restart_handler(&psci_sys_reset_nb);
> >  
> >  	pm_power_off = psci_sys_poweroff;
> >  }
> > -- 
> > 2.5.0
> >   
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
