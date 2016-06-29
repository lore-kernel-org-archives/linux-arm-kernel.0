From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 29 Jun 2016 11:48:06 -0700
Subject: [PATCH] extcon: Add support for qcom SPMI PMIC USB id detection
 hardware
In-Reply-To: <577369F5.8040907@samsung.com>
References: <20160626055647.18898-1-stephen.boyd@linaro.org>
 <CAGTfZH3ireJWo5-Jd5SEiSy-WMTsw43pweruOqwSesAZqagvtg@mail.gmail.com>
 <146705470025.30684.13257433085055355379@sboyd-linaro>
 <CAGTfZH3ZhZ2gQcOSuAByZWD59E3Bro1aayr2JsM2W+mYa2LQTQ@mail.gmail.com>
 <CGME20160628215923epcas1p3f7942aca724bf2746c20319750184584@epcas1p3.samsung.com>
 <146715115921.31418.2315766296233007937@sboyd-linaro>
 <577369F5.8040907@samsung.com>
Message-ID: <146722608622.16253.4347418438203284037@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chanwoo Choi (2016-06-28 23:25:57)
> On 2016? 06? 29? 06:59, Stephen Boyd wrote:
> > Quoting Chanwoo Choi (2016-06-28 05:06:48)
> >> 2016-06-28 4:11 GMT+09:00 Stephen Boyd <stephen.boyd@linaro.org>:
> >>> Quoting Chanwoo Choi (2016-06-26 04:20:43)
> >>>> 2016-06-26 14:56 GMT+09:00 Stephen Boyd <stephen.boyd@linaro.org>:
> >>>>> +PROPERTIES
> >>>>> +
> >>>>> +- compatible:
> >>>>> +    Usage: required
> >>>>> +    Value type: <string>
> >>>>> +    Definition: Should contain "qcom,pm8941-misc";
> >>>>> +
> >>>>> +- reg:
> >>>>> +    Usage: required
> >>>>> +    Value type: <u32>
> >>>>> +    Definition: Should contain the offset to the misc address space
> >>>>
> >>>> 'reg' property is used on extcon-qcom-spmi-misc.c?
> >>>> I think that you don't need to include this property.
> >>>
> >>> No it isn't used in the driver right now, but there is a register offset
> >>> for this module and there are registers that can be read/written in this
> >>> module. I'd like to keep it as required so we can easily read the
> >>> registers in the future if needed.
> >>
> >> OK.
> >> But, If you want to remain the reg property, you should add the code to get
> >> the register offset by using OF functions. This patch don't include the OF
> >> function to handle it.
> >>
> > 
> > Sorry I don't follow the argument. I've put the reg property here for
> > future proofing so that the binding doesn't have to change in backwards
> > incompatible ways in the future if we do need to get the property later.
> 
> I don't mention that 'reg' property should be removed.

Ok good. We need to keep reg property as this device is on a bus that
uses reg property for addressing.

> Just if you want to remain it, you should add some codes as following:
> For exmaple,
> - of_get_address() to get the address information from device-tree.
> 
> If documentation include the some properties, you should add the handling code
> in device driver. When you add the code to get the offset from device-tree,
> it doesn't influence the some behavior in the future.

Sorry I don't understand that argument. We can put properties into
bindings and not use them in drivers if there isn't any immediate need
to use them.

>From what I can tell you're suggesting we call of_get_address() in the
driver and then do nothing with the value of the property? Is that just
to check that the node is compliant with the binding and actually has a
reg property? We don't add code in the kernel to check dts compliance,
so I'm not inclined to do anything more here.
