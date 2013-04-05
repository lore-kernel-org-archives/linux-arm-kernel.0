From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 21:54:21 +0200
Subject: [PATCH v4 04/14] mfd: Add Samsung PWM/timer master driver
In-Reply-To: <19231120.yHlZtTPUMd@amdc1227>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
 <201304051905.24644.arnd@arndb.de> <19231120.yHlZtTPUMd@amdc1227>
Message-ID: <201304052154.21361.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Tomasz Figa wrote:
> > I don't think anyone ever suggested using a private API though.
> 
> I must have gotten the last paragraph of
> http://article.gmane.org/gmane.linux.kernel.samsung-soc/16638
> wrong then. For me it seemed like the timer driver would expose a private API 
> to the PWM driver.

Yes, sorry I wasn't clear enough. I meant a register-level interface
exposed from the base driver, not a high-level interface like you
did.

> > I think
> > it's ok if the driver lives in drivers/mfd when it doesn't fit anywhere
> > else easily, but you should really register it to the pwm subsystem to
> > expose that functionality, not export functions that can be used by
> > a pwm shim driver, which even seems to be missing from the series.
> 
> Anyway, using PWM API in a clocksource driver that needs to be running very 
> early (before any initcalls get called) seems a bit weird for me, especially 
> when PWM API doesn't provide such fine grained control over PWM timers that is 
> required in the clocksource drivers.

Exactly, that's why you should have a regular PWM driver that gets loaded
at a convenient time and just uses an interface exported by the base driver
to access the common registers.

	Arnd
