From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Dec 2011 10:39:18 +0000
Subject: [PATCH] ARM: smp_twd: make sure timer is stopped before
 registering it
In-Reply-To: <CAMQu2gwePYXQZ5Z1pfoEWqbmJH1SabpbLXfmCnNBe=mQnoQiXQ@mail.gmail.com>
References: <1324564287-1742-1-git-send-email-marc.zyngier@arm.com>
 <CAMQu2gwePYXQZ5Z1pfoEWqbmJH1SabpbLXfmCnNBe=mQnoQiXQ@mail.gmail.com>
Message-ID: <4EF45A56.6070506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/12/11 06:41, Shilimkar, Santosh wrote:
> On Thu, Dec 22, 2011 at 8:01 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On secondary CPUs, the Timer Control Register is not reset
>> to a sane value before the timer is registered, and the TRM
>> doesn't seem to indicate any reset value either. In some cases,
>> the kernel will take an interrupt too early, depending on what
>> junk was present in the registers at reset time.
>>
>> The fix is to set the Timer Control Register to 0 before
>> registering the clock_event_device and enabling the interrupt.
>>
>> Problem seen on VE (Cortex A5) and Tegra.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/kernel/smp_twd.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>> index a8a6682..2442bbb 100644
>> --- a/arch/arm/kernel/smp_twd.c
>> +++ b/arch/arm/kernel/smp_twd.c
>> @@ -167,6 +167,8 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
>>
>>        twd_calibrate_rate();
>>
>> +       __raw_writel(0, twd_base + TWD_TIMER_CONTROL);
>> +
> Is it because of junk value in register or something programmed as part of the
> calibrate function. I suspect it might be because of what's getting programmed
> as part of calibrate function.

The calibration only affects the boot CPU, and is what puts it in a
known state (the timer is counting, but interrupts are disabled at the
timer level, making it safe to enable interrupts at the GIC level).

This problem only affects the secondary CPUs, which are in an unknown
state when we enable the interrupt.

	M.
-- 
Jazz is not dead. It just smells funny...
