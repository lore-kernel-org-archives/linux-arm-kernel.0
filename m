From: robherring2@gmail.com (Rob Herring)
Date: Mon, 25 Mar 2013 16:28:10 -0500
Subject: [PATCH] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
In-Reply-To: <20130325172633.GP30923@n2100.arm.linux.org.uk>
References: <1363818875-15978-1-git-send-email-robherring2@gmail.com>
 <20130321110646.GE15279@e106331-lin.cambridge.arm.com>
 <20130325172633.GP30923@n2100.arm.linux.org.uk>
Message-ID: <5150C16A.3040208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 12:26 PM, Russell King - ARM Linux wrote:
> On Thu, Mar 21, 2013 at 11:06:47AM +0000, Mark Rutland wrote:
>> On TC2 this series leads to using the vexpress 24MHz clock as the sched clock
>> in preference to the architected timer:
>>
>>   Architected local timer running at 24.00MHz (virt).
>>   Switching to timer-based delay loop
>>   Registered arch_counter_get_cntvct+0x0/0x14 as sched_clock source
>>   sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
>>   Registered versatile_read_sched_clock+0x0/0x28 as sched_clock source
>>
>> As they both have the same frequency, neither overrides the other, and
>> whichever gets registered last is used as the sched_clock. As accesses
>> to the architected timer are going to have a much lower overhead, this
>> isn't very nice (and it could be better to use it even if it had a lower
>> frequency).
> 
> I'll remind people that sched_clock() is supposed to be functional at
> the point in the boot sequence where the call to sched_init() is called.
> That is after setup_arch() and *before* time_init() is called.

I count integrator-cp, realview, versatile and non-DT VExpress that do
this (not surprisingly) and 25 platforms or timer implementations plus
arm64 that do sched_clock setup in time_init. What's broken by not
moving these earlier?

We could probably fix arch timers relatively easily, but supporting the
numerous memory-mapped timers will be harder. Most timers are also
dependent on the clocks being initialized. That's really an orthogonal
issue to what this patch series solves. This series is about selecting
the best sched_clock when multiple timers are present. Perhaps one that
is setup in init_early should be preferred over one setup in init_time.
I'm not sure how to detect that.

Rob
