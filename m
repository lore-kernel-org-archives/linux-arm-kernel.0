From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 18 Nov 2015 16:33:37 +0200
Subject: [PATCH] arm: omap2: Kconfig: select TWD and global timer on
 AM43xx devices
In-Reply-To: <56461256.5050209@oracle.com>
References: <1447351566-2328-1-git-send-email-balbi@ti.com>
 <5645DC3A.4050504@ti.com> <5645E096.1030600@free.fr>
 <56461256.5050209@oracle.com>
Message-ID: <564C8C41.9080006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2015 06:39 PM, santosh shilimkar wrote:
> On 11/13/2015 5:07 AM, Mason wrote:
>> On 13/11/2015 13:48, Grygorii Strashko wrote:
>>> On 11/12/2015 08:06 PM, Felipe Balbi wrote:
>>>> Make sure to tell the kernel that AM437x has
>>>> TWD and global timers.
>>>>
>>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>> ---
>>>>
>>>> Hi Tony,
>>>>
>>>> now that all dependencies are in place, we can
>>>> finally enable twd and global_timer for AM437x.
>>>>
> Is AM437x SMP SOC ? 

No. But it has ARM TWD and GT

> Is TWD on AM437x works in low power states ?

No. But TWD, seems, is not a problem here if omap gp timer
can be used as broadcast device.

> Probably I haven't followed the recent updates, but does
> the TWD supports C3STOP on UP systems ? The broadcast
> code was SMP only in past, and TWD use to die in
> low power state on past OMAP SOCs.
> 
> If either of these are still the issue then
> TWD shouldn't be used.
> 

Yep. I see the problem with ARM Global timer here if
CPUIdle is enabled and ARM Global timer is selected as
clocksource device.

I think, it will be right thing to disable "global_timer"
and "local_timer" nodes in am437x.dtsi by default - if
someone would like to use them then those nodes have
to be enabled explicitly in board file.
(TWD timer will be enabled on OMAP multi SoC build
 irrespectively of HAVE_ARM_TWD is selected for am437x or not,
 because it will be selected for omap4). 
I've just sent corresponding patch: 
 http://www.spinics.net/lists/arm-kernel/msg461141.html

Also, probably, it could be reasonable to:
- make ARM_GLOBAL_TIMER fully selectable option and allow select it from defconfig.

- or - update this patch as below
-       select ARM_GLOBAL_TIMER
-       select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
+       select ARM_GLOBAL_TIMER if !CPU_IDLE
+       select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK if ARM_GLOBAL_TIMER



Thanks.
-- 
regards,
-grygorii
