From: lznuaa@gmail.com (Frank Li)
Date: Tue, 13 Nov 2012 16:12:14 +0800
Subject: [PATCH 1/1] regulator: gpio-regulator: fix crash when no states
 property in dt
In-Reply-To: <20121113075733.GN18224@opensource.wolfsonmicro.com>
References: <1352450076-22682-1-git-send-email-Frank.Li@freescale.com>
 <20121109165609.GV23807@opensource.wolfsonmicro.com>
 <CAHrpEqSbydeAHngL-NMfQa1HQUsj0US5u=aK6y-ku0DMOW-KkA@mail.gmail.com>
 <20121113075733.GN18224@opensource.wolfsonmicro.com>
Message-ID: <CAHrpEqTF80XyRD8ZTDGLs+AywznGNdvZfndfWSuw+pJ-D24Rxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/13 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Nov 12, 2012 at 09:56:47AM +0800, Frank Li wrote:
>> 2012/11/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>> > On Fri, Nov 09, 2012 at 04:34:36PM +0800, Frank Li wrote:
>
>> >>       /* Fetch states. */
>> >>       prop = of_find_property(np, "states", NULL);
>> >> -     proplen = prop->length / sizeof(int);
>> >> +     proplen = prop ? prop->length / sizeof(int) : 0;
>
>> > Aren't states mandatory for this driver, in which case shouldn't the
>> > probe fail here?
>
>> I think No.  GPIO-Regulator can be used as just turn on/off power
>> domain and not adjust voltage or current.  So "states" is option.
>> "gpios" was already options.
>
> Are you sure this actually works?  I glanced at the code and wasn't
> convinced it was taking sufficient care to cope with this possibility.
> Normally people use a fixed regulator for a regulator with a simple
> on/off switch (which allows the voltage to be specified which this
> won't...) so I'd be somewhat surprised if it were tested.

Yes, I tested it.
I use gpio-enable to turn on\off a sensor power switcher.
the below is a part of my dt file.

+                               mma8451 at 1c {
+                                       compatible = "fsl,mma8451";
+                                       reg = <0x1c>;
+                                       vdd-supply = <&sensor>;
+                                       vddio-supply = <&sensor>;
+                               };
+                       };
                };
        };
+       sensor: gpio-regulator {
+               compatible = "regulator-gpio";
+               regulator-name = "sensor-supply";
+               enable-gpio = <&gpio2 31 1>;
+               enable-active-high;
+               regulator-type = "voltage";
+       };

best regards
Frank Li
