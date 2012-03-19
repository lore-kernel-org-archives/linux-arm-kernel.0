From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 19 Mar 2012 12:37:41 +0530
Subject: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
In-Reply-To: <16771402.10791332119314036.JavaMail.weblogic@epv6ml07>
References: <16771402.10791332119314036.JavaMail.weblogic@epv6ml07>
Message-ID: <CAMQu2gy6yzawMAnkK+qmijDNo-5618b5SR7Cr+puMLSRM2znUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/3/19 ??? <myungjoo.ham@samsung.com>:
>
> Kyungmin Park<kmpark@infradead.org> 2012-03-17 15:10 (GMT+09:00)
>> Hi,
>> On 3/17/12, Aneesh V wrote:
>> > Add a driver for the EMIF SDRAM controller used in TI SoCs
>> >
>> > EMIF is an SDRAM controller that supports, based on its revision,
>> > one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds support
>> > for LPDDR2.
>> >
>> > The driver supports the following features:
>> > - Calculates the DDR AC timing parameters to be set in EMIF
>> >   registers using data from the device data-sheets and based
>> >   on the DDR frequency. If data from data-sheets is not available
>> >   default timing values from the JEDEC spec are used. These
>> >   will be safe, but not necessarily optimal
>> > - API for changing timings during DVFS or at boot-up
>
> This means that you alreeady have callbacks to create a devfreq device driver that supports DVFS on the device. This doesn't need to be a misc device driver then.
>
Nope. The callbacks mentioned above are mainly coming from the clock
framework. Ofcourse the clock node trigger
with voltage ramps would be triggered by some upper laver
governor/framework like CPUFreq/DEVFREQ but as
such this is not necessary. This is an indepdent driver and just like
CPUFREQ notifies it's users for the frequency
change, this driver will be notified to take any action on pre and
post notification. Note that, the driver will
be notified by regulator framework for the voltage ramp up/down cases
too with notifiers.

>> > - Temperature alert configuration and handling of temperature
>> >   alerts, if any for LPDDR2 devices
>> >   * temperature alert is based on periodic polling of MR4 mode
>> >     register in DDR devices automatically performed by hardware
>> >   * timings are de-rated and brought back to nominal when
>> >     temperature raises and falls respectively
>
> This can be a feature overriding "max_freq" inside the Omap EMIF devfreq device driver though it maybe (or not.. I just don't sure) be better to use thermal framework as well.
>
That's absolute abuse and there is no need to link the temperature
handling with DVFS. Reducing frequency can be one
of the cooling techniques but that's not related to the temperature
alert handling. Temperature handling in the EMIF
driver is strictly as per the JDEC specs and that is to de-rate the
timings when temperature threshold is crossed.

The idea is drivers should be independent of all the global policy
governors. Hope this is clear to
you.

Regards
Santosh
