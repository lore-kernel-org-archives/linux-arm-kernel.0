From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 02 Oct 2013 10:22:36 -0700
Subject: [PATCH] sched_clock: fix postinit no sched_clock function check
In-Reply-To: <524C5484.5000601@ti.com>
References: <1380732928-13897-1-git-send-email-santosh.shilimkar@ti.com>
 <20131002170917.GB30298@mudshark.cambridge.arm.com> <524C5484.5000601@ti.com>
Message-ID: <524C565C.8010709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/13 10:14, Santosh Shilimkar wrote:
> On Wednesday 02 October 2013 01:09 PM, Will Deacon wrote:
>> On Wed, Oct 02, 2013 at 05:55:28PM +0100, Santosh Shilimkar wrote:
>>> The sched_clock code uses 2 levels of function pointers, sched_clock_func()
>>> and read_sched_clock() but the no sched_clock check in postinit() just
>>> checks read_sched_clock().
>>>
>>> This leads to kernel falling back to jiffy based sched clock even in
>>> presence of sched_clock_func() which is not desirable.
>>>
>>> Fix the postinit() check to avoid the issue. Probably the issue is hidden
>>> so far on most of the arm SOCs because of already existing sched_clock
>>> registrations apart from arch_timer sched_clock. One can reproduce the
>>> issue by just have arch_timer as sched_clock
>> Isn't this just an issue with the arch timer driver not calling
>> setup_sched_clock? Instead, we munge around with sched_clock_func directly,
>> which doesn't appear to be the way anybody else deals with this.
>>
> I thought about that option as well but was not sure since even in that case
> the check is not complete. We just ensure that function is popullated.

Yes, nothing is actually broken because sched_clock_func() won't try to
use the jiffy based read_sched_clock() function. I'm not sure we
actually need this patch besides to remove a useless timer that updates
the jiffy epoch. Can we wait until my 64-bit sched_clock patch series
lands in 3.13? It looks like I still need an ack from Will or Catalin on
the architected timer patch before the clocksource folks pick it up.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
