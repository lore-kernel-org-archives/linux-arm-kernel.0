From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 29 Aug 2017 13:44:11 +0200
Subject: [PATCH 0/3] PM / ACPI / i2c: Runtime PM aware system sleep
 handling
In-Reply-To: <20170829102927.5lpjkfj2jbtpxadm@sig21.net>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
 <4245176.X6JjkhnUAM@aspire.rjw.lan>
 <20170829102927.5lpjkfj2jbtpxadm@sig21.net>
Message-ID: <CAPDyKFp5dpuUeRjmmSSA3sZzFVwJihmzteyCDzqG33s2Xb1ewA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 August 2017 at 12:29, Johannes Stezenbach <js@sig21.net> wrote:
> Hi,
>
> On Tue, Aug 29, 2017 at 02:18:13AM +0200, Rafael J. Wysocki wrote:
>> On Wednesday, August 23, 2017 4:42:00 PM CEST Ulf Hansson wrote:
>> > The i2c designware platform driver, drivers/i2c/busses/i2c-designware-platdrv.c,
>> > isn't well optimized for system sleep.
>> >
>> > What makes this driver particularly interesting is because it's a cross-SoC
>> > driver, which sometimes means there is an ACPI PM domain attached to the i2c
>> > device and sometimes not. The driver is being used on both x86 and ARM.
> ...
>> Basically, the point is to allow i2c-designware-platdrv to point its late
>> suspend and early resume callbacks, respectively, to pm_runtime_force_suspend()
>> and pm_runtime_force_resume() which then will do the right thing regardless of
>> whether or not the device is runtime suspended when system suspend starts.
>
> I'd like to point out a comment added by Hans de Goede in
> https://bugzilla.kernel.org/show_bug.cgi?id=193891#c99
>
>   The D0 / D3 methods of some devices use ACPI OpRegions on the PMIC which is
>   attached to I2C7, these methods get executed by acpi_dev_suspend_late /
>   acpi_dev_resume_early. Since the i2c-designware driver uses regular suspend /
>   resume callbacks it is already suspended at the time those calls happen,
>   leading to a device-suspend error and the system not suspending at all.

Yes, that's why I moved those operation to be managed at the
->suspend_late() in my series, and at the same time prevent the
direct_complete patch from executed for this device.

>
> It's the reason for the Cherrytrail I2C7 special treatment in
> i2c-designware-platdrv.c and pm_disabled = true in i2c-designware-baytrail.c,
> however pm_disabled seems to be a problem for S0ix support.
> To solve it, i2c-designware-platdrv needs to suspend after all
> devices using ACPI OpRegions for suspend.
>
>
> Johannes

Did you try out my series (v2) if that could fix this problem in a
more flexible manner?

In other words, is it fine if the device remains runtime PM enabled
during the entire device_suspend() phase, and also not being suspended
until ->suspend_late()?

Kind regards
Uffe
