From: robherring2@gmail.com (Rob Herring)
Date: Mon, 8 Sep 2014 13:25:34 -0500
Subject: [PATCH v2 1/4] arm64, thunder: Add Kconfig option for Cavium
 Thunder SoC Family
In-Reply-To: <20140908110131.GX4703@rric.localhost>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
 <7863371.EMkUuntQWU@wuerfel> <20140905142245.GG20164@leverpostej>
 <2952834.1P42roDKD9@wuerfel> <20140908110131.GX4703@rric.localhost>
Message-ID: <CAL_JsqLgimdX0Ff4Wsyx68-8NaFDx=0CN36qnLUtXNTicybAgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 8, 2014 at 6:01 AM, Robert Richter <rric@kernel.org> wrote:
> On 05.09.14 18:25:35, Arnd Bergmann wrote:
>> On Friday 05 September 2014 15:22:46 Mark Rutland wrote:
>> >
>> > > A common pattern these days is to do dependencies like
>> > >
>> > > arch/*/Kconfig:
>> > >       config ARCH_FOO
>> > >       bool "Enable support for Foo platform"
>> > >       help
>> > >         ...
>> > >
>> > >
>> > > drivers/*/Kconfig
>> > >       config SUBSYS_FOO
>> > >       bool "SUBSYS driver for Foo"
>> > >       depends on ARCH_FOO || COMPILE_TEST
>> > >       depends on OF && REGULATOR && GENERIC_PHY # or whatever
>> >
>> > Russell's comments w.r.t. Kconfig warnings when config names change
>> > still holds regardless of select vs depends on.
>>
>> Yes, that's what I wrote in my reply as well.
>>
>> > > That way we can enable everything in the defconfig, but someone
>> > > who likes to build a more specialized kernel can disable the
>> > > other platforms and won't get the drivers that are specific to
>> > > those.
>> > >
>> > > I personally think this is a bit more verbose than what we need, but
>> > > I don't strongly object doing it that way.
>> >
>> > You'd still be able to do this without ARCH_FOO, though you would need
>> > to know which drivers are necessary for a particular SoC. That seems to
>> > be the way things are handled on x86; I don't recall having to select
>> > support for specific machines there, just the individual drivers.
>
> This is well hidden on x86, but each vendor has a config option. For
> AMD systems we have had our own option to disable vendor specific
> code, see CPU_SUP_AMD for example. Disabling this will remove all AMD
> specific code in the kernel. Of course this is enabled per default.
>
> With ARCH_THUNDER I intended to do the same (you could name this also
> SOC_SUP_CAVIUM or so but I kept the current naming scheme). In patch
> 4/4 I have added the option to defconfig. This enables this per
> default and nobody has to deal with any option manually, just running
> make defconfig is fine.
>
> Also, at least to disable building the dtb file for foo, you will need
> ARCH_FOO too. How else would you deal with dtb files then?

dtb builds are quick and don't affect the image size at all.
Personally, I would prefer to see all dtb's get built for the dtbs
rule. You can still specify the specific dtb you want in the case of
only caring about 1 platform.

Rob
