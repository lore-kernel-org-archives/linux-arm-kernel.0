From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 4 May 2014 23:27:26 -0500
Subject: [RFC PATCH 1/5] watchdog: Add API to trigger reboots
In-Reply-To: <20140503042925.GB5882@roeck-us.net>
References: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
 <1398958893-30049-2-git-send-email-linux@roeck-us.net>
 <20140503012243.GG4090@lukather>
 <20140503042925.GB5882@roeck-us.net>
Message-ID: <20140505042726.GF11606@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 09:29:25PM -0700, Guenter Roeck wrote:
> > > +	if (wdd->ops->reboot)
> > > +		wdd_reboot_dev = wdd;
> > > +
> > 
> > Overall, it looks really great, but I guess we can make it a
> > list. Otherwise, we might end up in a situation where we could not
> > reboot anymore, like this one for example:
> >   - a first watchdog is probed, registers a reboot function
> >   - a second watchdog is probed, registers a reboot function that
> >     overwrites the first one.
> >   - then, the second watchdog disappears for some reason, and the
> >     reboot is set to NULL
> > 
> I thought about that, but how likely (or unlikely) is that to ever happen ?
> So I figured it is not worth the effort, and would just add complexity without
> real gain. We could always add the list later if we ever encounter a situation
> where two watchdogs in the same system provide a reboot callback.

The A31 we were discussing about in the other thread that doesn't have
a watchdog driver yet has four, identical, watchogs. I'm not really
concerned about the mentionned issue, since they will never be
removed, but the situation might happen with an on-SoC watchdog and an
i2c one (if that even exists).

But yes, right, that can be postponed.

> > Or maybe we can just use the start callback, with the min timeout already
> > registered, and prevent the user to kick the watchdog.
> > 
> Doesn't always work, unfortunately, even now. The moxart driver causes 
> an explicit and immediate reset. Also, some watchdogs don't reset the system
> directly but get an interrupt, which then calls the reset handler. Which,
> in our case, would call the start callback again, and you would have an endless
> loop.

Ok. You have my Acked-by then.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140504/399fa054/attachment.sig>
