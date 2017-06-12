From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 Jun 2017 11:23:37 +0200
Subject: [PATCH 1/2] spi: rockchip: add support for "cs-gpios" dts property
In-Reply-To: <593E5AF8.1080404@rock-chips.com>
References: <1497248057-16550-1-git-send-email-jeffy.chen@rock-chips.com>
 <4418523.E0t9k04HOG@diego> <593E5AF8.1080404@rock-chips.com>
Message-ID: <2280770.UMxRo5IhGO@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 12. Juni 2017, 17:12:24 CEST schrieb jeffy:
> Hi Heiko,
> 
> thanx for your comments.
> 
> On 06/12/2017 04:36 PM, Heiko St?bner wrote:
> > Am Montag, 12. Juni 2017, 16:26:07 CEST schrieb jeffy:
> >> Hi Shawn,
> >> 
> >> On 06/12/2017 03:15 PM, Shawn Lin wrote:
> >>> Hi Jeffy,
> >>> 
> >>> On 2017/6/12 14:14, Jeffy Chen wrote:
> >>>> Support using "cs-gpios" property to specify cs gpios.
> >>>> 
> >>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> >>>> ---
> >>>> 
> >>>>    .../devicetree/bindings/spi/spi-rockchip.txt       |  2 +
> >>>>    drivers/spi/spi-rockchip.c                         | 52
> >>>> 
> >>>> ++++++++++++++++++++++
> >>>> 
> >>>>    2 files changed, 54 insertions(+)
> >>>> 
> >>>> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> >>>> b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> >>>> index 83da493..02171b2 100644
> >>>> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> >>>> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> >>> 
> >>> The changes for doc should be another patch, and...
> >> 
> >> but i saw others didn't separate them:
> >> cf9e478 spi: sh-msiof: Add slave mode support
> >> 23e291c spi: rockchip: support "sleep" pin configuration
> > 
> > it sometimes falls through the cracks, but having dt-binding patches
> > separate is meant to make it easier on DT-Maintainers to find
> > patches they need to look at.
> 
> ok, will do.
> 
> >>>> +    if (!data->cs_gpio_requested) {
> >>>> +        ret = gpio_request_one(spi->cs_gpio, flags,
> >>>> +                       dev_name(&spi->dev));
> >>>> +        if (!ret)
> >>>> +            data->cs_gpio_requested = 1;
> >>>> +    } else
> >>>> +        ret = gpio_direction_output(spi->cs_gpio, flags);
> >>> 
> >>> need brace around 'else' statement. Also I don't see data used
> >>> elsewhere, so you need these code above.
> >> 
> >> ok.
> >> and the cs_gpio_requested is to mark cs_gpio requested, because the
> >> setup func might be called multiple times, we only need to request gpio
> >> at the first time.
> > 
> > Aren't the gpiod* functions meant to be used for new things?
> > Also you might actually do a bit of error handling there, especially
> > EPROBE_DEFER.
> 
> so you are suggesting to use gpiod* functions here to replace gpio_*
> functions right?

correct. And handle errors that may get returned, especially EPROBE_DEFER,
but also other errors may indicate that your spi won't function as expected.


Heiko
