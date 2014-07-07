From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Mon, 7 Jul 2014 14:01:44 +0530
Subject: [PATCH 1/3 v5] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <20140707073244.GC30458@sirena.org.uk>
References: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
 <20140702165651.GK410@sirena.org.uk>
 <CAHfPSqAXs=5VLLEV-XVw5YJo=-9QFn9KA8oG_A0CfNykcVwnCQ@mail.gmail.com>
 <20140707073244.GC30458@sirena.org.uk>
Message-ID: <CAHfPSqAf3z9otNJivw5W7oKdRbU085+AWxCMAh8ORh=GkiNiXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 7 July 2014 13:02, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 07, 2014 at 11:51:38AM +0530, Naveen Krishna Ch wrote:
>> On 2 July 2014 22:26, Mark Brown <broonie@kernel.org> wrote:
>> > On Fri, Jun 13, 2014 at 09:29:50AM +0530, Naveen Krishna Chatradhi wrote:
>
>> >> Hence, spi-s3c64xx.c is broken since "Jun 21 11:26:12 2013" and
>> >> considering the time with no compliants about the breakage.
>
>> > I'm not clear what the breakage is?  Some boards are broken but what's
>> > the driver issue?
>
>> ToT was broken for few boards
>> exynos4412-trats2.dts, exynos4210-smdkv310.dts and exynos5250-smdk5250.dts
>
>> With some DTS changes SPI works well, spi-s3c64xx.c driver had no issues.
>
> No, you're not answering my question - to repeat, what is the breakage?

The Documentation/devicetree/bindings/spi/spi-samsung.txt
describes "cs-gpio" as a controller specific property.

The dts entries for SPI in exynos4412-trats2.dts, exynos4210-smdkv310.dts
and exynos5250-smdk5250.dts boards have the "cs-gpio" property defined
under controller-data node, which is inside the SPI device node
&spi_1 {
  controller-data {
    cs-gpio = <>;
  };
};

But, _probe() of spi-s3c64xx.c driver looks for "cs-gpio" in the SPI
device node and
sets a flag "sdd->cs_gpio = false" (If the property is not available)
&spi_1 {
  cs-gpio = <>;
};

the sdd->cs_gpio flag is checked before actually getting the gpios
from the controller-data node
       if (sdd->cs_gpio)
                cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);

Hence, SPI was failing on those boards.

1. As the SPI core and several drivers were changed to work with
    DT property "cs-gpios" (plural) defined under SPI node.
2. Since the commit 3146beec21b64f4551fcf0ac148381d54dc41b1b
    "spi: s3c64xx: Added provision for dedicated cs pin"
    Dated:   Fri Jun 21 11:26:12 2013 +0530

For the above 2 reasons, It was decided to drop the backward compatibility
of using "cs-gpio"(singular) in controller-data.
Instead, start supporting "cs-gpios"(plural) in the SPI node.

>
>> > Also I'd need to check but are you sure that GPIO 0 is not valid?
>
>> gpio_is_valid() returns true for
>> "number >= 0 && number < ARCH_NR_GPIOS"
>
> Right, so this means that any board that is using the internal chip
> select with zero as default in their platform data is broken by this
> change.

using gpio_is_valid() to "sdd->cs_gpio" flag every where to check for the
validity was a review comment.
Which seems to fail for internal chip select with zero.

I can submit another version with"sdd->cs_gpio" flag for this purpose.

-- 
Thanks & Regards,
(: Nav :)
