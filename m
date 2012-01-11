From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 11 Jan 2012 16:21:57 +0530
Subject: [PATCH] backlight: lcd: add driver for raster-type lcd's with
 gpio controlled panel reset
In-Reply-To: <20120107172826.GA355@opensource.wolfsonmicro.com>
References: <1325778146-27056-1-git-send-email-thomas.abraham@linaro.org>
 <4F05F509.6020405@metafoo.de>
 <20120106064929.GB3496@opensource.wolfsonmicro.com>
 <CAJuYYwRxuZAm_JpLw1fN2ypnFc6TocH6veRmCeuqENvZHSz3kg@mail.gmail.com>
 <20120107172826.GA355@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwSuDzUWgnSJHO0vwjYH7zscC9=j_=JuOUuJy9shHpPUuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 7 January 2012 22:58, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jan 07, 2012 at 04:34:34PM +0530, Thomas Abraham wrote:
>> On 6 January 2012 12:19, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>>> +       if (lcd_enable) {
>>>+               if ((pd->min_uV || pd->max_uV) &&
>>>+                       regulator_set_voltage(lp->regulator,
>>>+                                               pd->min_uV, pd->max_uV))
>>>+                               dev_info(lp->dev,
>>>+                                       "regulator voltage set failed\n");
>>>+               if (regulator_enable(lp->regulator))
>>>+                       dev_info(lp->dev, "failed to enable regulator\n");
>>>+       } else {
>>>+               regulator_disable(lp->regulator);
>>>+       }
>
>> > In principle it should be specified in both places to account for shared
>> > supplies though for all practical purposes for an LCD panel I can't see
>> > multiple users sharing the same regulator and varying the voltage at
>> > runtime.
>
>> It is assumed here that the boot loader as not set the output voltage
>> of the regulator that supports variable voltage ranges. So these
>> values help in setting up the regulator for LCD display.
>
> Remember that the regulator API won't allow consumers to configure
> voltages unless there are constraints granting permission. ?Users will
> need to set both the LCD vales and the regulator constraints values to
> actually allow configuration to happen.

In the case of Exynos4 based Origen board, buck7 of max8997 supplies
power to the lcd panel. buck7 is capable of supplying power at
different voltage levels but for Origen board, it is required to
supply only 3.3V. The constraints for buck7 can specify 'apply_uV' and
this will ensure that buck7 is configured to supply 3.3V.

But 'apply_uV' seems to be not ideal for regulators that supply power
to lcd panels. It would be better to power lcd panels only when video
data has to be displayed.

If 'apply_uV' is not used, then regulator_enable() does not set the
correct output voltage. So regulator_set_voltage() call is required.
If the regulator does not support multiple voltage ranges, then in the
above code min_uV and max_uV should be zero which then bypasses
regulator_set_voltage().

Hence, the call to regulator_set_voltage() is required in the above
code fragment.

Thanks,
Thomas.
