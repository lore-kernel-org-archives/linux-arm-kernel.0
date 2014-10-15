From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 15 Oct 2014 16:49:04 +0100
Subject: [PATCH] ARM/ARM64: arch-timer: fix arch_timer_probed logic
In-Reply-To: <20141015152823.GH20034@leverpostej>
References: <1413385580-23317-1-git-send-email-marc.zyngier@arm.com>
 <20141015152823.GH20034@leverpostej>
Message-ID: <543E9770.3010103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/10/14 16:28, Mark Rutland wrote:
> On Wed, Oct 15, 2014 at 04:06:20PM +0100, Marc Zyngier wrote:
>> Commit c387f07e6205 (clocksource: arm_arch_timer: Discard unavailable
>> timers correctly) changed the way the driver makes sure both the memory
>> and system-register timers have been probed before finalizing the probing.
>>
>> There is a interesting flaw in this logic that leads to this final step
>> never to be executed. Things seems to work pretty well until something
>> actually needs the data that is produced during this final stage.
>>
>> For example, KVM explodes on the first run of a guest when executed on
>> a platform that has both memory and sysreg nodes (Juno, for example).
>
> As far as I can tell, the logic is flawed for all cases except two
> functional nodes that we manage to probe.
>

Agreed, it's my mistake. I inverted the logic incorrectly when I moved
it to a function while adding of_node_put in v2 of the patch.

I think wrong DTB got picked up when I tested this. I am sorry for that.

>>
>> Just fix the damned logic, and enjoy booting VMs again.
>>
>> Tested on a Juno system.
>>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Reported-by: Riku Voipio <riku.voipio@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>
> The new logic makes sense to me, so:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
(This time tested all possible case)

Regards,
Sudeep
