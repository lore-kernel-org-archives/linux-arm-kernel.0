From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Jun 2010 16:01:35 +0800
Subject: Samsung SoCs: preparation for single kernel
In-Reply-To: <002301cb129c$ec59fe30$c50dfa90$%szyprowski@samsung.com>
References: <AANLkTinGwWzIAOe2tj6V2kCrMiPT7PHlYs1kFS-IsiN4@mail.gmail.com>
	<AANLkTil-AOEqhMOXydaiA1X_v0rjoNQxALrO0UY638AS@mail.gmail.com>
	<AANLkTil1i_ZGI8bY14HhjrAk9RooVreAJsTteqqrMgqJ@mail.gmail.com>
	<AANLkTikDml6gQAsiRrCjIt4bUD3hnpAATr1erqCGOJMd@mail.gmail.com>
	<002301cb129c$ec59fe30$c50dfa90$%szyprowski@samsung.com>
Message-ID: <AANLkTikspf9zHuSKe86wDQxI12HpJo_occBlLUXBkjef@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 2:25 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On Wednesday, June 23, 2010 3:55 AM Eric Miao wrote:
>
>> ...
>
>> >>> e.g., cpu_is_* usage at OMAP tree
>> >>>
>> >>> static void omap_init_mcspi(void)
>> >>> {
>> >>> ? ? ? ?if (cpu_is_omap44xx())
>> >>> ? ? ? ? ? ? ? ?omap4_mcspi_fixup();
>> >>>
>> >>> ? ? ? ?platform_device_register(&omap2_mcspi1);
>> >>> ? ? ? ?platform_device_register(&omap2_mcspi2);
>> >>>
>> >>> ? ? ? ?if (cpu_is_omap2430() || cpu_is_omap343x() || cpu_is_omap44xx())
>> >>> ? ? ? ? ? ? ? ?omap2_mcspi3_init();
>> >>>
>> >>> ? ? ? ?if (cpu_is_omap343x() || cpu_is_omap44xx())
>> >>> ? ? ? ? ? ? ? ?omap2_mcspi4_init();
>> >>> }
>> >>
>> >> Just my two cents: cpu_is_*() can be used, but only when absolutely
>> necessary.
>> >> The s3c does a CPU detection at startup, so I guess the usage of
>> cpu_is_*()
>> >> can be even reduced.
>> >
>> > My concern is that most device resources use the S3C_* or S5P_* prefix
>> > and defined at each arch differently.
>> >
>> > E.G., mmc resource drivers use the S3C_PA_HSMMC0. but each mach has
>> > different base address.
>> > then how to handle this or make it possible?
>> >
>>
>> Now you have
>>
>> s5pv210_device_hsmmc0
>> s5pc100_device_hsmmc0
>> s3c64xx_device_hsmmc0
>> ....
>>
>> each with a different base.
>
> There is no need for such code duplication.

However, I believe this is the right way to go. A certain level of
duplication is the price to pay for a generic and clean solution.

When a peripheral controller or IP is moved from one SoC to the
next generation, there are several things could have been changed:

1. new base address and IRQ number
2. fixes and enhancements to the original IP

1. will result in a different 'struct resource', and 2. will result in a
different 'struct platform_device' with a different name, so the driver
can match the platform_device_id table as you agreed I'm right on
that recommendation.

They are actually _two_ different devices.

> Ben is working on a solution for
> a single kernel which supports multiple SoCs. Some of his work in progress can
> be found here: git://git.fluff.org/bjdooks/linux branch wip-samsung-dev and
> wip-samsung-dev2.

Could you describe it a bit here and bring it on table for discussion?

PS: My feeling of commenting several of the samsung patches so far turns
out to be quite frustrated, or I'm just too sensitive. NOTE neither am I
NAKing Samsung patches, nor am I interested to be involved, I'm just givin
my suggestions.
