From: rjui@broadcom.com (Ray Jui)
Date: Fri, 16 Jan 2015 16:11:14 -0800
Subject: [PATCH v6 2/3] gpio: Cygnus: add GPIO driver
In-Reply-To: <CACRpkdZef8S-EAbShjJ1eg+-3wQKn+yx4u1k_Mf8F7uFkJYdFw@mail.gmail.com>
References: <rjui@broadcom.com>	<1418696307-19392-1-git-send-email-rjui@broadcom.com>	<1418696307-19392-3-git-send-email-rjui@broadcom.com>	<CACRpkdYGksEseGaO49=1rUi5WBdOxwAd-F1gpgZn+BFatRCdDg@mail.gmail.com>	<54B55068.8050500@broadcom.com>
 <CACRpkdZef8S-EAbShjJ1eg+-3wQKn+yx4u1k_Mf8F7uFkJYdFw@mail.gmail.com>
Message-ID: <54B9A8A2.6090209@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/16/2015 2:14 AM, Linus Walleij wrote:
> On Tue, Jan 13, 2015 at 6:05 PM, Ray Jui <rjui@broadcom.com> wrote:
>> On 1/13/2015 12:53 AM, Linus Walleij wrote:
>>> On Tue, Dec 16, 2014 at 3:18 AM, Ray Jui <rjui@broadcom.com> wrote:
>>>
>>>> +/* drive strength control for ASIU GPIO */
>>>> +#define CYGNUS_GPIO_ASIU_DRV0_CTRL_OFFSET 0x58
>>>> +
>>>> +/* drive strength control for CCM GPIO */
>>>> +#define CYGNUS_GPIO_CCM_DRV0_CTRL_OFFSET  0x00
>>>
>>> This stuff (drive strength) is pin control, pin config.
>>> It does not belong in a pure GPIO driver. If you're
>>> making a combined pin control + GPIO driver, it
>>> shall be put in drivers/pinctrl/*
>>>
>> Okay, I have some questions here. Are you suggesting me to register this
>> driver to both the pinctrl subsystem and gpiolib and move it to under
>> drivers/pinctrl/*?
> 
> Either you can have a combined driver in drivers/pinctrl/*
> which has one probe() function calling pinctrl_register(),
> gpiochip_add(), gpiochip_add_pin_range(), having the gpio
> parts call into the pin control backend with
> pinctrl_request_gpio(), pinctrl_free_gpio(),
> pinctrl_gpio_direction_input(), pinctrl_gpio_direction_output().
> 
> Or you can split it in one driver in drivers/pinctrl/*
> dealing with just the pin control stuff, and another driver
> in drivers/gpio/* dealing with the GPIO stuff, each with one
> probe() function.
> 
> If they are using the same register range, the first approach
> is probably most intuitive. If the pin control and GPIO parts
> are separated in different register ranges, probably the
> second approach is the best.
> 
>> Or Are you suggesting me to combine this driver with the other Cygnus
>> pinctrl driver (which only supports pinmux)?
> 
> Depends on which hardware block the pin control-like
> registers belongs in. See per above.
> 
>> Note in Cygnus, all pinmux logic is done in the pinmux block. And there
>> are 3 GPIO controllers, that handle GPIO, drive strength of the GPIO
>> pins, internal pull up/down of the GPIO pins, which are handled in this
>> driver. So this driver is generic to all 3 GPIO controllers, as you can
>> see from the device tree bindings, there are 3 nodes.
>>
>> Therefore, I think it makes sense to have one pinmux driver that handles
>> the pinmux block, and one generic pinctrl + gpio driver that handles
>> functions supported by all 3 GPIO controllers. Does this make sense to you?
> 
> Yep.
> 
> Some hardware designs put the software-controlled biasing
> resistors in the GPIO block electronically connected to the actual
> pins, so that e.g. the biasing will be available if some MMC or
> whatever is using the same pins in another muxing. In such
> situations it's quite evident that they need to be a combined
> GPIO and pin controller.
> 
> I have some regrets that bolting a second pin controller to the
> GPIO chip make things a bit complex but it's a price we have
> to pay for getting some kind of generic interface.
> 
> Yours,
> Linus Walleij
> 
Okay. In summary, I think both of us think the following approach makes
sense in my situation:
- leave pinmux in pinctrl-bcm-cygnus.c
- leave pinctrl + gpio in pinctrl-bcm-cygnus-gpio.c under drivers/pinctrl/*

But by thinking about this more, I thought this would create duplicated
pinctrl descriptors in our system, one from the pinmux driver, and the
other from this pinctrl+gpio driver. That is probably undesirable?

By reviewing various drivers in the pinctrl directory, I found what
pinctrl-u300.c and pinctrl-coh901.c does seems to serve as a good model
for me to follow:
- pinctrl-u300.c is the pinmux driver
- pinctrl-coh901.c is the gpio+pinctrl driver

The GPIO pinctrl logic is in the coh901 block, so pinctrl-coh901.c
exposed two public functions u300_gpio_config_get, u300_gpio_config_set
that pinctrl-u300.c can use. The u300 populates all pinmux/pinctrl
related functions into the subsystem. This way there's only one pinctrl
descriptor, populated through pinctrl-u300.c.

Does that model make more sense to you?

Thanks,

Ray
