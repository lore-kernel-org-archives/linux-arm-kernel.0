From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 20 Nov 2013 09:02:04 +0900
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized using
 pinfunc.
In-Reply-To: <528BB913.6080409@wwwdotorg.org>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
 <528BB1F2.4080107@wwwdotorg.org>
 <CAD=FV=XS0dbE7zfgDGVdp84h4fHH6tfO8aN_HNh1LbOjYy51aQ@mail.gmail.com>
 <528BB913.6080409@wwwdotorg.org>
Message-ID: <CAH9JG2UjnL5bZzNUuJhWY3GpwPD=rJvR2O4Hcpm33G+prSS=BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 4:16 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/19/2013 11:59 AM, Doug Anderson wrote:
>> On Tue, Nov 19, 2013 at 10:46 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 11/19/2013 10:15 AM, Tomasz Figa wrote:
>>>> This patch extends the range of settings configurable via pinfunc API
>>>> to cover pin value as well. This allows configuration of default values
>>>> of pins.
>>>
>>> Shouldn't there be a driver that acquires the GPIO that's output to the
>>> pin, and configures the output value? IIRC there have been previous
>>> discussions re: having a list of e.g. initial GPIO output values in DT,
>>> and that was rejected, and this patch seems to be doing almost the exact
>>> same thing, just at the pinctrl level rather than GPIO level.
>>>
>>> That all said, I admit this could be a useful feature...
>>
>> I haven't followed all of the previous discussions, but I know I've
>> run into scenarios where something like this would be useful.  The one
>> that comes to mind is:
>>
>> * We've got GPIOs that default at bootup to a pulled up input since
>> the default state of the pin should be "high".
>>
>> * These pins are really intended to be outputs, like an "enable",
>> "reset", or "power down" line for a peripheral.  The pullup is strong
>> enough to give us a good default state but we really want outputs.
>>
>> * We'd like to provide this GPIO to a peripheral through device tree.
>> ...and we'd like all the pinmux to be setup automatically so we use
>> pinctrl-names = "default".
>>
>> * If we set the pinmux up as "output" then there's a chance that the
>> line will glitch at bootup since the pinmux happens (changing the pin
>> to output) before the driver has a chance to run.
>
> I think that last point should be addressed by having a driver that owns
> the GPIO set it to the desired output level, and the implementation of
Some pins are not connected (NC). At that cases, there's no drivers to
handle it. To reduce power leakage, it sets proper configuration with
values instead of reset values.

Thank you,
Kyungmin Park

> the SoC's GPIO driver communicate with the pinctrl driver (which might
> be the same driver; not sure here) so that gpio_direction_output()
> causes the pinctrl HW to be programmed as output only after the GPIO HW
> is programmed as output and with the correct output value. In this
> scenario, the pinctrl default state wouldn't touch the pin's
> input/output setting; that operation would be deferred until the driver
> set up the GPIO as an output.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
