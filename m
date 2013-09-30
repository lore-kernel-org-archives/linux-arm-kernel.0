From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 30 Sep 2013 16:02:46 +0200
Subject: [PATCH v4 4/4] ARM: bcm4760: Add restart hook
In-Reply-To: <13398230.iOE1HhgZy2@wuerfel>
References: <20130914152032.401907974@gmail.com>
 <20130916071821.GA18210@glitch>
 <20130916120001.GE401@spo001.leaseweb.com>
 <13398230.iOE1HhgZy2@wuerfel>
Message-ID: <20130930140246.GA25992@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

On Mon, Sep 16, 2013 at 10:01:08PM +0200, Arnd Bergmann wrote:
> On Monday 16 September 2013 14:00:01 Wim Van Sebroeck wrote:
> > 
> > I remember that the Cobalt Devices have no ability to reboot themselves.
> > That's why the driver uses the reboot_notifier for rebooting the device.
> > See drivers/watchdog/alim7101_wdt.c .
> 
> Hmm, a notifier seems the wrong approach here, because we really want
> to handle all reboot_notifiers before actually rebooting, and we'd enter
> the wdt driver at a random point in the notifier chain. It probably works
> by chance if the watchdog reboots a second after its notifier is called,
> and all other calls are done as well, but it doesn't seem like a clean
> solution.
> 
> > I'll have a look to have an extra ops that adds this functionality in the framework.

I'd like to do something here.

I'm thinking at a simple "atomic_reset()" wdt op which purpose it to use
the specific watchdog to trigger a HW reset. As the name implies, the call
needs to be callable in atomic context. Any other constrains I'm missing?

At this point a DT attribute in the wdt stanzas could be used to register
the reboot hook at runtime.

thanks,
Domenico
