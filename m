From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Dec 2017 14:55:14 +0100
Subject: [PATCH] ARM: B15: fix unused label warnings
In-Reply-To: <20171218134430.GD10595@n2100.armlinux.org.uk>
References: <20171218134126.2913861-1-arnd@arndb.de>
 <20171218134430.GD10595@n2100.armlinux.org.uk>
Message-ID: <CAK8P3a3ox3U8eOkNxWiTi61xVttW0bE4B-Qw3OpronLmgFfgtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 2:44 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Dec 18, 2017 at 02:41:11PM +0100, Arnd Bergmann wrote:
>> The new conditionally compiled code leaves some labels and one
>> variable unreferenced when CONFIG_HOTPLUG_CPU and CONFIG_PM_SLEEP
>> are disabled:
>>
>> arch/arm/mm/cache-b15-rac.c: In function 'b15_rac_init':
>> arch/arm/mm/cache-b15-rac.c:353:1: error: label 'out_unmap' defined but not used [-Werror=unused-label]
>>  out_unmap:
>>  ^~~~~~~~~
>> arch/arm/mm/cache-b15-rac.c:351:1: error: label 'out_cpu_dead' defined but not used [-Werror=unused-label]
>>  out_cpu_dead:
>>  ^~~~~~~~~~~~
>> At top level:
>> arch/arm/mm/cache-b15-rac.c:53:12: error: 'rac_config0_reg' defined but not used [-Werror=unused-variable]
>>
>> This adds more #ifdefs around them.
>>
>> Fixes: 55de88778f4b ("ARM: 8726/1: B15: Add CPU hotplug awareness")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> Florian, if this looks good to you, please forward the fix into Russell's
>> patch tracker, otherwise just send a better fix.
>
> I'd prefer a better fix than yet more ifdefs...

Ok, I've reworked my patch now to replace the existing #ifdef with if
(IS_ENABLED())
checks instead, which makes it look much nicer.

I'll send the new version after more randconfig testing.

       Arnd
