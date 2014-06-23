From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jun 2014 17:35 +0200
Subject: [PATCH v2 1/6] wdt: sunxi: Move restart code to the watchdog
 driver
In-Reply-To: <53A844C2.7070804@roeck-us.net>
References: <1399430664-29091-1-git-send-email-maxime.ripard@free-electrons.com>
 <19870078.UBj78UMBrO@wuerfel> <53A844C2.7070804@roeck-us.net>
Message-ID: <4880375.uMKpQASVMt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 June 2014 08:16:18 Guenter Roeck wrote:
> > Moved to where?
> >
> > I certainly don't want it in the platform directories, and for arm64 we
> > intentionally don't have a place to put this stuff.
> >
> 
> I have no idea, but setting the arm reset function pointer from a watchdog
> driver doesn't seem like a good idea either. The arm code _does_ provide
> and expect platform code to set the reset function, so having it in the arm
> code would at least make more sense than expecting some unrelated driver
> code to set it - especially since it is inherently racy [1].

I don't think the race is inherent. We could solve the multiple registration
problem and the unload problem using a notifier chain. If there are actually
cases where we expect to see multiple reboot functions to be present in the
system, we could go one step further and have a priority associated with
it, so we try the best function first and fall back to soft_restart()
if everything else fails.

	Arnd
