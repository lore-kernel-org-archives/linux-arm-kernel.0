From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 2 Jun 2016 14:51:31 +0200
Subject: [PATCH v5 4/6] acpi: Add GTDT table parse driver into ACPI driver
In-Reply-To: <CADyBb7vL1RHa3V8M1bNb-63rZiRZWJt4Kory61+1PA+Ruv59Gg@mail.gmail.com>
References: <1464096633-9309-1-git-send-email-fu.wei@linaro.org>
 <1464096633-9309-5-git-send-email-fu.wei@linaro.org>
 <574CC524.5090601@linaro.org>
 <CADyBb7vL1RHa3V8M1bNb-63rZiRZWJt4Kory61+1PA+Ruv59Gg@mail.gmail.com>
Message-ID: <57502BD3.2000208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 05:34 PM, Fu Wei wrote:

Hi Fu Wei,

can you fix your email formatting, it is inserting tabulation at the 
beginning of each lines.

>         +config ACPI_GTDT
>         +       bool "ACPI GTDT Support"
>         +       depends on ARM64
>         +       help
>         +         GTDT (Generic Timer Description Table) provides
>         information
>         +         for per-processor timers and Platform (memory-mapped)
>         timers
>         +         for ARM platforms. Select this option to provide
>         information
>         +         needed for the timers init.
>
>
>     Why not ARM64's Kconfig select ACPI_GTDT ?
>
>     This config option assumes an user will manually select this option
>     which I believe it makes sense to have always on when ARM64=y. So
>     why not create a silent option and select it directly from the ARM64
>     platform Kconfig ?
>
>
>
> I use "depends on ARM64" here, because GTDT is only for ARM, and only
> ARM64 support ACPI. GTDT is meaningless for other architecture. This
> "depends on" just makes sure only ARM64 can select it.
>
> But user don't need to manually select this option. Once ARM64=y and
> ACPI=y, this will be automatically selected, because we have this in
> [PATCH v5 5/6]:
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 47352d2..5a5baa1 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -8,6 +8,7 @@ config CLKSRC_OF
>   config CLKSRC_ACPI
> bool
> select CLKSRC_PROBE
> +select ACPI_GTDT
>   config CLKSRC_PROBE
> bool
>
> And CLKSRC_ACPI will be selected by below in Kconfig of
> clocksource(mainline kernel):
>
> config ARM_ARCH_TIMER
> bool
> select CLKSRC_OF if OF
> select CLKSRC_ACPI if ACPI
>
> And ARM_ARCH_TIMER will be selected by ARM64 in
> arch/arm64/Kconfig(mainline kernel).
>
> So ARM64=y  --> ARM_ARCH_TIMER=y (if ACPI=y) --> CLKSRC_ACPI=y -->
> ACPI_GTDT=y
>
> I think that is the right solution. Do I miss something?

It is correct if ACPI_GTDT is a silent option.

Otherwise, if you give the user the opportunity to enable/disable the 
ACPI_GTDT, then CLKSRC_ACPI *depends* on it.

[ ... ]

>         +static int __init for_platform_timer(enum acpi_gtdt_type type,
>         +                                    platform_timer_handler
>         handler, void *data)
>
>
>     For the clarity of the code, I suggest to use a macro with a name
>     similar to what we find in the kernel:
>
>     #define gtdt_for_each(type, ...) ...
>     #define gtdt_for_each_timer gtdt_for_each(ACPI_GTDT_TYPE_TIMER_BLOCK)
>     #define gtdt_for_each_wd    gtdt_for_each(ACPI_GTDT_TYPE_WATCHDOG)
>
>     ... and rework this function to clarify its purpose.
>
>
> yes, that is a very good idea, thanks, will do.
>
>
>     What is for ? Count the number of 'type' which succeed to call the
>     handler ?
>
>
> because we need a index of watchdog timer for importing it into the
> resource of platform_device,
> but I think I can ues a static variable to solve this problem? Any thought?

Don't use static variable. It is possible to fill the index by passing 
the structure to the function or whatever else.

>
>         +{
>         +       struct acpi_gtdt_header *header;
>         +       int i, index, ret;
>         +       void *platform_timer = platform_timer_struct;
>         +
>         +       for (i = 0, index = 0; i < platform_timer_count; i++) {
>         +               if (platform_timer > gtdt_end) {
>         +                       pr_err(FW_BUG "subtable pointer
>         overflows.\n");
>         +                       platform_timer_count = i;
>
>
>     Fix firmware bug in the kernel ? No. Up to the firmware to fix it,
>     "no handy, no candy".
>
>
> So you are suggesting that if we find this firmware bug, just return
> error instead of using the info in a problematic table, right?

Yes. Let's imagine the following scenario. The firmware is tested on a 
system with this code. The system boots. Ok, the firmware is working. 
Green light, the firmware is delivered.

After a while someone notice "firmware bug, subtable pointer overflows" 
but nobody cares because 'it works for me'.

After a while again, someone notice the ACPI table is partially used and 
there is a subtle bug with the watchdog. Too late, the hardware is 
already delivered and nobody wants the user to upgrade the firmware.

At the end, we have bogus firmware, hence bogus system, unfixable 
because the kernel allowed that.

If the kernel is permissive with firmware bugs, those bugs won't be 
spotted in time or will be ignored because the kernel is giving the 
illusion everything is fine.

If the kernel is strict and find an inconsistency in the firmware, then 
it can just prevent the feature to work at all and force the "tester" to 
fix the bug for the firmware before releasing it.

>         +                       break;
>         +               }
>         +               header = (struct acpi_gtdt_header *)platform_timer;
>         +               if (header->type == type) {
>         +                       ret = handler(platform_timer, index, data);
>         +                       if (ret)
>         +                               pr_err("failed to handler
>         subtable %d.\n", i);
>         +                       else
>         +                               index++;
>         +               }
>         +               platform_timer += header->length;
>
>
>     That is not correct. This function is setting the platform_timer
>     pointer to the end. Even if that works, it violates the
>     encapsulation paradigm. Regarding how are used those global
>     variables, please kill them and use proper parameter and structure
>     encapsulation.
>
>
>
> So let me explain this a little:
> "void *platform_timer = platform_timer_struct;" is getting the pointer
> of first Platform Timer Structure, platform_timer_struct in this
> patchset is a global variable, but platform_timer is a local variable in
> the for_platform_timer function.
>
> Platform Timer Structure Field is a array of Platform Timer Type structures.
> And the length of each structure maybe different, so I think
> "platform_timer += header->length" is a right approach to move on to
> next Platform Timer structures
>
> Do I misunderstand your comment? or maybe I miss something?

No. I mixed platform_timer and platform_timer_struct. I thought 
platform_timer was the global variable. So far, the function is correct.

>         +/*
>         + * Get some basic info from GTDT table, and init the global
>         variables above
>         + * for all timers initialization of Generic Timer.
>         + * This function does some validation on GTDT table, and will
>         be run only once.
>         + */
>         +static void __init platform_timer_init(struct acpi_table_header
>         *table,
>         +                                      struct acpi_table_gtdt *gtdt)
>         +{
>         +       gtdt_end = (void *)table + table->length;
>         +
>         +       if (table->revision < 2) {
>         +               pr_info("Revision:%d doesn't support Platform
>         Timers.\n",
>         +                       table->revision);
>         +               return;
>         +       }
>
>
>     This check should be called much sooner, before entering the gtdt
>     subsystems. It is too late here.
>
>
> the reason I check table revision here is that:
> the difference between revision 1 and 2 is revision-2 adds Platform
> Timer Structure support.
> and this init function is just for getting some basic Platform Timer
> info in "main" table.
> So at the beginning of this function I check the revision.
>
> But it also makes sense to move this out to gtdt_arch_timer_init like this:
>
> if (table->revision < 2)
> return 0;
> else
> platform_timer_init(table, gtdt);
>
> Any suggestion??


You should think about the API and what kind of data this subsystem is 
dealing with.

There is here:

1. timer
2. watchdog
3. mem timers
4. acpi table
5. gtdt table

The watchdog code calls if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 
0, &table))) to get the acpi table pointer. But timer and mem timer 
functions don't have this.

Actually, we are not interested in the acpi table except for the 
revision and the length.

Coming back to my initial suggestion: write all the gtdt code first 
without timers and watchdog. Define a clear API dealing with *gtdt 
structures only* and then build timers and wd on top.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
