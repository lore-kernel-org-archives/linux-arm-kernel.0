From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 22 Jun 2017 01:31:51 +0200
Subject: [PATCH 1/9] i2c: designware: Fix system suspend
In-Reply-To: <1498072888-14782-2-git-send-email-ulf.hansson@linaro.org>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
 <1498072888-14782-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAJZ5v0iYwPE8rpn=aZ9n6LV-qbAK3kynRqVZ7xxuB+gYar_fyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming
> during system suspend"), may suggest to the PM core to try out the so
> called direct_complete path for system sleep. In this path, the PM core
> treats a runtime suspended device as it's already in a proper low power
> state for system sleep, which makes it skip calling the system sleep
> callbacks for the device, except for the ->prepare() and the ->complete()
> callback.
>
> Moreover, under certain circumstances the PM core may unset the
> direct_complete flag for a parent device, in case its child device are
> being system suspended before. In other words, the PM core doesn't skip
> calling the system sleep callbacks, no matter if the device is runtime
> suspended or not.
>
> In cases of an i2c slave device, the above situation is triggered.
> Unfortunate, this also breaks the assumption that the i2c device is always
> runtime resumed, whenever the dw_i2c_plat_suspend() callback is being
> invoked, which then leads to a regression.
>
> More precisely, dw_i2c_plat_suspend() then calls clk_core_disable() and
> clk_core_unprepare(), for an already disabled/unprepared clock, leading to
> complaints about clocks calls being wrongly balanced.
>
> In cases when the i2c device is attached to the ACPI PM domain, the problem
> doesn't occur. That's because ACPI's ->suspend() callback, assigned to
> acpi_subsys_suspend(), calls pm_runtime_resume() for the i2c device.

Which really is expected to happen, so direct_complete should only be
used along with the ACPI PM domain in this case.

Moreover, in the ACPI PM domain case acpi_subsys_prepare() is supposed
to do the right thing without dw_i2c_plat_prepare() and the return
value of the latter will be ignored anyway, so dw_i2c_plat_prepare()
will only have effect without ACPI PM domain AFAICS.

It looks like commit 8503ff166504 is entirely misguided.

Thanks,
Rafael
