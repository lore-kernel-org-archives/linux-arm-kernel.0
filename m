From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 8 Aug 2014 14:26:22 -0400 (EDT)
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <7h4mxm3l5k.fsf@paris.lan>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
 <53DB6B4F.9080605@arm.com> <1406890899.2794.40.camel@linaro1.home>
 <CAOesGMi0RUbz4BSnmR92dEk3fWgN=hnENSdi55VeCXdcHLRLJQ@mail.gmail.com>
 <53DB763A.10306@arm.com> <1406892491.2794.58.camel@linaro1.home>
 <53DBAAEA.2010908@arm.com> <1406908399.22757.12.camel@linaro1.home>
 <20140803032047.GB14214@quad.lixom.net> <7h4mxm3l5k.fsf@paris.lan>
Message-ID: <alpine.LFD.2.11.1408081418390.6061@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Aug 2014, Kevin Hilman wrote:

> Olof Johansson <olof@lixom.net> writes:
> 
> > On Fri, Aug 01, 2014 at 04:53:19PM +0100, Jon Medhurst (Tixy) wrote:
> >> On Fri, 2014-08-01 at 15:57 +0100, Sudeep Holla wrote:
> >> > 
> >> > On 01/08/14 12:28, Jon Medhurst (Tixy) wrote:
> >> > > On Fri, 2014-08-01 at 12:12 +0100, Sudeep Holla wrote:
> >> > >>
> >> > >> On 01/08/14 12:03, Olof Johansson wrote:
> >> > >>> On Fri, Aug 1, 2014 at 4:01 AM, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> >> > >>>> On Fri, 2014-08-01 at 11:26 +0100, Sudeep Holla wrote:
> >> > 
> >> > [...]
> >> > 
> >> > >>>>
> >> > >>>>>    One way to achieve this:
> >> > >>>>> (There's sysfs to re-enable it runtime)
> >> > >>>>
> >> > >>>> The opposite is also true, if you don't want the switcher enabled you
> >> > >>>> can disable it by the same method after boot ;-)
> >> > >>>>
> >> > >>>>> -->8
> >> > >>>>> diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> >> > >>>>> index 490f3dced749..f4c36e70166a 100644
> >> > >>>>> --- a/arch/arm/common/bL_switcher.c
> >> > >>>>> +++ b/arch/arm/common/bL_switcher.c
> >> > >>>>> @@ -794,7 +794,7 @@ static int bL_switcher_hotplug_callback(struct
> >> > >>>>> notifier_block *nfb,
> >> > >>>>>            return NOTIFY_DONE;
> >> > >>>>>     }
> >> > >>>>>
> >> > >>>>> -static bool no_bL_switcher;
> >> > >>>>> +static bool no_bL_switcher = true;
> >> > >>>>
> >> > >>>> This changes the default for everyone, which I guess is fair enough if
> >> > >>>> there is a good reason, but I'm not sure there is.
> >> > >>>
> >> > >>> No, I don't think there is.
> >> > >>>
> >> > >>
> >> > >> It's just that people using TC2 will suddenly see 3 of the 5 CPUs missing.
> >> > >
> >> > > Yes, if they we're previously using multi_v7_defconfig (do people
> >> > > working specifically with TC2's use that?)
> >> > >
> >> > 
> >> > I don't, but assumed many might use it.
> >> > 
> >> > > Conversely, with the change in default proposed above, anyone with their
> >> > > own configs enabling the switcher will suddenly see the number of CPUs
> >> > > go from 2 to 5. We also have the situation where we have a config
> >> > > option, which when enabled, doesn't actually do anything unless the user
> >> > > also changes boot arguments or takes measures to enable it after boot.
> >> > > Which seems the wrong way for things to work to me.
> >> > >
> >> > 
> >> > OK, makes sense. Just curious how many big.LITTLE platforms have CPUFreq
> >> > support and integrated with bL switcher. Otherwise we end up switching
> >> > clusters/cpus using dummy i/f anyways
> >> 
> >> Hmm, that is a point, there are 3 other big.LITTLE SoC's I can spot in
> >> mainline [1], and I wouldn't want to speculate how they would be
> >> affected by having the big.LITTLE switcher enabled.
> >> 
> >> [1] exynos5420, exynos5260, r8a7790
> >
> > 5422/5800 is a fourth SoC, but it's nearly identical to 5420 with a few
> > bugfixes.
> >
> > At the end of the day, b.L switcher has predictable user behavior, while
> > running with assymetric SMP does not. 
> 
> What is unpredictable?  Perhaps sub-optimal, but I don't see what's any
> more unpreditable about it than normal SMP.

CPUs not being equal, your overall performance will be randomized 
depending on which CPU a given task ends up being scheduled on.  And in 
turn this is going to skew scheduler profiling and statistics gathering 
for that task if it is migrated around.  Some performance critical tasks 
might never get the boost from a big CPU while other tasks will 
needlessly drain your battery by not being run on a small CPU.  People 
will complain and the squirrel across the street will steal your SD 
cards, etc.

> > Until the scheduler work has been done,
> > it is significantly better to enable the switcher instead of SMP on these
> > platforms.
> >
> > Once the scheduler work has come further, we can switch over. But not until
> > then.
> 
> I think the upstream defconfigs should facilitate the broader testing of
> the scheduler work by having the swticher disabled.
> 
> By enabling the switcher (and the corresponding cpufreq switcher driver)
> by default, we're now actually making one more obstacle for broader
> testing of the generic scheduling on all cores.

The generic scheduler currently has nothing really worth testing by the 
wider  audience.  Be assured that when it does then the switcher will 
indeed default to off.


Nicolas
