From: khilman@ti.com (Kevin Hilman)
Date: Fri, 22 Jul 2011 13:14:05 -0700
Subject: [PATCH 1/2] OMAP3+: PM: SR: use put_sync_suspend for disabling
In-Reply-To: <1311314153-23531-2-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 22 Jul 2011 00:55:52 -0500")
References: <1311314153-23531-1-git-send-email-nm@ti.com>
	<1311314153-23531-2-git-send-email-nm@ti.com>
Message-ID: <877h7a13aq.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> From: Colin Cross <ccross@google.com>
>
> omap_sr_disable_reset_volt is called with irqs off in omapx_enter_sleep,
> as part of idle sequence, this eventually calls sr_disable and
> pm_runtime_put_sync. pm_runtime_put_sync calls rpm_idle, which will
> enable interrupts in order to call the callback. In this short interval
> when interrupts are enabled, scenarios such as the following can occur:
> while interrupts are enabled, the timer interrupt that is supposed to
> wake the device out of idle occurs and is acked, so when the CPU finally
> goes to off, the timer is already gone, missing a wakeup event.
>
> Further, as the documentation for runtime states:"
>  However, subsystems can use the pm_runtime_irq_safe() helper function
>  to tell the PM core that a device's ->runtime_suspend() and ->runtime_resume()
>  callbacks should be invoked in atomic context with interrupts disabled
>  (->runtime_idle() is still invoked the default way)."
>
> Hence, replace pm_runtime_put_sync with pm_runtime_put_sync_suspend
> to invoke the suspend handler and shut off the fclk for SmartReflex
> module instead of using the idle handler in interrupt disabled context.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Colin Cross <ccross@google.com>

Great catch!

Looking through Documentation/power/runtime_pm.txt, I see (now) that it
is well documented that _put_sync_suspend() is safe to use from
interrupts-disabled context, but _put_sync() is not on that list.

Queuing this as a fix for v3.1.

Kevin
