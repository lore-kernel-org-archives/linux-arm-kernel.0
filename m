From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 7 Feb 2014 07:40:45 -0300
Subject: [PATCH v6 05/19] watchdog: orion: Make sure the watchdog is
 initially stopped
In-Reply-To: <52F43ED0.4050808@roeck-us.net>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1391707226-18258-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <52F43ED0.4050808@roeck-us.net>
Message-ID: <20140207104044.GA11063@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 06:02:56PM -0800, Guenter Roeck wrote:
> On 02/06/2014 09:20 AM, Ezequiel Garcia wrote:
> > Having the watchdog initially fully stopped is important to avoid
> > any spurious watchdog triggers, in case the registers are not in
> > its reset state.
> >
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Tested-by: Willy Tarreau <w@1wt.eu>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >   drivers/watchdog/orion_wdt.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> > index 6746033..2dbeee9 100644
> > --- a/drivers/watchdog/orion_wdt.c
> > +++ b/drivers/watchdog/orion_wdt.c
> > @@ -142,6 +142,9 @@ static int orion_wdt_probe(struct platform_device *pdev)
> >   	orion_wdt.max_timeout = wdt_max_duration;
> >   	watchdog_init_timeout(&orion_wdt, heartbeat, &pdev->dev);
> >
> > +	/* Let's make sure the watchdog is fully stopped */
> > +	orion_wdt_stop(&orion_wdt);
> > +
> 
> Actually we just had that in another driver, and I stumbled over it there.
> 
> Problem with stopping the watchdog in probe unconditionally is that you can
> use it to defeat nowayout: unload the module, then load it again,
> and the watchdog is stopped even if nowayout is true.
> 

Hm... I see.

> Is this really what you want ? Or, in other words, what is the problem
> you are trying to solve ?
> 

Well, this is related to the discussion about the bootloader not
reseting the watchdog properly, provoking spurious watchdog triggering.

Jason Gunthorpe explained [1] that we needed a particular sequence:

 1. Disable WDT
 2. Clear bridge
 3. Enable WDT

We added the irq handling to satisfy (2), and the watchdog stop for (1).

The watchdog stop was agreed specifically [2].

Ideas?

[1] http://www.spinics.net/lists/arm-kernel/msg302340.html
[2] http://www.spinics.net/lists/arm-kernel/msg302507.html

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
