From: robherring2@gmail.com (Rob Herring)
Date: Fri, 03 Jun 2011 08:55:18 -0500
Subject: [PATCH] ARM: local timers: Allow boot CPU to have its timer
	running early
In-Reply-To: <20110603085500.GG10532@n2100.arm.linux.org.uk>
References: <1306937006-26597-1-git-send-email-marc.zyngier@arm.com>
	<20110602163152.GH32751@game.jcrosoft.org>
	<1307033815.31098.31.camel@e102391-lin.cambridge.arm.com>
	<4DE7E6AF.4020404@gmail.com>
	<20110603085500.GG10532@n2100.arm.linux.org.uk>
Message-ID: <4DE8E7C6.9010601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2011 03:55 AM, Russell King - ARM Linux wrote:
> On Thu, Jun 02, 2011 at 02:38:23PM -0500, Rob Herring wrote:
>> On 06/02/2011 11:56 AM, Marc Zyngier wrote:
>>> On Thu, 2011-06-02 at 18:31 +0200, Jean-Christophe PLAGNIOL-VILLARD
>>> wrote:
>>>> On 15:03 Wed 01 Jun     , Marc Zyngier wrote:
>>>>> Currently, the boot CPU has its local timer enabled long after
>>>>> the delay loop has been calibrated. This makes it impossible to
>>>>> boot a system that only uses local timers, like the A15.
>>>>>
>>>>> Use late_time_init hook to initialize the boot CPU local timer.
>>>>> Since shmobile is already using this hook, add an ARM specific
>>>>> arm_late_time_init hook that platforms can use instead.
>>>>>
>>>>> Cc: Paul Mundt<lethal@linux-sh.org>
>>>>> Cc: Magnus Damm<magnus.damm@gmail.com>
>>>>> Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
>>>> I propose to switch to early platform devce and earlytimer
>>>>
>>>> this will avoid the arm_late_time_init hook
>>>>
>>>> and will make it cross arch
>>>
>>> I believe this is orthogonal. shmobile (the only ARM user of
>>> late_time_init) is already doing some early_platform stuff for its
>>> timers.
>>>
>>> What I'm trying to achieve here is to make sure the timer on CPU0 is
>>> actually up, running and registered as a clock_event_device before we
>>> hit the delay loop.
>>>
>>> Or maybe I've misunderstood what you're pointing me to?
>>>
>>
>> I believe he is referring to this patch which generically enables the
>> shmobile code for ARM:
>>
>> http://www.spinics.net/lists/arm-kernel/msg123736.html
>>
>> I don't think it has been pulled into mainline yet.
>
> And I really don't like it:
> 1. It adds an additional layer of complexity.
> 2. We end up needing more ways to initialize stuff even earlier in the
>     kernel boot sequence.
> 3. Tracking down what gets called when becomes a lot harder.
>
> At one time there used to be a good rule to follow: Keep it Simple, Damnit.
> This doesn't follow that.
>
> And so far, no one has explained _why_ shmobile uses this stuff... so
> my presumption at the moment is that there's no real good reason.

I believe the primary reason was to align sh and shmobile platforms' 
timer code.

In addition, other reasons I see are eliminate timer init in every 
single platform and move timer code out of arch/arm to 
drivers/clocksource. Getting the per platform timer setup to just be 
data enables putting that information in devicetree.

Rob
