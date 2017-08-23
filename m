From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 24 Aug 2017 01:39:44 +0200
Subject: [PATCH v2 5/9] PM / ACPI: Provide option to disable
 direct_complete for ACPI devices
In-Reply-To: <1503499329-28834-6-git-send-email-ulf.hansson@linaro.org>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
 <1503499329-28834-6-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAJZ5v0gJn=SzNFGUT7Zb+CfhQBZ7KNDK2GTSSXGexD8GObjGOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 4:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> In some cases a driver for an ACPI device needs to be able to prevent the
> ACPI PM domain from using the direct_complete path during system sleep.
>
> One typical case is when the driver for the device needs its device to stay
> runtime enabled, during the __device_suspend phase. This isn't the case
> when the direct_complete path is being executed by the PM core, as it then
> disables runtime PM for the device in __device_suspend(). Any following
> attempts to runtime resume the device after that point, just fails.

OK, that is a problem.

> A workaround to this problem is to let the driver runtime resume its device
> from its ->prepare() callback, as that would prevent the direct_complete
> path from being executed. However, that may often be a waste, especially if
> it turned out that no one really needed the device.
>
> For this reason, invent acpi_dev_disable|enable_direct_complete(), to allow
> drivers to inform the ACPI PM domain to change its default behaviour during
> system sleep, and thus control whether it may use the direct_complete path
> or not.

But I'm not sure this is the right place to address it as it very well
may affect a PCI device too.

Also, this is about the device and not about its ACPI companion
object, so putting the flag in there is somewhat unclean, so to speak.

It looks like we need a flag in dev_pm_info saying something along the
lines of "my system suspend callback can deal with runtime PM" that
will cause the direct_complete update to occur in
__device_suspend_late() instead of __device_suspend().

Thanks,
Rafael
