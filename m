From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 21 Jun 2017 23:47:53 +0200
Subject: [PATCH 7/9] PM / ACPI: Enable the runtime PM centric approach for
 system sleep
In-Reply-To: <1498072888-14782-8-git-send-email-ulf.hansson@linaro.org>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
 <1498072888-14782-8-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAJZ5v0jL-0TKUv5nK7tFLm+X7nE7J2e3hm21i=+FBFBzQLQ=Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> This change extends the interpretation of the ACPI's no_direct_complete
> flag to be used to enable the so called runtime PM centric approach, for
> devices being attached to the ACPI PM domain.
>
> The principle behind the runtime PM centric approach is to re-use the
> runtime PM callbacks to implement system sleep for drivers/subsystems.
> Moreover, using the runtime PM centric approach gives an optimized
> behaviour around avoiding to wake up a device from its low power state
> during system sleep, unless really needed.
>
> To deploy the runtime PM centric approach for a subsystem/driver, the
> following adaptations needs to be made.
>
> First, the runtime PM callbacks may be called when runtime PM has been
> disabled for the device. This serves as an indication for the callbacks to
> understand they are running in the system sleep sequence, instead of in the
> regular runtime PM path. In some cases, a callback needs to take different
> actions depending in what path it is being executed in, as is the case for
> the ACPI PM domain.
>
> In particular for the ACPI PM domain's ->runtime_suspend|resume()
> callbacks, when those finds runtime PM being disabled for the device, it
> instead executes the same operations as normally being run when
> ->suspend_late() and ->resume_early() callbacks are invoked during system
> sleep.
>
> Second, at the PM domain level, it is expected that the driver for the
> device makes use of pm_runtime_force_suspend|resume(), to re-use the
> runtime PM callbacks to put the device into low power state and to wake it
> up when needed during system sleep.

What if it doesn't do that?

Do all drivers of devices that may fall into the ACPI PM domain use
pm_runtime_force_suspend|resume()?

Thanks,
Rafael
