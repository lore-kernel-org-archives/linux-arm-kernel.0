From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Sep 2013 22:01:08 +0200
Subject: [PATCH v4 4/4] ARM: bcm4760: Add restart hook
In-Reply-To: <20130916120001.GE401@spo001.leaseweb.com>
References: <20130914152032.401907974@gmail.com>
 <20130916071821.GA18210@glitch> <20130916120001.GE401@spo001.leaseweb.com>
Message-ID: <13398230.iOE1HhgZy2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 September 2013 14:00:01 Wim Van Sebroeck wrote:
> 
> I remember that the Cobalt Devices have no ability to reboot themselves.
> That's why the driver uses the reboot_notifier for rebooting the device.
> See drivers/watchdog/alim7101_wdt.c .

Hmm, a notifier seems the wrong approach here, because we really want
to handle all reboot_notifiers before actually rebooting, and we'd enter
the wdt driver at a random point in the notifier chain. It probably works
by chance if the watchdog reboots a second after its notifier is called,
and all other calls are done as well, but it doesn't seem like a clean
solution.

> I'll have a look to have an extra ops that adds this functionality in the framework.

Ok, cool. Thanks!

	Arnd
