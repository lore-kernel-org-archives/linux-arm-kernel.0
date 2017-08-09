From: john.stultz@linaro.org (John Stultz)
Date: Wed, 9 Aug 2017 13:55:07 -0700
Subject: [PATCH] i2c: designware: Fix system suspend
In-Reply-To: <1502285302-21552-1-git-send-email-ulf.hansson@linaro.org>
References: <1502285302-21552-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CALAqxLW31Huu3+BWUO3tO+bsKUv7_r4_2joBy8YpZfa81zJ5tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 9, 2017 at 6:28 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming
> during system suspend"), may suggest to the PM core to try out the so
> called direct_complete path for system sleep. In this path, the PM core
> treats a runtime suspended device as it's already in a proper low power
> state for system sleep, which makes it skip calling the system sleep
> callbacks for the device, except for the ->prepare() and the ->complete()
> callbacks.
>
> However, the PM core may unset the direct_complete flag for a parent
> device, in case its child device are being system suspended before. In this
> scenario, the PM core invokes the system sleep callbacks, no matter if the
> device is runtime suspended or not.
>
> Particularly in cases of an existing i2c slave device, the above path is
> triggered, which breaks the assumption that the i2c device is always
> runtime resumed whenever the dw_i2c_plat_suspend() is being called.
>
> More precisely, dw_i2c_plat_suspend() calls clk_core_disable() and
> clk_core_unprepare(), for an already disabled/unprepared clock, leading to
> a splat in the log about clocks calls being wrongly balanced and breaking
> system sleep.
>
> To still allow the direct_complete path in cases when it's possible, but
> also to keep the fix simple, let's runtime resume the i2c device in the
> ->suspend() callback, before continuing to put the device into low power
> state.
>
> Note, in cases when the i2c device is attached to the ACPI PM domain, this
> problem doesn't occur, because ACPI's ->suspend() callback, assigned to
> acpi_subsys_suspend(), already calls pm_runtime_resume() for the device.
>
> It should also be noted that this change does not fix commit 8503ff166504
> ("i2c: designware: Avoid unnecessary resuming during system suspend").
> Because for the non-ACPI case, the system sleep support was already broken
> prior that point.
>
> Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> I decided to post this as a separate change, instead of as earlier folding it
> in the series that extends the ACPI PM domain to cope with the runtime PM
> centric path for system sleep.
>
> This change applies on a fresh v4.4+. If someone wants it's applied for earlier
> version, please send a backport yourself.
>
> It's based on 4.13 rc4 and I assume it should go as a fix via the i2c tree.
>
> Changes in v2:
>         - Updated changelog.
>         - Runtime resume the device in ->suspend() instead of in ->prepare().


This avoids the suspend/resume warning I've seen w/o the patch on HiKey.

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
