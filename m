From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Sep 2012 16:24:12 +0100
Subject: [PATCH V2] spi/pl022: Simplify use of runtime pm
In-Reply-To: <1348758396-25276-1-git-send-email-ulf.hansson@stericsson.com>
References: <1348758396-25276-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20120927152412.GA3379@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 05:06:36PM +0200, Ulf Hansson wrote:
> In probe the pm_runtime_resume is not needed since the amba bus
> has already set the device in "resumed" state by using
> pm_runtime_set_active.
> 
> Additionally more simplifications is done in probe by removing
> pm_runtime_put_autosuspend. pm_runtime_put_autosuspend does in
> probe functions have same effect as doing pm_runtime_put. This
> due to upper layer in driver core is preventing the device from
> being runtime suspended by a pm_runtime_get*.
> 
> Finally, removing pm_runtime_disable from the remove function
> can be done since it is already handled by the amba bus.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

What's the bloody point?

Here:

commit 92b97f0aaccbf9de4a29696e6253bf82e8850d1d
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sun Aug 14 09:13:48 2011 +0100

    PM: add runtime PM support to core Primecell driver
    
    Add runtime PM support to the core Primecell driver, following the PCI
    model of how this is done.
    
    Rather than having every driver fiddle about with enabling runtime PM,
    that's dealt with in the core and instead, drivers just do a put() in
    their probe and a balancing get() in their remove function to activate
    runtime PM for the device.
    
    As we're dealing with enabling runtime PM in the core, fix up spi-pl022
    as it must not enable and disable runtime PM itself anymore.
    
    Tested-by: Linus Walleij <linus.walleij@linaro.org>
    Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I added runtime PM support to the core primecell driver.  The SPI PL022
driver already had it, so I fixed it up correctly at that time.  That
was, to ensure that it had a call to pm_runtime_put() at the end of
its probe function, and pm_runtime_get_noresume() at the beginning of
its remove function - and checked that there were appropraite calls
elsewhere.

Then:

commit 53e4acea0e819a6a8513e10a0773f2259ede0481
Author: Chris Blair <chris.blair@stericsson.com>
Date:   Tue Nov 8 08:54:46 2011 +0000

    spi/pl022: add support for pm_runtime autosuspend
    
    Adds support for configuring the spi bus to use autosuspend for
    runtime power management. This can reduce the latency in starting an
    spi transfer by not suspending the device immediately following
    completion of a transfer. If another transfer then takes place before
    the autosuspend timeout, the call to resume the device can return
    immediately rather than needing to risk sleeping in order to resume
    the device.
    
    Reviewed-by: Viresh Kumar <viresh.kumar@st.com>
    Signed-off-by: Chris Blair <chris.blair@stericsson.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

added support for autosuspend to this.  That change looks fine.

Then we get to:

commit 2fb30d1147c599f5657e8c62c862f9a0f58d9d99
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Tue Jun 12 16:14:51 2012 +0200

    spi/pl022: enable runtime PM
    
    If we're gonna use runtime PM it's a pretty good idea to actually
    enable it in probe() and disable it in remove() too, so it
    gets used for real. Up until now we only fooled around with the
    reference count.
    
    Cc: Vinit Shenoy <vinit.shenoy@st.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

which is total bollocks whatever way you look at it, and undoes my
changes when I moved this stuff into the bus layer (like PCI does.)
This then sparked another "fix":

commit 6887237cd7da904184dab2750504040c68f3a080
Author: Michel JAOUEN <michel.jaouen@stericsson.com>
Date:   Fri Aug 17 17:28:41 2012 +0200

    spi/pl022: fix spi-pl022 pm enable at probe
    
    amba drivers does not need to enable pm runtime at probe.
    amba_probe already enables pm runtime.
    
    This rids this warning in the ux500 boot log:
    ssp-pl022 ssp0: Unbalanced pm_runtime_enable!
    
    Signed-off-by: Michel JAOUEN <michel.jaouen@stericsson.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

because of the now crapped up runtime PM initialization.

Really, Linus, what are you thinking?

Both 6887237cd7da904184dab2750504040c68f3a080 and 2fb30d1147c599f5657e8c62c862f9a0f58d9d99
need reverting.  Once that's done, I suggest Ulf then builds upon a sane
base instead of the crappy base we have today.
