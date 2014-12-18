From: gnurou@gmail.com (Alexandre Courbot)
Date: Thu, 18 Dec 2014 22:42:22 +0900
Subject: DT on s3c24xx
In-Reply-To: <CA+E=qVeU4hEX2x9uAPfgqEgpxvA7bUBWqWJtBJdbP=RK6ghfEQ@mail.gmail.com>
References: <CA+E=qVf4nT5x-fRFBu=Wv_VKUnEMAEP4GgJG8em8NyUFkwtbPg@mail.gmail.com>
 <20141218075205.GB10857@pengutronix.de>
 <CA+E=qVeU4hEX2x9uAPfgqEgpxvA7bUBWqWJtBJdbP=RK6ghfEQ@mail.gmail.com>
Message-ID: <CAAVeFu+ZZChxk4djpd-TqK_JB5GcHaKNUxA0O3g14ptOnKQccg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 5:34 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> On Thu, Dec 18, 2014 at 10:52 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
>> Hello,
>
> Hi Uwe,
>
>> [Cc += linusw, linux-gpio]
>>
>> On Wed, Dec 17, 2014 at 10:04:24PM +0300, Vasily Khoruzhick wrote:
>>> I'd like to port several s3c24xx to DT, and I'm stuck with s3c24xx LCD
>>> controller and power drivers for H1940 and RX1950.
>>>
>>> Please see [1]. I want to move this function into another LCD power
>>> driver, but I'm not sure what to do with s3c_gpio_cfgpin(). I need to
>>> change pin function in runtime, and as far as I understand it should
>>> be handled via pinctrl driver somehow. But how?
>> You can pass >1 pinctrl setups to a node:
>>
>>         somedevice {
>>                 pinctrl-names = "default", "foo", "bar";
>>                 pinctrl-0 = <&pinctrl_somedevice_default>;
>>                 pinctrl-1 = <&pinctrl_somedevice_foo>;
>>                 pinctrl-2 = <&pinctrl_somedevice_bar>;
>>                 cfg-gpios = <&gpio4 12 3>, <&gpio2 7 5>;
>>         };
>>
>> Then I think you can fiddle with pinctrl_select_state(). For the gpios
>> you can then use the standard gpiod_{request,direction_{in,out}put}
>> combo.
>
> Thanks for you response!
>
> Can I change pin function after gpio was requested? In low-power state
> (i.e. when display is disabled) it's gpio driving some level,
> and in active state it's some LCD controller pin (don't remember which
> one exactly)

If your driver can release the GPIO and change the pinctrl when
switching to active state (and change the pinctrl again and request
the GPIO when switching to low-power state) then this should be
doable. I suspect the switch is made by the same driver anyway, isn't
it?
