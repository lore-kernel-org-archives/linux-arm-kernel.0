From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Fri, 25 May 2018 09:59:16 -0700
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: Make sure SD1_WP is low
In-Reply-To: <1527257797.3472.8.camel@pengutronix.de>
References: <20180525030153.15986-1-andrew.smirnov@gmail.com>
 <1527257797.3472.8.camel@pengutronix.de>
Message-ID: <CAHQ1cqFWm-A2rkLr+LPqvp_eipG9VV01TY4innXqABaYuKbXDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 7:16 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Donnerstag, den 24.05.2018, 20:01 -0700 schrieb Andrey Smirnov:
>> Make sure that MX51_PAD_GPIO1_1 does not remain configure as
>> ALT0/SD1_WP (it is out of reset). This is needed because of external
>> pull-up resistor attached to that pad that, when left unchanged, will
>> drive SD1_WP high preventing eSDHC1/eMMC from working correctly.
>>
>> To fix that add a pinmux configuration line configureing the pad to
>> function as a GPIO. While we are at it, add a corresponding input GPIO
>> hog in an effort to minimize current consumption.
>
> Enabling the input part of the pad also consumes (a small amount of)
> power, if you are after minimizing power consumption, better configure
> the pin as output and drive it in the pull direction.
>

Sure, sounds good, will do in v2.

>>
>> > Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
>> > Cc: Shawn Guo <shawnguo@kernel.org>
>> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> > Cc: Lucas Stach <l.stach@pengutronix.de>
>> > Cc: Chris Healy <cphealy@gmail.com>
>> > Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  arch/arm/boot/dts/imx51-zii-rdu1.dts | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
>> index df9eca94d812..d484e7e46b27 100644
>> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
>> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
>> @@ -476,6 +476,17 @@
>> >     status = "okay";
>>  };
>>
>> +&gpio1 {
>> > +   unused-sd3-wp-gpio {
>> > +           /*
>> > +            * See pinctrl_esdhc1 below for more details on this
>> > +            */
>> > +           gpio-hog;
>> > +           gpios = <1 GPIO_ACTIVE_HIGH>;
>> > +           input;
>> > +   };
>> +};
>> +
>>  &i2c2 {
>> >     pinctrl-names = "default";
>> >     pinctrl-0 = <&pinctrl_i2c2>;
>> @@ -660,6 +671,23 @@
>> > >                   MX51_PAD_SD1_DATA1__SD1_DATA1           0x20d5
>> > >                   MX51_PAD_SD1_DATA2__SD1_DATA2           0x20d5
>> > >                   MX51_PAD_SD1_DATA3__SD1_DATA3           0x20d5
>> > +                   /*
>> > +                    * GPIO1_1 is not directly used by eSDHC1 in
>> > +                    * any capacity, but earlier versions of RDU1
>> > +                    * used that pin as WP GPIO for eSDHC3 and
>> > +                    * because of that that pad has an external
>> > +                    * pull-up resistor. This is problematic
>> > +                    * because out of reset the pad is configured
>> > +                    * as ALT0 which serves as SD1_WP, which, when
>> > +                    * pulled high by and external pull-up, will
>> > +                    * inhibit execution of any write request to
>> > +                    * attached eMMC device.
>> > +                    *
>> > +                    * To avoid this problem we configure the pad
>> > +                    * to ALT1/GPIO and avoid driving SD1_WP
>> +                      * signal high.
>
> Applying the patch complains about whitespace damage in the above 2
> lines.
>

My bad, sorry about that, will fix in v2.

Thanks,
Andrey Smirnov
