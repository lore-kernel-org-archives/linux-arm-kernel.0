From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Dec 2014 15:38:30 +0100
Subject: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <54903DC6.8010308@linaro.org>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
 <2519415.GklIQeMgWR@wuerfel> <54903DC6.8010308@linaro.org>
Message-ID: <2663853.2Q3kHisMT7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 December 2014 15:12:22 Daniel Lezcano wrote:
> At the beginning, all that become from not including mach files from the 
> drivers directory which make sense.
> 
> Perhaps it is time to write a similar mechanism for the cpuidle drivers 
> where we can still separate the low level PM code from the generic 
> cpuidle code.

That way you basically duplicate the same thing we already have, which
isn't much better.

In the example of drivers/soc/qcom/spm.c, just call cpuidle_register
from the spm_dev_probe() function and be done with it. You already
have a device that is responsible for handling this, don't try to
construct more than you already need.

I would assume that the same can be done for most other platforms.

There are probably cases where the same piece of hardware is responsible
for both cpuidle and cpufreq, but what that means is really that you
should have a single driver for it that does both things. Same for
SMP support: if you have one register block that does both the SMP
bringup and the cpuidle stuff, then have *one* driver for this block
that does it all. There are currently a few dependencies that require
doing SMP bringup early during boot, but we decided years ago that those
are all artificial dependencies and we should be able to boot secondary
CPUs much later than we currently do.

	Arnd
