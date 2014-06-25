From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 25 Jun 2014 20:29:42 +0900
Subject: [PATCH 1/3 v5] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <CAD=FV=Ua+P0CBAfNj4SWWMWRKcEFdmh=akwy1-ZWoGOt2P9=cQ@mail.gmail.com>
References: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
 <CAD=FV=Ua+P0CBAfNj4SWWMWRKcEFdmh=akwy1-ZWoGOt2P9=cQ@mail.gmail.com>
Message-ID: <03a101cf9068$c2378250$46a686f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson wrote:
> 
> Mark or Kukjin,
> 
Hi,

> On Thu, Jun 12, 2014 at 8:59 PM, Naveen Krishna Chatradhi
> <ch.naveen@samsung.com> wrote:
> > Since, (3146bee spi: s3c64xx: Added provision for dedicated cs pin)
> >
> > spi-s3c64xx.c driver expects
> > 1. chip select gpios from "cs-gpio"(singular) under the
> >    "controller-data" node of the client/slave device of the SPI.
> >
> > 2. "cs-gpio"(singular) entry to be present in the SPI device node.
> >
> > Eg of current broken usage:
> > &spi_1 {
> >         cs-gpio <>;     /* this entry is checked during probe */
> >         ...
> >         slave_node {
> >                 controller-data {
> >                         cs-gpio <&gpioa2 5 0>;
> >                         /* This field is parsed during .setup() */
> >                 }
> >         };
> > };
> >
> > The following dts files which were using this driver. But,
> > din't have the "cs-gpio" entry under SPI node.
> > -- arch/arm/boot/dts/exynos4210-smdkv310.dts
> > -- arch/arm/boot/dts/exynos4412-trats2.dts
> > -- arch/arm/boot/dts/exynos5250-smdk5250.dts
> >
> > Also, the SPI core and many drivers moved on to using "cs-gpios"
> > from SPI node and removed the gpio handling code from drivers
> > (including spi-s3c64xx.c).
> >
> > Hence, spi-s3c64xx.c is broken since "Jun 21 11:26:12 2013" and
> > considering the time with no compliants about the breakage.
> >
> > We are assuming it is safe to remove the "cs-gpio"(singular) usage
> > from device tree binding of spi-samsung.txt and makes appropriate
> > changes in the driver to use "cs-gpios"(plural) from
> > SPI device node.
> >
> > Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > Tested-by: Doug Anderson <dianders@chromium.org>
> > Cc: Tomasz Figa <t.figa@samsung.com>
> > ---
> > Changes since v4:
> > 1. Added reviewed by from Javier and Tested by from Doug
> >
> > Changes since v3:
> > 1. Remove the sdd->cs_gpio and use gpio_is_valid(spi->cs_gpio) instead
> > 2. Keep cs->line only for Non-DT platforms and use spi->cs_gpio
> >    for DT platforms
> >
> >  .../devicetree/bindings/spi/spi-samsung.txt        |    8 ++--
> >  drivers/spi/spi-s3c64xx.c                          |   41 ++++++++------------
> >  2 files changed, 20 insertions(+), 29 deletions(-)
> 
> Is one of you two planning to apply (parts 1 and 2)?  I know that
> Kukjin needs to handle the part 3 (the .dts files)...
> 
Once Mark takes spi driver related patches, I will pick DT related patches into
samsung tree.

> Ideally it seems like it could go to 3.16 since it is a bugfix...
> 
I think so but it depends on Mark's comments ;-)

Thanks,
Kukjin
