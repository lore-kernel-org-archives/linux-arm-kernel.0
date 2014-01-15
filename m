From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Jan 2014 09:12:47 +0100
Subject: [PATCH 2/2] pinctrl: sirf: put gpio interrupt pin into input
 status automatically
In-Reply-To: <1389430123-8036-2-git-send-email-21cnbao@gmail.com>
References: <1389430123-8036-1-git-send-email-21cnbao@gmail.com>
 <1389430123-8036-2-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdbgPLzihp30ScbhTN9inO6WOnGrKpn1Gh_Q8vs2RyxT=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 9:48 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> busses like i2c, spi and so on can parse the virq of their subnode automatically by
> irq_of_parse_and_map(). for example, i2c will do that in of_i2c_register_devices().
> people can put hwirq number attached to a gpio controller in dts, and drivers can
> directly request the parsed virq.
>
> for example, for an i2c client as below,
> tangoc-ts at 5c{
>         compatible = "pixcir,tangoc-ts";
>         interrupt-parent = <&gpio>;
>         interrupts = <3 0>;
>         reg = <0x5c>;
> };
> in i2c client probe(), it will request_irq(client->irq, ...) without
> calling gpio_direction_input().
> so here when we set irq type, we also put the pin to input direction.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

OK this makes perfect sense, and is not really related to DT: we recently
concluded that it should always be possible to request an IRQ from an
irqchip without having to interact with the GPIO interface first. So this is
doing the right thing.

However to keep things strict we need to add calls to mark the GPIO
lines used for IRQ, I'll see if I can fix a quick patch for this so you can
test.

Yours,
Linus Walleij
