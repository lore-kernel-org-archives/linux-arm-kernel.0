From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 05 Apr 2013 19:35:41 +0200
Subject: [PATCH v4 04/14] mfd: Add Samsung PWM/timer master driver
In-Reply-To: <201304051905.24644.arnd@arndb.de>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
 <5507947.WEhmSUi7vd@amdc1227> <201304051905.24644.arnd@arndb.de>
Message-ID: <19231120.yHlZtTPUMd@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 of April 2013 19:05:24 Arnd Bergmann wrote:
> On Friday 05 April 2013, Tomasz Figa wrote:
> > On Friday 05 of April 2013 18:39:58 Samuel Ortiz wrote:
> > > Hi Tomasz,
> > > 
> > > On Thu, Apr 04, 2013 at 06:37:01PM +0200, Tomasz Figa wrote:
> > > > This patch adds master driver for PWM/timer block available on many
> > > > Samsung SoCs providing clocksource and PWM output capabilities.
> > > 
> > > Why is that an MFD driver, and why aren't you using the PWM APIs for it
> > > ?
> > > Also, you probably want to look at using the regmap APIs for your IO.
> > 
> > The case of Samsung PWM timers is rather complicated. It is a hardware
> > block that can be used at the same time to generate PWM signal and as a
> > system clocksource.
> > 
> > There was a discussion on how to solve the problem of sharing the
> > hardware:
> > http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16480/focus=16500
> > (see the linked post and replies to it).
> 
> I don't think anyone ever suggested using a private API though.

I must have gotten the last paragraph of
http://article.gmane.org/gmane.linux.kernel.samsung-soc/16638
wrong then. For me it seemed like the timer driver would expose a private API 
to the PWM driver.

> I think
> it's ok if the driver lives in drivers/mfd when it doesn't fit anywhere
> else easily, but you should really register it to the pwm subsystem to
> expose that functionality, not export functions that can be used by
> a pwm shim driver, which even seems to be missing from the series.

Anyway, using PWM API in a clocksource driver that needs to be running very 
early (before any initcalls get called) seems a bit weird for me, especially 
when PWM API doesn't provide such fine grained control over PWM timers that is 
required in the clocksource drivers.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Kernel and System Framework
