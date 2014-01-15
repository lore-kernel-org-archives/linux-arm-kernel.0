From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 15 Jan 2014 16:20:31 +0800
Subject: [PATCH 2/2] pinctrl: sirf: put gpio interrupt pin into input
 status automatically
In-Reply-To: <CACRpkdbgPLzihp30ScbhTN9inO6WOnGrKpn1Gh_Q8vs2RyxT=w@mail.gmail.com>
References: <1389430123-8036-1-git-send-email-21cnbao@gmail.com>
 <1389430123-8036-2-git-send-email-21cnbao@gmail.com>
 <CACRpkdbgPLzihp30ScbhTN9inO6WOnGrKpn1Gh_Q8vs2RyxT=w@mail.gmail.com>
Message-ID: <CAGsJ_4xOYKZa5JNVncK9r2_5dViXQHCA1jte9RU6vv_g59Ur9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/15 Linus Walleij <linus.walleij@linaro.org>:
> On Sat, Jan 11, 2014 at 9:48 AM, Barry Song <21cnbao@gmail.com> wrote:
>
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> busses like i2c, spi and so on can parse the virq of their subnode automatically by
>> irq_of_parse_and_map(). for example, i2c will do that in of_i2c_register_devices().
>> people can put hwirq number attached to a gpio controller in dts, and drivers can
>> directly request the parsed virq.
>>
>> for example, for an i2c client as below,
>> tangoc-ts at 5c{
>>         compatible = "pixcir,tangoc-ts";
>>         interrupt-parent = <&gpio>;
>>         interrupts = <3 0>;
>>         reg = <0x5c>;
>> };
>> in i2c client probe(), it will request_irq(client->irq, ...) without
>> calling gpio_direction_input().
>> so here when we set irq type, we also put the pin to input direction.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> OK this makes perfect sense, and is not really related to DT: we recently
> concluded that it should always be possible to request an IRQ from an
> irqchip without having to interact with the GPIO interface first. So this is
> doing the right thing.
>
> However to keep things strict we need to add calls to mark the GPIO
> lines used for IRQ, I'll see if I can fix a quick patch for this so you can
> test.

yes, Linus. i did have the same concern. people can request irq
without involving gpio. so we have to mark the pin not available to
pinctrl subsystem as well.
if people did gpio_request + gpio_to_irq + request_gpio, the pin will
be marked by pinmux as not-free, but what if people request_irq
directly, i think pinmux will not know this.
this is also buggy.

>
> Yours,
> Linus Walleij

-barry
