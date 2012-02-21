From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Tue, 21 Feb 2012 13:56:22 +0100
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <69B0D95C-2A80-41A9-97E1-86F5840B84CF@antoniou-consulting.com>
References: <20120208013959.GA24535@panacea>
 <1328670355.2482.68.camel@laptop> <20120208202314.GA28290@redhat.com>
 <1328736834.2903.33.camel@pasglop> <20120209075106.GB18387@elte.hu>
 <4F35DD3E.4020406@codeaurora.org> <20120211144530.GA497@elte.hu>
 <4F3AEC4E.9000303@codeaurora.org> <1329313085.2293.106.camel@twins>
 <20120215140245.GB27825@n2100.arm.linux.org.uk>
 <1329318063.2293.136.camel@twins>
 <69B0D95C-2A80-41A9-97E1-86F5840B84CF@antoniou-consulting.com>
Message-ID: <1329828982.2293.405.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-02-21 at 14:38 +0200, Pantelis Antoniou wrote:
> 
> If we go to all the trouble of integrating cpufreq/cpuidle/sched into scheduler
> callbacks, we should place hooks into the thermal framework/PM as well.
> 
> It will pretty common to have per core temperature readings, on most
> modern SoCs. 
> 
> It is quite conceivable to have a case with a multi-core CPU where due
> to load imbalance, one (or more) of the cores is running at full speed
> while the rest are mostly idle. What you want do, for best performance
> and conceivably better power consumption, is not to throttle either 
> frequency or lowers voltage to the overloaded CPU but to migrate the
> load to one of the cooler CPUs.
> 
> This affects CPU capacity immediately, i.e. you shouldn't schedule more
> load on a CPU that its too hot, since you'll only end up triggering thermal 
> shutdown. The ideal solution would be to round robin
> the load from the hot CPU to the cooler ones, but not so fast that we lose
> due to the migration of state from one CPU to the other.
> 
> In a nutshell, the processing capacity of a core is not static, i.e. it
> might degrade over time due to the increase of temperature caused by the
> previous load.
> 
> What do you think? 

This is called core-hopping, and yes that's a nice goal, although I
would like to do that after we get the 'simple' bits up and running. I
suspect it'll end up being slightly more complex than we'd like to due
to the fact that the goal conflicts with wanting to aggregate things on
cpu0 due to cpu0 being special for a host of reasons.
