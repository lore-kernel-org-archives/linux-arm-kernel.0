From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 4 Feb 2011 12:31:43 -0700
Subject: [PATCH 01/11] ARM: integrator: use new init_early for clock tree
	init
In-Reply-To: <4D4C5318.1070501@gmail.com>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
	<E1PiSAn-0003ot-Uc@rmk-PC.arm.linux.org.uk>
	<4D4C5318.1070501@gmail.com>
Message-ID: <AANLkTinMd1q+x0+B+j2VvSvRJbdcAWazuyCuxNsa1emA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 4, 2011 at 12:27 PM, Rob Herring <robherring2@gmail.com> wrote:
> Russell,
>
> On 01/27/2011 07:46 AM, Russell King - ARM Linux wrote:
>>
>> Initialize the clock tree early.
>>
>> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
>> ---
>> ?arch/arm/mach-integrator/common.h ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-integrator/core.c ? ? ? ? ?| ? ?7 +++++--
>> ?arch/arm/mach-integrator/integrator_ap.c | ? ?3 ++-
>> ?arch/arm/mach-integrator/integrator_cp.c | ? 11 +++++++++--
>> ?4 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-integrator/common.h
>> b/arch/arm/mach-integrator/common.h
>> index 5f96e15..a08f9b0 100644
>> --- a/arch/arm/mach-integrator/common.h
>> +++ b/arch/arm/mach-integrator/common.h
>> @@ -1 +1,2 @@
>> +void integrator_init_early(void);
>> ?void integrator_reserve(void);
>> diff --git a/arch/arm/mach-integrator/core.c
>> b/arch/arm/mach-integrator/core.c
>> index b8e884b..77315b9 100644
>> --- a/arch/arm/mach-integrator/core.c
>> +++ b/arch/arm/mach-integrator/core.c
>> @@ -144,12 +144,15 @@ static struct clk_lookup lookups[] = {
>> ? ? ? ?}
>> ?};
>>
>> +void __init integrator_init_early(void)
>> +{
>> + ? ? ? clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>> +}
>> +
>
> One potential issue with init_early is kmalloc is not up yet. So moving
> clock init here will be an issue when/if clocks are converted to device tree
> or if any platforms do dynamic allocations for their clock tree.

If needed we can do alloc_bootmem().  I don't see this as a showstopper.

g.

>
> Rob
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
