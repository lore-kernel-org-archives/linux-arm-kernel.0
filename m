From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 4 Dec 2017 02:24:41 +0000
Subject: SCPI regressions in v4.15-rc1 on Amlogic SoCs.
In-Reply-To: <9754d389-1dd4-e189-6c8f-c725d049dea8@gmail.com>
References: <CAOi56cXCBAJO6iOONTENqGdm9kE+t4fGYgTENupzkRgHjJfykw@mail.gmail.com>
 <9754d389-1dd4-e189-6c8f-c725d049dea8@gmail.com>
Message-ID: <20171204022441.GB6870@e107533-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 08:08:25AM +0100, Heiner Kallweit wrote:
> Am 01.12.2017 um 01:21 schrieb Kevin Hilman:
> > Hi Sudeep,
> > 
> > There's been a pretty major regression in v4.15-rc1 compared to v4.15
> > in SCPI causing warning splats on amlogic SoCs when cpufreq starts up
> > and tries to set the OPP for the first time[1].
> > 
> Thanks for the report. Strange enough, it works perfectly fine on my
> Odroid-C2, see below log part from latest next kernel.
>

OK, I would like to understand/get the list of AmLogic SoC using SCPI,
so that I get any changes tested on all of them next time. As Kevin
mentioned, it's always safer to just cc the amlogic mailing list. I have
done that in past and failed to observe that this time.

> Your log seems to indicate that due to deferred probing something is
> not done in the right order.
> Can you bisect the issue? I'd assume that it's commit 931cf0c53e69
> ("firmware: arm_scpi: pre-populate dvfs info in scpi_probe").
> 

Yes, even I suspect the same change. But I don't fully understand the issue.

I remember asking you to make some changes in probe path. I think I
wanted you to continue with SCPI probe even if DVFS fails as that causes
issues on platforms that have partial DVFS implemented but other protocols
like clock and sensors working fine.

I guess all platforms with broken SCPI implementation should have it
disabled in the DT instead of taking special care for that in DT.

I assume that's the case even with the platform under regression now.
The correct way to fix it would be to disable DVFS node but it may need
some investigation to narrow down to this comment.

--
Regards,
Sudeep
