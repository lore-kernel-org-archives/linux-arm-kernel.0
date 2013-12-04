From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 4 Dec 2013 10:28:24 -0800
Subject: [PATCH v4 1/5] watchdog: davinci: change driver to use WDT core
In-Reply-To: <529F6EBE.5050703@ti.com>
References: <1385556508-3935-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1385556508-3935-2-git-send-email-ivan.khoronzhuk@ti.com>
 <529F6EBE.5050703@ti.com>
Message-ID: <20131204182824.GA14499@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 11:34:46PM +0530, Sekhar Nori wrote:
> On 11/27/2013 6:18 PM, Ivan Khoronzhuk wrote:
> > To reduce code duplicate and increase code readability use WDT core
> > code to handle WDT interface.
> > 
> > Remove io_lock as the WDT core uses mutex to lock each wdt device.
> > Remove wdt_state as the WDT core tracks state with its own variable.
> > 
> > The watchdog_init_timeout() can read timeout value from timeout-sec
> > property if the passed value is out of bounds. The heartbeat is
> > initialized in next way. If heartbeat is not set thought module
> > parameter, try to read it's value from WDT node timeout-sec property.
> > If node has no one, use default value.
> > 
> > The heartbeat is hold in wdd->timeout by WDT core, so use it in
> > order to set timeout period.
> > 
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> > ---
> >  drivers/watchdog/Kconfig       |    2 +
> >  drivers/watchdog/davinci_wdt.c |  147 ++++++++++------------------------------
> >  2 files changed, 37 insertions(+), 112 deletions(-)
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 5be6e91..eb8c89d 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -271,6 +271,8 @@ config IOP_WATCHDOG
> >  config DAVINCI_WATCHDOG
> >  	tristate "DaVinci watchdog"
> >  	depends on ARCH_DAVINCI
> > +	select WATCHDOG_CORE
> > +	select WATCHDOG_NOWAYOUT
> 
> Its not clear for change log why NOWAYOUT needs to be forced on all the
> time for all users of DaVinci watchdog.
> 
Actually, thinking about it, it is not necessary and can be replaced with

	watchdog_set_nowayout(wdd, 1);

In other words, there is no need to force NOWAYOUT on _other_ watchdogs which
may be present in the system. Still, you are right, it would be nice to explain
in the changelog (or maybe even better as comment in the code) why it is
enforced.

Guenter
