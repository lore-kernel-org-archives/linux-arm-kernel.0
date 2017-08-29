From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 29 Aug 2017 22:19:43 +0200
Subject: [PATCH v3 0/8] PM / ACPI / i2c: Deploy runtime PM centric path
 for system sleep
In-Reply-To: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1957183.ZU1CWrAZoR@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 29, 2017 4:56:42 PM CEST Ulf Hansson wrote:
> The i2c designware platform driver, drivers/i2c/busses/i2c-designware-platdrv.c,
> isn't well optimized for system sleep.
> 
> What makes this driver particularly interesting is because it's a cross-SoC
> driver, which sometimes means there is an ACPI PM domain attached to the i2c
> device and sometimes not. The driver is being used on both x86 and ARM.
> 
> In principle, to optimize the system sleep support in i2c driver, this series
> enables the proven runtime PM centric path for the i2c driver. However, to do
> that the ACPI PM domain also have to collaborate and understand this behaviour.
> From earlier versions, Rafael has also pointed out that also the PM core needs
> to be involved.

Earlier today I realized that drivers pointing their ->suspend_late and
->resume_early callbacks, respectively, to pm_runtime_force_suspend() and
pm_runtime_force_resume(), are fundamentally incompatible with any bus type
doing nontrivial PM and with almost any nontrivial PM domains, for two reasons.

First, it basically requires the bus type or PM domain to expect that its
->runtime_suspend callback may or may not be indirectly invoked from its
own ->suspend_late callback, depending on the driver (and analogously
for ->runtime_resume and ->resume early), which is insane.

Second, it is a layering violation, because it makes the driver effectively
override the upper layer's decisions about what code to run.

That's why I'm afraid that we've reached a dead end here. :-(

Thanks,
Rafael
