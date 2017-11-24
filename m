From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 24 Nov 2017 12:05:37 +0000
Subject: [RFC PATCH 0/3] pinctrl: sunxi: Add DT-based generic pinctrl
 driver
In-Reply-To: <CACRpkdYFoUmGJYdKz0t9gsrkK=u8-oJjaRBXtNYHaUt9kSa3_g@mail.gmail.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <CACRpkdYFoUmGJYdKz0t9gsrkK=u8-oJjaRBXtNYHaUt9kSa3_g@mail.gmail.com>
Message-ID: <54ecfdf7-cf4a-3eae-2661-47fa668a6066@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24/11/17 10:28, Linus Walleij wrote:
> On Mon, Nov 13, 2017 at 2:25 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> so far the pinctrl driver for supporting a particular Allwinner SoC requires
>> a hardcoded table in the kernel code.
> (...)
>> This series here moves the data encoded in the table so far into the DT itself,
>> removing the need for a hardcoded table in the kernel.
> (...)
> 
> The DT maintainers have been pretty clear on that they don't like
> using the the DT as a generic fit-all information dump. They
> prefer to look up hardware data from per-soc compatible strings.
> 
> I have been sceptic about it too, on the grounds that I think it
> make configuration and multiplatform kernels easy, while making
> debugging and reading code+device tree hard, also affecting
> maintenance cost.
> 
> I'd like to have Maxime's buy-in before we progress and also some
> discussion on these themes in general.

Indeed this was one of the goals of this series. I can understand were
we came from and that we had those in-kernel tables in the past.
I am just a bit worried that with Allwinner recently playing the SKU
game we end up with tons of tables for only slightly different SoCs (see
the H3 and H5, for instance). And with single image kernels we pile up
quite some *data* in each kernel, which is of little interest for
everyone else.

Also my understanding is that the actual Allwinner pin controller IP
(register map) is very much the same across all SoCs. Mostly the only
difference is the mapping between pins and mux functions, which we
express in the DT already anyway (in the subnodes). And this is really a
poster book example of what DT should be doing: express the specific
mappings of a particular implementation. I don't see why this would need
to be per-board only, if we can pull this up to the SoC level.

>> The approach taken here is to parse the DT and generate the table with
>> the help of additional properties, then hand this table over to the existing
>> driver. This is covered by three basic extensions to the DT binding:
> 
> I adressed this in the bindings patch.
> 
>> The benefit of this series is two-fold:
>> - Future SoCs don't need an in-kernel table anymore. They can describe
>>   everything in the DT,
> 
> It can be debated whether that is really a good thing or actually
> a bad thing for the reasons stated above.

The point is that we already rely on the DT anyway, just that we use a
*string* to specify a certain mux function. The in-kernel table just
maps this to an actual SoC-specific register value. I think the GPIO
subsystem needs the name, hence I am just adding the pinmux property.

> Also an additional bad thing is inconsistency between different
> SoCs.

Well, does that mean that we should never change anything? Consistency
is nice, but should not be an excuse for not improving things. And I
tried to embrace the existing driver by designing this on top of it.

> What we have in the kernel for all-DT is pinctrl-single.c.
> 
> This exists for the case where there is exactly one register per
> pin and all you have is strange macro files from the ASIC people
> that noone understands. OMAP and HiSilicon is using this.
> It's a compromise, I'm not super-happy with that driver at all times
> but it is for a very strongly specified case.
> 
> Would it be possible for you guys to simply use/embrace/extend
> pinctrl-single.c if you want to go this route?

Thanks for the pointer, I will have a look.

> Any higher order of complexity than "one register per pin" I think
> is better handled by open coding it than trying to push things into
> the device tree, because of readability, debuggability and maintenance
> issues.

I don't see how this binding would make this worse.

Cheers,
Andre.
