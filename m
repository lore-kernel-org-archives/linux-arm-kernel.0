From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Thu, 15 May 2014 21:50:20 +0100
Subject: [PATCH v3 1/6] watchdog: Add API to trigger reboots
In-Reply-To: <1400186304-1691-2-git-send-email-linux@roeck-us.net>
References: <1400186304-1691-1-git-send-email-linux@roeck-us.net>
 <1400186304-1691-2-git-send-email-linux@roeck-us.net>
Message-ID: <20140515215020.38f03ab1@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +void watchdog_do_reboot(void)
> +{
> +	if (wdd_reboot_dev)
> +		wdd_reboot_dev->ops->reboot(wdd_reboot_dev);
> +}
> +EXPORT_SYMBOL(watchdog_do_reboot);

Crashes and burns if you are unloading a watchdog just as you try to
reboot. Yes its wildly unlikely but it's still conceptually wrong.

>  
> +	if (wdd->ops->reboot)
> +		wdd_reboot_dev = wdd;
> +

Two parallel registers from different bus types, parallel
register/unregister ?

This feels to me like a backward step. We've gone from various device
bits leaking into the core code (where they can work all the time) to
various core code leaking into the devices which is asking for init order
problems and other races.

Given we are talking about stuff of the order of 10-20 instructions I
think duplication is not only the lesser evil it's also smaller, more
reliable and easier to maintain.

IMHO this is a solution looking for a problem.

Alan
