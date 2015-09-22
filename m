From: slash.tmp@free.fr (Mason)
Date: Tue, 22 Sep 2015 17:54:04 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <144297172.JfjI0hNJ9J@wuerfel>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56016780.5080104@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
Message-ID: <5601799C.20701@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/2015 16:51, Arnd Bergmann wrote:
> On Tuesday 22 September 2015 16:36:48 Mason wrote:
>> On 21/09/2015 17:49, Arnd Bergmann wrote:
>>>
>>> - As you are probably aware, please split the series into multiple patches,
>>>   doing one thing at a time. A lot of the patches don't have dependencies
>>>   on one another and can just get merged as soon as they are ready
>>
>> I'm supposed to use git-format-patch, right?
> 
> Yes, and follow Documentation/SubmittingPatches
> 
>>> [snip advice for drivers]
>>> - no mach-types changes please
>>
>> The new way is DT_MACHINE_START?
> 
> Right.
> 
>>> - whatever you need in smp_twd.c will have to get merged by Russell,
>>>   the other patches go through the arm-soc tree.
>>
>> One change is a temp wart for getting twd_clk until I have proper DT.
>>
>> The other change is to remove CLOCK_EVT_FEAT_C3STOP for my board.
>> (We discussed this in May.)
>>
>> Thanks for your guidance. Just to get the ball rolling, here's
>> the full platform patch minus drivers.
>>
>> Open question:
>>
>> 1) arch/arm/Kconfig vs arch/arm/mach-tangox/Kconfig
>> What goes in the first? What goes in the second?
> 
> The first only gets a single line to include the second.

Oh... So all the platforms that define stuff in arch/arm/Kconfig
are just legacy at this point?

>> arch/arm/Kconfig
> 
> Move this to the platform Kconfig file. Also, drop all the
> 'select' statements that are implied by ARCH_MULTIPLATFORM
> and ARCH_MULTI_V7

OK.

There is still a way to generate a kernel that supports only
one board though, right? (To minimize storage required.)

>> arch/arm/boot/dts/Makefile
> 
> Keep this sorted alphabetically.

Right, sorry for the warts, some of this stuff was just randomly thrown
together in my attempts of getting it to run. I am aware of the
sorting requirements, and will follow them, of course.

>> arch/arm/boot/dts/tango.dts
> 
> name this after the actual board you use, put everything that is not
> specific to the board into a tango4.dtsi file.

Nothing in tango.dts is specific to the board. It's all in the SoC,
as far as I can tell.

> [snip comments on DT description]
>> arch/arm/mach-tangox/Kconfig
>> +if ARCH_TANGOX
>> +
>> +config UNCOMPRESS_INCLUDE
>> +	string
>> +	default "debug/uncompress.h"
> 
> Better do this like everyone else.

Do you mean I should provide an empty mach/uncompress.h ?

>> +config ARM_L1_CACHE_SHIFT
>> +	int
>> +	default 5
> 
> This conflicts with the other definition of the same symbol.

I asked about this a long time ago. Maybe I didn't understand
Russell's answer?

http://thread.gmane.org/gmane.linux.ports.arm.kernel/402968

How do I force ARM_L1_CACHE_SHIFT to 5 for my platform?
It saves ~6% of the .data section size.
(Not worth it?)

>> +config MACH_TANGOX_87XX
>> +	bool "Sigma Designs TANGOX 87XX Board"
>> +	default y
>> +	depends on ARCH_TANGOX
>> +	select MIGHT_HAVE_CACHE_L2X0
>> +	select CPU_V7
>> +	select ARM_GIC
>> +	select VFP
>> +	select SMP
>> +	select LOCAL_TIMERS if SMP
>> +	select HAVE_ARM_TWD if SMP
>> +	select HAVE_ARM_SCU if SMP
>> +	select PL310_ERRATA_588369
>> +	select PL310_ERRATA_727915
>> +	select ARM_ERRATA_754322
>> +	select ARM_ERRATA_775420
>> +	select ARCH_HAS_OPP
>> +	select PM_OPP if PM
>> +	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>> +	select ARM_CPU_SUSPEND if PM
>> +	select CPU_USE_DOMAINS if MMU
>> +	select COMMON_CLK
>> +	select TANGOX
> 
> Most of these are already implied by teh generic options.

Is there a simple way to remove what is unnecessary and not more?

>> +void __init tangox_timer_init(void)
>> +{
>> +	int err;
>> +
>> +	clkgen_base = ioremap(CLKGEN_BASE, 0x100);
> 
> Remove all hardcoded physical memory addresses.

You mean I should read CLKGEN_BASE through DT?
(Converting the clock code to DT is a TODO.)

>> +	if (clkgen_base == NULL) return;
>> +
>> +	register_current_timer_delay(&delay_timer);
>> +	sched_clock_register(read_sched_clock, 32, XTAL_FREQ);
>> +
>> +	err = clocksource_register_hz(&tangox_xtal, XTAL_FREQ);
>> +	if (err) pi_alert("Failed to register tangox_xtal clocksource!\n");
>> +
>> +	tangox_clock_tree_register();
>> +
>> +	of_clk_init(NULL);
>> +	clocksource_of_init();
>> +}
> 
> CLK_OF_DECLARE() for the clk
> 
> CLOCKSOURCE_OF_DECLARE() for the clocksource/clockevent

I'm sorry I don't understand what you mean here.
I will look at Mans' implementation.

> Make these two drivers.
> 
>> +static struct map_desc tango_map_desc[] __initdata = {
>> +	{
>> +		.virtual	= TANGO_IO_START,
>> +		.pfn		=__phys_to_pfn(0),
>> +		.length		= TANGO_IO_SIZE,
>> +		.type 		= MT_DEVICE,
>> +	},
>> +};
>> +
>> +static void __init tango_map_io(void)
>> +{
>> +	iotable_init(tango_map_desc, ARRAY_SIZE(tango_map_desc));
>> +}
> 
> What is this for? Most platforms don't need this.

IIUC, the idea was to optimize TLB entries by having a single
16MB super-section mapping. If every driver maps his little
500-byte area, the MMU code has to create lots of second
level mappings.

We might as well create one large mapping at init, no?

This logic slightly breaks down since AFAICT Linux doesn't
take advantage of super-sections.

>> +extern void __init tangox_timer_init(void);
>> +//extern struct smp_operations tangox_smp_ops;
> 
> Never put 'extern' declarations into a .c file.

Sorry for the quick and dirty code.

>> +static const char *tango_dt_compat[] = { "sigma,tango4-soc", NULL };
>> +
>> +MACHINE_START(TANGOX_87XX, "TANGOX_87XX")
>> +	.atag_offset	= 0x100,
>> +	.init_time	= tangox_timer_init,
>> +	.map_io		= tango_map_io,
>> +	//.smp		= &tangox_smp_ops,
>> +	//.restart	= tango_restart, /*** REQUIRED FOR CLEAN REBOOT ***/
>> +	.dt_compat	= tango_dt_compat,
>> +MACHINE_END
> 
> All except the dt_compat can be removed here.

I left .smp and .restart in comments because I need those, AFAIU?
Also I'm using the APPEND_DT_TO_UIMAGE option. I don't need the
atag_offset info?

Thanks for your comments, you've given me much to think about,
and much to fix.

Regards.
