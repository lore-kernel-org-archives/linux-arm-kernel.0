From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Feb 2011 19:59:24 +0000
Subject: [PATCH 01/11] ARM: integrator: use new init_early for clock
	tree init
In-Reply-To: <4D4C5928.8040809@gmail.com>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
	<E1PiSAn-0003ot-Uc@rmk-PC.arm.linux.org.uk>
	<4D4C5318.1070501@gmail.com>
	<20110204193420.GC8732@n2100.arm.linux.org.uk>
	<4D4C5928.8040809@gmail.com>
Message-ID: <20110204195924.GD8732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 04, 2011 at 01:53:12PM -0600, Rob Herring wrote:
> Russell,
>
> On 02/04/2011 01:34 PM, Russell King - ARM Linux wrote:
>> On Fri, Feb 04, 2011 at 01:27:20PM -0600, Rob Herring wrote:
>>> Russell,
>>>
>>> On 01/27/2011 07:46 AM, Russell King - ARM Linux wrote:
>>>> Initialize the clock tree early.
>>>>
>>>> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
>>>> ---
>>>>    arch/arm/mach-integrator/common.h        |    1 +
>>>>    arch/arm/mach-integrator/core.c          |    7 +++++--
>>>>    arch/arm/mach-integrator/integrator_ap.c |    3 ++-
>>>>    arch/arm/mach-integrator/integrator_cp.c |   11 +++++++++--
>>>>    4 files changed, 17 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
>>>> index 5f96e15..a08f9b0 100644
>>>> --- a/arch/arm/mach-integrator/common.h
>>>> +++ b/arch/arm/mach-integrator/common.h
>>>> @@ -1 +1,2 @@
>>>> +void integrator_init_early(void);
>>>>    void integrator_reserve(void);
>>>> diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
>>>> index b8e884b..77315b9 100644
>>>> --- a/arch/arm/mach-integrator/core.c
>>>> +++ b/arch/arm/mach-integrator/core.c
>>>> @@ -144,12 +144,15 @@ static struct clk_lookup lookups[] = {
>>>>    	}
>>>>    };
>>>>
>>>> +void __init integrator_init_early(void)
>>>> +{
>>>> +	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>>>> +}
>>>> +
>>>
>>> One potential issue with init_early is kmalloc is not up yet. So moving
>>> clock init here will be an issue when/if clocks are converted to device
>>> tree or if any platforms do dynamic allocations for their clock tree.
>>
>> That can't be avoided, because the long term plan is to move the sp804
>> and twd timers over to using the clk API - and system timers are
>> initialized prior to kmalloc.
>
> setup_arch is before mm_init, and init_IRQ and time_init are after  
> mm_init. My testing shows OF clock init works fine in the timer init.

The general point still applies.

We can either leave stuff as is and bodgerate sp804 and twd so that we
sort of sometimes use the clk API to maybe get the clock rate for these
devices on some platforms, or we can move everyone over.

I don't regard sticking clk API initialization into stuff like .map_io
(as some platforms do), timer initialization (like other platforms do)
or an initcall as sane.

In any case, clkdev stuff is static based lookups, not DT based lookups.
So surely the clkdev stuff shouldn't be used with DT lookups?
