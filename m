From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Dec 2015 11:02:47 +0000
Subject: [PATCH] clocksource: arm_global_timer: Allow DT to specify
 already reset timer counter
In-Reply-To: <56728B87.8030409@linaro.org>
References: <1448429044-10395-1-git-send-email-jaswinder.singh@linaro.org>
 <5670559A.4050404@linaro.org>
 <CABb+yY0_JvVV_HG_iU8KJjmwu-nq_Cu5hJ6HBoKZCrZAdJ=rLQ@mail.gmail.com>
 <56710BD6.2090502@linaro.org>
 <CAJe_Zher2N-jFOBiA-25u0fQv_mdps+_Y4FoFdjiw9E++87TLg@mail.gmail.com>
 <56728B87.8030409@linaro.org>
Message-ID: <20151217110247.GB13389@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 11:16:39AM +0100, Daniel Lezcano wrote:
> On 12/17/2015 10:37 AM, Jassi Brar wrote:
> >On 16 December 2015 at 12:29, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>On 12/16/2015 05:11 AM, Jassi Brar wrote:
> >>>
> >>>On Tue, Dec 15, 2015 at 11:32 PM, Daniel Lezcano
> >>><daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>>On 11/25/2015 06:24 AM, Jassi Brar wrote:
> >>>>>
> >>>>>
> >>>>>The GT counter is common to every core in a cluster. There is a usecase
> >>>>>when Linux is spawned by a 'master' firmware/OS running on some core of
> >>>>>the same cluster and the GT is used by the both.
> >>>>>    Linux, upon boot, resetting the GT counter is obviously fatal to the
> >>>>>other OS. So provide a way for DT to tell Linux if it's running in that
> >>>>>'slave' mode and must not reset the counter.
> >>>>>
> >>>>>Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> >>>>
> >>>>
> >>>>
> >>>>Hmm, I doubt that is a hardware description.
> >>>>
> >>>Its a regular 2core-1cluster platform. The master RTOS on cpu0
> >>>maintains the lifecycle of Linux on cpu1.
> >>>
> >>>'No_Counter_Reset' is not a h/w thing, I agree, but I don't know how
> >>>to better convey that platform specific constraint.
> >>
> >>
> >>May be with a kernel parameter ?
> >>
> >The fact, that arch-timer driver does it via DT (see commit
> >65b5732d241b8), changes anything? :)
> 
> It is debatable (cc'ed Rob).
> 
> I acked it because the patch was on the edge between soft/hw in the
> description. But now it sounds like that created a precedence and we
> consider these DT options exceptions as acceptable.

While not strictly a HW property, it is a property of the system,
outside of the control of Linux. It's fine to place such things in the
DT when required.

I don't think it makes sense to have to use kernel commadn line
parameters for this.

> I don't know if there is a better way than a kernel parameter but
> IMO it makes sense to pass this kind of options via the kernel
> command line as we can extend it easily for more options in the
> future.
> 
> Furthermore, I suspect this feature may be needed for other
> arch/plat. So having a generic option could be useful for future
> changes.
> 
> Thomas, do you have an opinion ?
> 
> Can we consider adding a set of kernel parameters instead of adding
> DT exceptions time to time ?
> 
> eg.
> 
> clocksource.reset = <0/1>
> clocksource.virtual = <0/1>

I don't think you can have generic optins for this. What exactly you
need will depend on the specific clocksource and set of other agents
using it. Generic options won't adequately capture those details.

Thanks,
Mark.
