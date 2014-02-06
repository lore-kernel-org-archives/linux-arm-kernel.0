From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 6 Feb 2014 11:28:24 +0900
Subject: [PATCH 5/5] ARM: tegra: cpuidle: use firmware call for power down
In-Reply-To: <52F266A2.1030503@wwwdotorg.org>
References: <1390299016-14105-1-git-send-email-acourbot@nvidia.com>
 <1390299016-14105-6-git-send-email-acourbot@nvidia.com>
 <52E02DCC.1000404@wwwdotorg.org>
 <CAAVeFuKLtC62+bujY4724hMV_6M8Ow0s=6zRn_M87VX4PHQgxA@mail.gmail.com>
 <52F266A2.1030503@wwwdotorg.org>
Message-ID: <52F2F348.3000502@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2014 01:28 AM, Stephen Warren wrote:
> On 01/23/2014 12:39 AM, Alexandre Courbot wrote:
>> On Thu, Jan 23, 2014 at 5:45 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 01/21/2014 03:10 AM, Alexandre Courbot wrote:
>>>> Invoke the do_idle() firmware call before suspending a CPU so that the
>>>> underlying firmware (if any) can take necessary action.
>>>
>>>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
>>>
>>>> @@ -45,6 +46,8 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
>>>>
>>>>        clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
>>>>
>>>> +     call_firmware_op(do_idle);
>>>> +
>>>>        cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
>>>>
>>>>        clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
>>>
>>> Don't you need to have the kernel also *not* do something when entering
>>> idle; doesn't the FW op replace some of the register writes that the
>>> kernel would otherwise be doing?
>>
>> It seems like the operation is actually to inform the firmware that we
>> are going to suspend the CPU. Downstream kernel also uses it that way.
>> But you are right in that we should expect do_idle() to actually
>> perform the suspend operation. Maybe a prepare_idle() operation should
>> be added to the firmware interface for this purpose?
>
> That sounds like a reasonable change. Is it easy to plumb in?

I think so. Will post a v2 of this soon.

Thanks,
Alex.
