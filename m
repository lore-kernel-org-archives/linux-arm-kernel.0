From: alex.shi@intel.com (Alex Shi)
Date: Tue, 23 Apr 2013 10:23:26 +0800
Subject: [RFC PATCH v3 5/6] sched: pack the idle load balance
In-Reply-To: <CAKfTPtCCCifC=c+xjjnAH_HSqkR80PiQoddQKXPHuZwZawbvcA@mail.gmail.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-6-git-send-email-vincent.guittot@linaro.org>
 <1364302359.5053.21.camel@laptop>
 <CAKfTPtD=_oS5gJeynUG=ft-Y1zEdxZEMhUPH9hSXx+H2pi4xgA@mail.gmail.com>
 <1364308932.5053.46.camel@laptop>
 <CAKfTPtArtgkH5MU_xFAKjLDS-i32g2qQMdvyW=LLkG84tH8Hhg@mail.gmail.com>
 <5174CE96.3060805@linux.vnet.ibm.com>
 <CAKfTPtCCCifC=c+xjjnAH_HSqkR80PiQoddQKXPHuZwZawbvcA@mail.gmail.com>
Message-ID: <5175F09E.1000304@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks you, Preeti and Vincent to talk the power aware scheduler for
details! believe this open discussion is helpful to conduct a a more
comprehensive solution. :)

> Hi Preeti,
> 
> I have had a look at Alex patches but i have some concerns with his patches
> -There no notion of power domain which is quite important when we speak
> about power saving IMHO. Packing tasks has got an interest if the idle
> CPUs can reach a useful low power state independently from busy CPUs.
> Architectures have different low power state capabilities which must be
> taken into account. In addition, you can have system which have CPUs
> with better power efficiency and this kind of system are not taken into
> account.

I agree with you on this point. and like what's you done to add new flag
in sched domain. It also make scheduler easy pick up new idea in balancing.
BTW, Currently, the my balance is trying pack task per SMT, maybe
packing task per cpu horse power is more compatible for other archs?

> -There are some computation of statistics on a potentially large number
> of cpus and groups at each task wake up. This overhead concerns me and
> such amount of computation should only be done when we have more time
> like the periodic load balance.

Usually, some computation is far slighter then the task migration. If
the computation is helpful to reduce future possible migration, it will
save much. On current code, I observed the fork balancing can distribute
task well in powersaving policy. That means the computation is worth.

> -There are some heuristics that will be hard to tune:
>  *powersaving balance period set as 8*max_interval
>  *power saving can do some performance load balance if there was no
> performance load balance in the last 32 balances with no more than 4
> perf balance in the last 64 balance

Do you have other tunning opinions on the numbers? I am glad to hear any
input.
>  *sched_burst_threshold

I find it is useful on 3.8 kernel when aim7 cause a very imbalance
wakeup. but now aim7 is calm down after lock-stealing RWSEM used in
kernel, maybe need to re-evaluate this on future new version.
> 
> I'm going to send a proposal for a more aggressive and scalable mode of
> my patches which will take care of my concerns. Let see how this new
> patchset can fit with Alex's ones


-- 
Thanks Alex
