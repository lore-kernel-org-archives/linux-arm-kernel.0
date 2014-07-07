From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 7 Jul 2014 13:22:26 +0200
Subject: [PATCH 1/3 v5] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <CAHfPSqAf3z9otNJivw5W7oKdRbU085+AWxCMAh8ORh=GkiNiXw@mail.gmail.com>
References: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
 <20140702165651.GK410@sirena.org.uk>
 <CAHfPSqAXs=5VLLEV-XVw5YJo=-9QFn9KA8oG_A0CfNykcVwnCQ@mail.gmail.com>
 <20140707073244.GC30458@sirena.org.uk>
 <CAHfPSqAf3z9otNJivw5W7oKdRbU085+AWxCMAh8ORh=GkiNiXw@mail.gmail.com>
Message-ID: <CABxcv=mw0ma3MQPsR5sGU7UcORehyyhqOtQ_SUwCNr4kpsK-7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Naveen and Mark,

On Mon, Jul 7, 2014 at 10:31 AM, Naveen Krishna Ch
<naveenkrishna.ch@gmail.com> wrote:
> Hello Mark,
>
> On 7 July 2014 13:02, Mark Brown <broonie@kernel.org> wrote:
>> On Mon, Jul 07, 2014 at 11:51:38AM +0530, Naveen Krishna Ch wrote:
>>> On 2 July 2014 22:26, Mark Brown <broonie@kernel.org> wrote:
>>> > On Fri, Jun 13, 2014 at 09:29:50AM +0530, Naveen Krishna Chatradhi wrote:
>>
>>> >> Hence, spi-s3c64xx.c is broken since "Jun 21 11:26:12 2013" and
>>> >> considering the time with no compliants about the breakage.
>>
>>> > I'm not clear what the breakage is?  Some boards are broken but what's
>>> > the driver issue?
>>
>>> ToT was broken for few boards
>>> exynos4412-trats2.dts, exynos4210-smdkv310.dts and exynos5250-smdk5250.dts
>>
>>> With some DTS changes SPI works well, spi-s3c64xx.c driver had no issues.
>>

Correct me if I'm wrong but I think that the driver does have issues
since the commit mentioned (3146bee) broke DT backward compatibility.

>> No, you're not answering my question - to repeat, what is the breakage?
>

As far as I understand, the breakage is that any DTS that followed the
DT binding documented in
Documentation/devicetree/bindings/spi/spi-samsung.txt is not working
with the current driver. So is not that some boards are broken, is
that the driver is broken and it has been broken for more than a year
(the commit date is Jun 21 2013).

> The Documentation/devicetree/bindings/spi/spi-samsung.txt
> describes "cs-gpio" as a controller specific property.
>
> The dts entries for SPI in exynos4412-trats2.dts, exynos4210-smdkv310.dts
> and exynos5250-smdk5250.dts boards have the "cs-gpio" property defined
> under controller-data node, which is inside the SPI device node
> &spi_1 {
>   controller-data {
>     cs-gpio = <>;
>   };
> };
>
> But, _probe() of spi-s3c64xx.c driver looks for "cs-gpio" in the SPI
> device node and
> sets a flag "sdd->cs_gpio = false" (If the property is not available)
> &spi_1 {
>   cs-gpio = <>;
> };
>
> the sdd->cs_gpio flag is checked before actually getting the gpios
> from the controller-data node
>        if (sdd->cs_gpio)
>                 cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
>

I think that if changing the binding is not possible, at least we
should document this new "cs-gpio" property that is looked in the top
level SPI node after commit 3146bee and also revert the default in
order to allow DTs using the old binding to keep working.

By default not having the "cs-gpio" property in the SPI dev node
should mean that the "cs-gpio" property in the controller-data node
should be used to signal the chip-select and having the "cs-gpio"
property in the SPI node should mean that the native chip select
should be used instead of a GPIO. That preserves the old DT binding
semantic while making the GPIO to be optional.

Of course in that case the property name does not make too much sense,
so probably should be changed to "cs-native" or something like that.
But I still don't understand why this is needed in the first place
since according to Documentation/devicetree/bindings/spi/spi-bus.txt
you can use the cs-gpios property to specify that a native chip-select
will be used instead of a GPIO by doing:

cs-gpios = <&gpio1 0 0> <0>

cs0 : &gpio1 0 0
cs1 : native

> Hence, SPI was failing on those boards.
>
> 1. As the SPI core and several drivers were changed to work with
>     DT property "cs-gpios" (plural) defined under SPI node.
> 2. Since the commit 3146beec21b64f4551fcf0ac148381d54dc41b1b
>     "spi: s3c64xx: Added provision for dedicated cs pin"
>     Dated:   Fri Jun 21 11:26:12 2013 +0530
>
> For the above 2 reasons, It was decided to drop the backward compatibility
> of using "cs-gpio"(singular) in controller-data.
> Instead, start supporting "cs-gpios"(plural) in the SPI node.
>

Right, since the DT binding has been broken for a year and because is
not consistent with the bindings used by all other SPI drivers, many
agreed that it was one of the exceptional cases where the DT binding
can be rethought and changed to use the generic "cs-gpios" property
already supported by SPI core. It breaks backward compatibility that's
true but the DT binding has been broken anyways and nobody noticed
before.

The other option is what I said above, fixing the DT binding
compatibility breakage while keeping the custom binding for this SPI
driver.

>>
>>> > Also I'd need to check but are you sure that GPIO 0 is not valid?
>>
>>> gpio_is_valid() returns true for
>>> "number >= 0 && number < ARCH_NR_GPIOS"
>>
>> Right, so this means that any board that is using the internal chip
>> select with zero as default in their platform data is broken by this
>> change.
>

I think this problem could be present in other SPI drivers as well? So
maybe the right fix for this is to convert the SPI core gpio handling
to use the new descriptor-based gpio API instead of the integer-base
one?

> using gpio_is_valid() to "sdd->cs_gpio" flag every where to check for the
> validity was a review comment.
> Which seems to fail for internal chip select with zero.
>
> I can submit another version with"sdd->cs_gpio" flag for this purpose.
>
> --
> Thanks & Regards,
> (: Nav :)
> --

Best regards,
Javier
