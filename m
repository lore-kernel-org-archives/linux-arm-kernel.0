From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 14 Mar 2013 16:44:08 +0900
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support
In-Reply-To: <201303121225.40230.arnd@arndb.de>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <20130312045609.19701.39029.sendpatchset@w520>
 <201303121225.40230.arnd@arndb.de>
Message-ID: <CANqRtoTSN=VBV1-dNMSM5aaMwHmmXe9Ow6pFK_AVzXKuOXkFEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Mar 12, 2013 at 9:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 12 March 2013, Magnus Damm wrote:
>> +static struct platform_device *r8a73a4_devices[] __initdata = {
>> +};
>> +
>> +void __init r8a73a4_add_standard_devices(void)
>> +{
>> +       r8a73a4_clock_init();
>> +
>> +       platform_add_devices(r8a73a4_devices, ARRAY_SIZE(r8a73a4_devices));
>> +}
>
> I would suggest doing the platform_add_devices() only when you actually
> add devices to the array, unless you have a number of conflicting patches
> that each want to add their own devices.

So you would prefer that I fold this portion into a patch later in the series?

>> +#ifdef CONFIG_USE_OF
>> +void __init r8a73a4_add_standard_devices_dt(void)
>> +{
>> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>> +}
>
> I have a patch that will make this function definition the default, so you
> no longer have to provide an init_machine callback if you don't do anything
> special. It's ok to leave it in for now, but we might want to do a follow
> up patch to remove it once both patches are merged.

That's very nice! I am happy to hear that. Is that patch targeting v3.10?

>> +static const char *r8a73a4_boards_compat_dt[] __initdata = {
>> +       "renesas,r8a73a4",
>> +       NULL,
>> +};
>> +
>> +DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
>> +       .init_irq       = irqchip_init,
>
> Same thing for the default irqchip_init.

Excellent! I believe the easiest is to leave it as-is for now and have
a clean-up series that can be merged late in the cycle after your
patch is in. I am not sure if that fits with your way of dealing with
the pull requests. At least that's how we used to do it for SH. If you
have any suggestion when to remove it please let me know.

>> +       .init_machine   = r8a73a4_add_standard_devices_dt,
>> +       .init_time      = shmobile_timer_init,
>> +       .dt_compat      = r8a73a4_boards_compat_dt,
>
> Have you looked into using clocksource_of_init() here? Since you are using
> the ARM architected timers, I would expect that they soon will get probed
> using that function, which means we have to be careful crossing patches
> if someone wants to convert over all the existing users and you add a new one
> here.

Thanks for this suggestion. Right now we call shmobile_timer_init()
that includes these calls:
	arch_timer_of_register();
	arch_timer_sched_clock_init();

For SH and mach-shmobile we have our own timers in drivers/clocksource
as platform regular devices. They export clock source and clock event
interfaces. Today we simply use the regular driver model together with
SoC code to register platform devices during SoC setup - this
including timers but excluding the arch timer.

I agree we need to find some way to make them work together with the
ARM architected timer.

Thanks,

/ magnus
