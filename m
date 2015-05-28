From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 28 May 2015 10:03:01 +0300
Subject: [GIT PULL 4/8] clk: tegra: Changes for v4.2-rc1
In-Reply-To: <20150527195021.GA24204@codeaurora.org>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
 <1431524980-13599-5-git-send-email-thierry.reding@gmail.com>
 <20150520195459.GU31753@codeaurora.org> <555D7A5B.1070901@nvidia.com>
 <20150527195021.GA24204@codeaurora.org>
Message-ID: <5566BDA5.5080104@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2015 10:50 PM, Stephen Boyd wrote:
> On 05/21, Mikko Perttunen wrote:
>>
>> Hi Stephen,
>>
>> the way the EMC clock rate is set in hardware is similar to other
>> clocks, i.e. there's a register and you write the new divider and parent
>> id to it. However, with EMC, you cannot just do this any time you want;
>> writing to the register initiates a state machine in the clock hardware
>> that changes a large number of other parameters regarding DRAM timings
>> as well. These parameters need to be programmed into shadow registers
>> before the rate change write is done. This means that both the new
>> divisor and the parent must be written in the same register write.
>>
>> The CCF has a callback, set_rate_and_parent, which allows for both to be
>> passed to the driver at the same time. However, it also requires
>> set_rate and set_parent to be implemented, which the EMC driver cannot do.
> 
> Ok so we should change the framework to allow drivers to only
> implement set_rate_and_parent and use that in set_rate and
> set_parent implementations if it's the only option available. Or
> is there a problem if CCF allows clk_set_parent() on the EMC
> clock by calling set_rate_and_parent() with the new parent and
> whatever recalc_rate returns for the new parent's rate going into
> the clock?

There isn't really a problem, but the EMC driver cannot implement this
operation sensibly so it would just always return an error if the (rate,
parent) pair given to set_rate_and_parent() doesn't exactly match one of
the entries specified in device tree.

> 
>>
>> Furthermore, the CCF cannot help with parent selection for the EMC clock
>> at all. The parent for each rate is selected by the board designer.
> 
> I'm not following this part. The CCF mostly asks clock providers
> what parent should be used when clk_set_rate() is called.

Yep, that much is fine; what I was alluding was the above (set_parent
and set_rate_and_parent with an unlisted (rate, parent) pair are invalid)

> 
>>
>> There is also the issue that sometimes, the EMC driver cannot directly
>> switch to the target (rate, parent) pair; instead it is necessary to
>> switch first to another pair we call a backup timing. In this situation,
>> we temporarily have a parent that is neither the one we had before the
>> set_rate call or the one it will be after. Especially, if the switch to
>> the backup timing succeeds but the following switch to the target timing
>> fails, then without the reparent call the parent in hardware would be
>> left inconsistent with the software state.
> 
> Yes, I've sent a patch a while ago to support an idea of a "safe
> parent" or a backup timing that can be used while a clock is
> reprogrammed. Mike has also proposed the concept of "coordinated
> clock rates" which would do something similar and allow clock
> providers to control complicated rate transitions themselves. It
> seems that we may be able to use the "safe parent" concept here,
> where first we switch to some other parent, call the set_rate*
> op, and then switch the parent back if we're not already using
> the parent that we should be using.

While I'm not sure how much sophistication is warranted in the CCF, for
our use case this backup timing has to be able to be a function of the
timing we are leaving and preferably also the target timing. Also, as
usual, the backup timings are (rate, parent) pairs, and just changing
rate or just changing parent are both impossible.

> 
> This sort of thing becomes important for things like per-clock
> locking where we need to know how the clock tree is going to
> change *before* we modify the clock tree. If we go back and forth
> between the clock providers and the clock tree while we're in the
> middle of making irreversible changes to the hardware, we may get
> stuck in a situation where we need to lock more clocks and then
> we may need to undo hardware changes.
> 

Yeah, makes sense.

Do you think you can still pull this patchset? There's other code in
linux-next that depends on it and I'd prefer to have a working driver in
the kernel; if/when the improvements to CCF materialize we could update
the driver to use them.

Thanks,
Mikko.
