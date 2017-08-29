From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 29 Aug 2017 16:49:12 +0200
Subject: [PATCH 0/3] PM / ACPI / i2c: Runtime PM aware system sleep
 handling
In-Reply-To: <20170829102927.5lpjkfj2jbtpxadm@sig21.net>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
 <4245176.X6JjkhnUAM@aspire.rjw.lan>
 <20170829102927.5lpjkfj2jbtpxadm@sig21.net>
Message-ID: <2534922.secN4LtMtD@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 29, 2017 12:29:27 PM CEST Johannes Stezenbach wrote:
> Hi,
> 
> On Tue, Aug 29, 2017 at 02:18:13AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, August 23, 2017 4:42:00 PM CEST Ulf Hansson wrote:
> > > The i2c designware platform driver, drivers/i2c/busses/i2c-designware-platdrv.c,
> > > isn't well optimized for system sleep.
> > > 
> > > What makes this driver particularly interesting is because it's a cross-SoC
> > > driver, which sometimes means there is an ACPI PM domain attached to the i2c
> > > device and sometimes not. The driver is being used on both x86 and ARM.
> ...
> > Basically, the point is to allow i2c-designware-platdrv to point its late
> > suspend and early resume callbacks, respectively, to pm_runtime_force_suspend()
> > and pm_runtime_force_resume() which then will do the right thing regardless of
> > whether or not the device is runtime suspended when system suspend starts.
> 
> I'd like to point out a comment added by Hans de Goede in
> https://bugzilla.kernel.org/show_bug.cgi?id=193891#c99
> 
>   The D0 / D3 methods of some devices use ACPI OpRegions on the PMIC which is
>   attached to I2C7, these methods get executed by acpi_dev_suspend_late /
>   acpi_dev_resume_early. Since the i2c-designware driver uses regular suspend /
>   resume callbacks it is already suspended at the time those calls happen,
>   leading to a device-suspend error and the system not suspending at all.
> 
> It's the reason for the Cherrytrail I2C7 special treatment in
> i2c-designware-platdrv.c and pm_disabled = true in i2c-designware-baytrail.c,
> however pm_disabled seems to be a problem for S0ix support.
> To solve it, i2c-designware-platdrv needs to suspend after all
> devices using ACPI OpRegions for suspend.

That's a totally different issue from the one at hand.

It simply means that the devices using I2C for suspend/resume need to be
suspended *before* the I2C controller and resumed *after* it.

So this is a system suspend/resume *ordering* issue and not a runtime PM
vs system suspend issue.

It can be addressed, for example, by doing the I2C controller's
suspend/resume at the noirq stage.  Has anyone tried that?

Thanks,
Rafael
