From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 19 Jun 2013 08:51:00 -0700
Subject: [PATCH] watchdog: delete mpcore_wdt driver
In-Reply-To: <4b48e037462c7d74452618e631f6cf077b7ce5de.1371654384.git.viresh.kumar@linaro.org>
References: <4b48e037462c7d74452618e631f6cf077b7ce5de.1371654384.git.viresh.kumar@linaro.org>
Message-ID: <20130619155100.GB29516@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 08:38:58PM +0530, Viresh Kumar wrote:
> The only way this is usable is if a watchdog user binds to a particular CPU
> before opening this device, and remains bound to that user. But this doesn't fit
> the current watchdog model in linux.
> 
Side note: not really true. The application can run on any CPU. The driver would
call on_each_cpu_mask() to execute the ping on the correct/expected CPU, or
on_each_cpu() if each CPU needs a ping. So this is more a matter of driver coding.

> Interrupt request doesn't use the right API: The TWD watchdog uses a per-cpu
> interrupt (usually interrupt #30), and the GIC configuration should flag it as
> such. With this setup, request_irq() should fail, and the right API is
> request_percpu_irq(), together with enable_percpu_irq()/disable_percpu_irq().
> 
> Nothing ensures the userspace ioctl() will end-up kicking the watchdog on the
> right CPU.
> 
> There are no users of this driver since a long time and it makes more sense to
> get rid of it as nobody is looking to fix it.
> 
> In case somebody wakes up after this has been removed and needs it, please
> revert this driver and pick these updates (These were never pushed to mainline):
> 
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/245998
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>
