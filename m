From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 6 Apr 2018 19:54:02 +0300
Subject: [PATCH 1/5] arm64: entry: isb in el1_irq
In-Reply-To: <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-2-ynorov@caviumnetworks.com>
 <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
Message-ID: <20180406165402.nq3sabeku2mp3hpb@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2018 at 11:02:56AM +0100, James Morse wrote:
> Hi Yury,
> 
> An ISB at the beginning of the vectors? This is odd, taking an IRQ to get in
> here would be a context-synchronization-event too, so the ISB is superfluous.
> 
> The ARM-ARM  has a list of 'Context-Synchronization event's (Glossary on page
> 6480 of DDI0487B.b), paraphrasing:
> * ISB
> * Taking an exception
> * ERET
> * (...loads of debug stuff...)

Hi James, Mark,

I completely forgot that taking an exception is the context synchronization
event. Sorry for your time on reviewing this crap. It means that patches 1,
2 and 3 are not needed except chunk that adds ISB in do_idle() path. 

Also it means that for arm64 we are safe to mask IPI delivering to CPUs that
run any userspace code, not only nohz_full.

In general, kick_all_cpus_sync() is needed to switch contexts. But exit from
userspace is anyway the switch of context. And while in userspace, we cannot
do something wrong on kernel side. For me it means that we can safely drop
IPI for all userspace modes - both normal and nohz_full. 

If it's correct, for v3 I would suggest:
 - in kick_all_cpus_sync() mask all is_idle_task() and user_mode() CPUs;
 - add isb() for arm64 in do_idle() path only - this path doesn't imply
   context switch.

What do you think?

Yury
