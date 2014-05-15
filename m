From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 15 May 2014 14:47:43 -0700
Subject: [PATCH v3 1/6] watchdog: Add API to trigger reboots
In-Reply-To: <20140515215020.38f03ab1@alan.etchedpixels.co.uk>
References: <1400186304-1691-1-git-send-email-linux@roeck-us.net>
 <1400186304-1691-2-git-send-email-linux@roeck-us.net>
 <20140515215020.38f03ab1@alan.etchedpixels.co.uk>
Message-ID: <20140515214743.GA15577@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 09:50:20PM +0100, One Thousand Gnomes wrote:
> > +void watchdog_do_reboot(void)
> > +{
> > +	if (wdd_reboot_dev)
> > +		wdd_reboot_dev->ops->reboot(wdd_reboot_dev);
> > +}
> > +EXPORT_SYMBOL(watchdog_do_reboot);
> 
> Crashes and burns if you are unloading a watchdog just as you try to
> reboot. Yes its wildly unlikely but it's still conceptually wrong.
> 
Possibly, but how is it different to the code it replaces ?

> >  
> > +	if (wdd->ops->reboot)
> > +		wdd_reboot_dev = wdd;
> > +
> 
> Two parallel registers from different bus types, parallel
> register/unregister ?
> 
Sorry, you lost me. What different bus types ?

> This feels to me like a backward step. We've gone from various device
> bits leaking into the core code (where they can work all the time) to
> various core code leaking into the devices which is asking for init order
> problems and other races.
> 
> Given we are talking about stuff of the order of 10-20 instructions I
> think duplication is not only the lesser evil it's also smaller, more
> reliable and easier to maintain.
> 
> IMHO this is a solution looking for a problem.
> 
Really ?  To me it seems to be much cleaner than setting the pointer to
arm_pm_restart directly from individual watchdog drivers. Also, and I was
told that other HW may benefit from it as well.

Do I understand it correctly that you prefer watchdog drivers to set
arm_pm_restart directly ? Maybe you can explain a bit why you believe
that to be a superior solution.

In addition to that, while I could obviously add some locking around access to
wdd_reboot_dev, existing code doesn't lock any changes to arm_pm_restart. I am
somewhat at loss why setting or clearing arm_pm_restart is less of a problem
that setting wdd_reboot_dev.

Thanks,
Guenter
