From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 11:27:45 +0200
Subject: [PATCH v2 1/6] wdt: sunxi: Move restart code to the watchdog
 driver
In-Reply-To: <53A8A084.3000005@roeck-us.net>
References: <1399430664-29091-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140623213046.GR22347@spo001.leaseweb.com> <53A8A084.3000005@roeck-us.net>
Message-ID: <20298828.cYNPnTRxWX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 June 2014 14:47:48 Guenter Roeck wrote:
> > To continue the discussion: I would like to add an excerpt from drivers/watchdog/alim7101_wdt.c
> > /*
> >   *      Notifier for system down
> >   */
> >
> > static int wdt_notify_sys(struct notifier_block *this,
> >                                          unsigned long code, void *unused)
> > {
> >          if (code == SYS_DOWN || code == SYS_HALT)
> >                  wdt_turnoff();
> >
> >          if (code == SYS_RESTART) {
> >                  /*
> >                   * Cobalt devices have no way of rebooting themselves other
> >                   * than getting the watchdog to pull reset, so we restart the
> >                   * watchdog on reboot with no heartbeat
> >                   */
> >                  wdt_change(WDT_ENABLE);
> >                  pr_info("Watchdog timer is now enabled with no heartbeat - should reboot in ~1 second\n");
> >          }
> >          return NOTIFY_DONE;
> > }
> >
> > For some systems the watchdog is the only way to reboot... So where we should put it, is not trivial neither...
> >
> 
> Agreed. The above definitely doesn't look like a good solution to me.
> 

Right, at the very least, it should be a separate notifier: the existing
reboot_notifier is meant for things that need to happen /before/ reboot,
so adding something in there to actually trigger the reboot is by definition
racy against the other notifiers that may or may not get called after
this one.

	Arnd
