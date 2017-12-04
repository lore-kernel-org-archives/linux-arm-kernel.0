From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 4 Dec 2017 02:24:06 +0000
Subject: SCPI regressions in v4.15-rc1 on Amlogic SoCs.
In-Reply-To: <CAOi56cXCBAJO6iOONTENqGdm9kE+t4fGYgTENupzkRgHjJfykw@mail.gmail.com>
References: <CAOi56cXCBAJO6iOONTENqGdm9kE+t4fGYgTENupzkRgHjJfykw@mail.gmail.com>
Message-ID: <20171204022406.GA6870@e107533-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 04:21:13PM -0800, Kevin Hilman wrote:
> Hi Sudeep,
> 
> There's been a pretty major regression in v4.15-rc1 compared to v4.15
> in SCPI causing warning splats on amlogic SoCs when cpufreq starts up
> and tries to set the OPP for the first time[1].
>

Looks like some issue with firmware we are hitting. I assume CPUFreq was
never initialised on this platform before(i.e. v4.14) and these changes
are changing the probe path, so it could be that change causing the
regression.

> I ran out of time to narrow it down further since there have been
> quite a few changes since v4.14, but simply reverting
> drivers/firmware/arm_scpi.c to its v4.14 state gets things working
> again.
>

Makes sense.

> This has been happening for awhile, and we should've caught it sooner
> in kernelCI.org, however this warning splat still allows the kernel to
> finish booting, so it still resulted in a PASS for the boot test.
> That combined with the fact that we've been tracking some other
> regressions, we didn't notice it until now.
>

It's unfortunate that it didn't get tested in linux-next as it was pulled
a while a ago.

> Also, is this the expected result for the pre-1.0 firmware:
>
>     scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
>

I think so, since Amlogic has unreleased/draft version of the specification
implemented, we did discuss to print something similar in the past.

--
Regards,
Sudeep
