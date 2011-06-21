From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 21 Jun 2011 15:47:04 +0530
Subject: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
In-Reply-To: <20110621100057.GB23802@n2100.arm.linux.org.uk>
References: <20110620101438.GD2082@n2100.arm.linux.org.uk>
	<4DFF20B3.7010209@ti.com>
	<20110620104415.GF2082@n2100.arm.linux.org.uk>
	<4DFF255E.5030308@ti.com>
	<20110620111336.GG2082@n2100.arm.linux.org.uk>
	<4DFF2E37.8030602@ti.com>
	<20110620114019.GH2082@n2100.arm.linux.org.uk>
	<20110620142338.GL2082@n2100.arm.linux.org.uk>
	<4DFF5F29.2000904@ti.com> <4E005F92.8030208@ti.com>
	<20110621100057.GB23802@n2100.arm.linux.org.uk>
Message-ID: <4E006FA0.7050508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/21/2011 3:30 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 21, 2011 at 02:38:34PM +0530, Santosh Shilimkar wrote:
>> Russell,
>>
>> On 6/20/2011 8:24 PM, Santosh Shilimkar wrote:
>>> On 6/20/2011 7:53 PM, Russell King - ARM Linux wrote:
>>>> So, as loops_per_jiffy is not local to this function, the compiler has
>>>> to write out that zero value, before calling calibrate_delay_converge(),
>>>> and loops_per_jiffy only becomes non-zero _after_
>>>> calibrate_delay_converge()
>>>> has returned. This opens the window and allows the spinlock debugging
>>>> code to explode.
>>>>
>>>> This patch closes the window completely, by only writing to
>>>> loops_per_jiffy
>>>> only when we have a real value for it.
>>>>
>>>> This allows me to boot 3.0.0-rc3 on Versatile Express (4 CPU) whereas
>>>> without this it fails with spinlock lockup and rcu problems.
>>>>
>>>> init/calibrate.c | 14 ++++++++------
>>>> 1 files changed, 8 insertions(+), 6 deletions(-)
>>>>
>>> I am away from my board now. Will test this change.
>> Have tested your change and it seems to fix the crash I
>> was observing. Are you planning to send this fix for rc5?
>
> Yes.  I think sending CPUs into infinite loops in the spinlock code is
> definitely sufficiently serious that it needs to go to Linus ASAP.
> It'd be nice to have a tested-by line though.
>
Sure.

>>> btw, the online-active race is still open even with this patch close
>>> and should be fixed.
>>>
>> The only problem remains is waiting for active mask before
>> marking CPU online. Shall I refresh my patch with only
>> this change then ?
>
> I already have that as a separate change.
Can you point me to both of these commits so that I have
them in my tree for testing.

Thanks for help.

Regards
Santosh
