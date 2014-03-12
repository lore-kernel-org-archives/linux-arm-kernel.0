From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Wed, 12 Mar 2014 13:28:07 +0000
Subject: [RFC 0/6] rework sched_domain topology description
In-Reply-To: <20140311131719.GY9987@twins.programming.kicks-ass.net>
References: <1394003906-11630-1-git-send-email-vincent.guittot@linaro.org>
 <5317B092.7070805@arm.com>
 <CAKfTPtDGbT717Y5F1GoBgr4pnvApG5Gphu2Me_bAFrM0+qsfAg@mail.gmail.com>
 <53186A8A.9060406@arm.com>
 <CAKfTPtCspVk+X3O23ikTt3MZUHVrrp21PyhmrcLF-GwW3OjOqA@mail.gmail.com>
 <531B0FDA.2040302@arm.com>
 <20140311131719.GY9987@twins.programming.kicks-ass.net>
Message-ID: <532060E7.7010203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/14 13:17, Peter Zijlstra wrote:
> On Sat, Mar 08, 2014 at 12:40:58PM +0000, Dietmar Eggemann wrote:
>>>
>>> I don't have a strong opinion about using or not a cpu argument for
>>> setting the flags of a level (it was part of the initial proposal
>>> before we start to completely rework the build of sched_domain)
>>> Nevertheless, I see one potential concern that you can have completely
>>> different flags configuration of the same sd level of 2 cpus.
>>
>> Could you elaborate a little bit further regarding the last sentence? Do you
>> think that those completely different flags configuration would make it
>> impossible, that the load-balance code could work at all at this sd?
> 
> So a problem with such an interfaces is that is makes it far too easy to
> generate completely broken domains.

I see the point. What I'm still struggling with is to understand why
this interface is worse then the one where we set-up additional,
adjacent sd levels with new cpu_foo_mask functions plus different static
sd-flags configurations and rely on the sd degenerate functionality in
the core scheduler to fold these levels together to achieve different
per cpu sd flags configurations.

IMHO, exposing struct sched_domain_topology_level bar_topology[] to the
arch is the reason why the core scheduler has to check if the arch
provides a sane sd setup in both cases.

> 
> You can, for two cpus in the same domain provide, different flags; such
> a configuration doesn't make any sense at all.
> 
> Now I see why people would like to have this; but unless we can make it
> robust I'd be very hesitant to go this route.
> 

By making it robust, I guess you mean that the core scheduler has to
check that the provided set-ups are sane, something like the following
code snippet in sd_init()

if (WARN_ONCE(tl->sd_flags & ~TOPOLOGY_SD_FLAGS,
		"wrong sd_flags in topology description\n"))
	tl->sd_flags &= ~TOPOLOGY_SD_FLAGS;

but for per cpu set-up's.
Obviously, this check has to be in sync with the usage of these flags in
the core scheduler algorithms. This comprises probably that a subset of
these topology sd flags has to be set for all cpus in a sd level whereas
other can be set only for some cpus.

> 
> 
