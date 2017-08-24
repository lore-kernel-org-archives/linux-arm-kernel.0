From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 24 Aug 2017 10:19:43 +0200
Subject: [PATCH v2 5/9] PM / ACPI: Provide option to disable
 direct_complete for ACPI devices
In-Reply-To: <CAJZ5v0gJn=SzNFGUT7Zb+CfhQBZ7KNDK2GTSSXGexD8GObjGOw@mail.gmail.com>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
 <1503499329-28834-6-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0gJn=SzNFGUT7Zb+CfhQBZ7KNDK2GTSSXGexD8GObjGOw@mail.gmail.com>
Message-ID: <CAPDyKFrGvqhBdenSyQ8Qr76DbfEvc74_dKZAjraA5qL63Mm2rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2017 at 01:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Aug 23, 2017 at 4:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> In some cases a driver for an ACPI device needs to be able to prevent the
>> ACPI PM domain from using the direct_complete path during system sleep.
>>
>> One typical case is when the driver for the device needs its device to stay
>> runtime enabled, during the __device_suspend phase. This isn't the case
>> when the direct_complete path is being executed by the PM core, as it then
>> disables runtime PM for the device in __device_suspend(). Any following
>> attempts to runtime resume the device after that point, just fails.
>
> OK, that is a problem.
>
>> A workaround to this problem is to let the driver runtime resume its device
>> from its ->prepare() callback, as that would prevent the direct_complete
>> path from being executed. However, that may often be a waste, especially if
>> it turned out that no one really needed the device.
>>
>> For this reason, invent acpi_dev_disable|enable_direct_complete(), to allow
>> drivers to inform the ACPI PM domain to change its default behaviour during
>> system sleep, and thus control whether it may use the direct_complete path
>> or not.
>
> But I'm not sure this is the right place to address it as it very well
> may affect a PCI device too.
>
> Also, this is about the device and not about its ACPI companion
> object, so putting the flag in there is somewhat unclean, so to speak.
>
> It looks like we need a flag in dev_pm_info saying something along the
> lines of "my system suspend callback can deal with runtime PM" that
> will cause the direct_complete update to occur in
> __device_suspend_late() instead of __device_suspend().

I realize that in the end this turns out to be a comparison between
the runtime PM centric path and the direct_complete path while
implementing system sleep. In patch 9, there is some more explanation
around this, however if you like I can elaborate even more about
this!?

Regarding making changes to the PM core and adding more flags to the
dev_pm_info etc, I am not sure we really want that. Isn't it already
complex enough?

My point is, that I am trying to improve the behavior of the ACPI PM
domain by enabling the runtime PM centric path for it, and even if
there is something similar that could be done for PCI, I don't think
we should need involvement by the PM core.

Kind regards
Uffe
