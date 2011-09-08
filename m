From: santosh.shilimkar@ti.com (Santosh)
Date: Thu, 08 Sep 2011 10:46:00 +0530
Subject: [PATCH v2 2/5] cpu_pm: call notifiers during suspend
In-Reply-To: <87k49knmrw.fsf@ti.com>
References: <1315060755-4613-1-git-send-email-santosh.shilimkar@ti.com>	<1315060755-4613-3-git-send-email-santosh.shilimkar@ti.com>
	<87k49knmrw.fsf@ti.com>
Message-ID: <4E684F90.7010809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011 01:32 AM, Kevin Hilman wrote:
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> From: Colin Cross<ccross@android.com>
>>
>> Implements syscore_ops in cpu_pm to call the cpu and
>> cpu cluster notifiers during suspend and resume,
>> allowing drivers receiving the notifications to
>> avoid implementing syscore_ops.
>>
>> Signed-off-by: Colin Cross<ccross@android.com>
>> [santosh.shilimkar at ti.com: Rebased against 3.1-rc4]
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>
> I don't think using syscore_ops is right here.  The platform code should
> decide where in its own suspend path the notifiers should be triggered.
>
> The reason is because while the syscore_ops run late in the suspend
> path, they still run before some platform-specific decisions about the
> low-power states are made.  That means that any notifiers that need to
> use information about the target low-power state (e.g. whether context
> will be lost or not) cannot do so since that information has not yet
> been decided until the platform_suspend_ops->enter() runs.
>
Initially I thought the same but in general S2R, platform doesn't
support multiple states like CPUIDLE. On OMAP, we do have a debug
option to choose the state but on real product, it's always the
deepest supported state is used. So the driver saving the
full context for S2R, should be fine.

Ofcourse for CPUIDLE, the notifier call chain decisions are left
with platform CPUIDLE drivers since there can be multiple low
power states and the context save/restore has to be done based
on low power states.

The advantage with this is, the platform code is clean from the
notfiers calls. CPUIDLE driver needs to call the different notifier
events based on C-states and that perfectly works.

I liked this simplification for the S2R. Down side is in S2R if you
don't plan to hit deepest state, drivers end up saving full context
which is fine I guess.

> Basically, I think the cpu_*_pm_enter() calls should be called by
> platform-specific code, not by common code.
>
Sure and that's the case for CPUIDLE already. The change was
done only for S2R based on above points.

Regards
Santosh
