From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Thu, 22 Dec 2016 21:16:09 +0100
Subject: [PATCH 2/2] mfd: mc13xxx: Pass the IRQF_TRIGGER_HIGH flag.
In-Reply-To: <9a7ab387-a3e5-913a-2204-2b337ba0f8aa@mleia.com>
References: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
 <1482211233.10253607@f408.i.mail.ru>
 <CAM=E1R5=k5NXurdV=6TzE9bPH5M3zyFpUjuJpGd9ECKrdjaj7w@mail.gmail.com>
 <1482300049.831956101@f373.i.mail.ru>
 <CAM=E1R7mBa7PSyshR+VwbeCqqDytkTknNksWQmf3Yk2r0_nHZw@mail.gmail.com>
 <1bec9023-1869-2847-bea6-adebc5af0093@mleia.com>
 <CAOMZO5CifMQGu2dFAm4a5BTUrqdJS77k-n3daBR6qCqtdX_W-Q@mail.gmail.com>
 <9a7ab387-a3e5-913a-2204-2b337ba0f8aa@mleia.com>
Message-ID: <CAM=E1R4HarEBjCiGgG2AwnWqdLBGpLKPXAokEbZEdwXRUUa5Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22 December 2016 at 02:08, Vladimir Zapolskiy <vz@mleia.com> wrote:
> On 12/21/2016 10:28 PM, Fabio Estevam wrote:
>> On Wed, Dec 21, 2016 at 6:24 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
>>
>>> Correct, I would recommend to postpone adding any extensions to the driver
>>> platform data, which by the way is found in include/linux/mfd/mc13xxx.h
>>>
>>> The extension can be added only when it becomes needed.
>>
>> Yes, I agree.
>>
>
> So, for reference here is a snippet from the i.MX31 Lite board DTS:
>
> &spi2 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_cspi2>;
>
>         /*
>          * Note that intentionally there is no GPIO CS, i.MX31 CSPI
>          * controller does not support GPIO CS and this must be specially
>          * accounted in the driver, which currently fails to register
>          * without a provided "cs-gpios" property.
>          */
>         fsl,spi-num-chipselects = <1>;
>         status = "okay";
>
>         pmic: mc13783 at 0 {
>                 compatible = "fsl,mc13783";
>                 reg = <0>;
>                 spi-cs-high;
>                 spi-max-frequency = <1000000>;
>                 interrupt-parent = <&gpio1>;
>                 interrupts = <3 IRQ_TYPE_EDGE_RISING>;
>
>                 fsl,mc13xxx-uses-rtc;
>         };
> };
>
> I'm running the current pre-rc1 v4.10. The MFD device is registered and
> MC13783 primary interrupt connected to GPIO1_3 is fired as expected
> independently if the fixup under discussion is applied or not:
>
> root at mx31lite:~# dmesg | grep spi
> [    2.017217] mc13xxx spi32766.0: mc13783: rev: 3.3, fin: 0, fab: 0, icid: 2/0
> [    2.072029] spi_imx 50010000.cspi: probed
>
> root at mx31lite:~# dmesg | grep rtc0
> [    2.682459] mc13xxx-rtc mc13783-rtc: rtc core: registered mc13783-rtc as rtc0
>
> root at mx31lite:~# cat /proc/interrupts | grep mc13xxx-rtc
> 176:          0  spi32766.0  31 Edge      mc13xxx-rtc
> 177:          0  spi32766.0  25 Edge      mc13xxx-rtc
>
> root at mx31lite:~# echo +5 > /sys/class/rtc/rtc0/wakealarm ; sleep 5
>
> root at mx31lite:~# cat /proc/interrupts | grep mc13xxx-rtc
> 176:          0  spi32766.0  31 Edge      mc13xxx-rtc
> 177:          1  spi32766.0  25 Edge      mc13xxx-rtc
>
> So the change at least does not break i.MX31 Lite board with DTS support,
> however I'm not sure if the change is still valid for any board with DTS
> if the type of the interrupt is specified as IRQ_TYPE_EDGE_FALLING.

So, have we reached a conclusion that a solution based on the code
below is good enough for now? Further device tree development would
make it possible to support other triggers on i.MX31 boards. And any
board that already has dt support can override TRIGGER_HIGH since
irqd_get_trigger_type() will return something else than IRQ_TYPE_NONE.

> unsigned flags = irqd_get_trigger_type(irq_get_irq_data(irq));
> flags = (flags == IRQ_TYPE_NONE) ? IRQF_TRIGGER_HIGH : flags;
> ret = regmap_add_irq_chip(..., IRQF_ONESHOT | flags, ...);

The above code works on both 3.18.x and 4.9.

Regards, Magnus
