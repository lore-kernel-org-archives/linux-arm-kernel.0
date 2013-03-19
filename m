From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 19 Mar 2013 12:22:29 +0900
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support
In-Reply-To: <201303140906.27073.arnd@arndb.de>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <201303121225.40230.arnd@arndb.de>
 <CANqRtoTSN=VBV1-dNMSM5aaMwHmmXe9Ow6pFK_AVzXKuOXkFEA@mail.gmail.com>
 <201303140906.27073.arnd@arndb.de>
Message-ID: <CANqRtoTM01CNbJfCka09nz=pH+dxqizyHG6E64J05KABKdyFtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 6:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 14 March 2013, Magnus Damm wrote:
>> On Tue, Mar 12, 2013 at 9:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 12 March 2013, Magnus Damm wrote:
>> >> +static struct platform_device *r8a73a4_devices[] __initdata = {
>> >> +};
>> >> +
>> >> +void __init r8a73a4_add_standard_devices(void)
>> >> +{
>> >> +       r8a73a4_clock_init();
>> >> +
>> >> +       platform_add_devices(r8a73a4_devices, ARRAY_SIZE(r8a73a4_devices));
>> >> +}
>> >
>> > I would suggest doing the platform_add_devices() only when you actually
>> > add devices to the array, unless you have a number of conflicting patches
>> > that each want to add their own devices.
>>
>> So you would prefer that I fold this portion into a patch later in the series?
>
> If you are adding the devices in a later patch of the same series, it's
> probably better to leave it like it is. I would just like to avoid having
> dead code in a release if you don't get around to also add the devices.

Sure. As you may have seen, I ended up moving away from static
platform devices in V2. So this portion of the code is gone there.

>> >> +#ifdef CONFIG_USE_OF
>> >> +void __init r8a73a4_add_standard_devices_dt(void)
>> >> +{
>> >> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>> >> +}
>> >
>> > I have a patch that will make this function definition the default, so you
>> > no longer have to provide an init_machine callback if you don't do anything
>> > special. It's ok to leave it in for now, but we might want to do a follow
>> > up patch to remove it once both patches are merged.
>>
>> That's very nice! I am happy to hear that. Is that patch targeting v3.10?
>
> Yes, I just need to produce a new version based on 3.9-rc.

That is fine, but as you suggest below, perhaps it is easier to wait
until post-v3.10?

>> >> +static const char *r8a73a4_boards_compat_dt[] __initdata = {
>> >> +       "renesas,r8a73a4",
>> >> +       NULL,
>> >> +};
>> >> +
>> >> +DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
>> >> +       .init_irq       = irqchip_init,
>> >
>> > Same thing for the default irqchip_init.
>>
>> Excellent! I believe the easiest is to leave it as-is for now and have
>> a clean-up series that can be merged late in the cycle after your
>> patch is in. I am not sure if that fits with your way of dealing with
>> the pull requests. At least that's how we used to do it for SH. If you
>> have any suggestion when to remove it please let me know.
>
> I don't want to get new patches during the merge window, but we can
> arrange a branch in the arm-soc tree that has both changes merged
> and the cleanup on top. We always send out pull requests for 10 to
> 15 branches in the merge window, and the later branches can be based
> on the earlier ones to deal with dependencies like this.
>
> In this particular case, it would also not hurt to do the cleanup
> in 3.11, since the patch is only cosmetic.

I agree that targeting v3.11 for this cleanup makes most sense. So I
kept the functions in V2.

Thanks,

/ magnus
