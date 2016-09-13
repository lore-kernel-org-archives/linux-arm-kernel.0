From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Sep 2016 11:09:53 +0200
Subject: [PATCH v2 3/4] ARM: dts: Add NextThing GR8 dtsi
In-Reply-To: <1975640.ctuo4Obpao@avalon>
References: <20160907145400.27192-1-maxime.ripard@free-electrons.com>
 <20160908073748.GF8913@lukather>
 <CACRpkdbrvDZGM3OJsAMk4T5awSSbrJ4MDyKXV2C45ZSE7zUVNQ@mail.gmail.com>
 <1975640.ctuo4Obpao@avalon>
Message-ID: <CACRpkdapvA89yexwROCxr4t+MijCwidBrpYTow+zDx6D0WdSGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 2:47 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 12 Sep 2016 14:40:15 Linus Walleij wrote:

>> HOWEVER it often turns out that while you can programmatically
>> and individually set pins to any function (and biasing etc), the
>> person designing the hardware was not thinking that you should
>> be able to do whatever you like, e.g. even if it is possible to
>> take two pins and use one of them for half an SPI bus and the
>> other for half an I2C bus, that doesn't mean that this is useful
>> or makes any kind of electronic sense, it just makes "software
>> sense".
(...)
> I'd argue that you would find out about lots of clever/insane use cases that
> don't fit this model if you looked at all the hardware available out there,
> especially non-phone devices. Your SPI example is a good one, I've seen SPI
> being used in unidirectional mode only, with only MISO or MOSI mattering. In
> that case the other pin could be used as a GPIO for a totally unrelated
> purpose when the design is short on GPIOs or when GPIOs have been allocated
> without any knowledge of the Linux pinctrl subsystem.

That is true sometimes. It is a tradeoff, I can also imagine actually
driving an I2C bus just to use the SCL line as a clock for something,
constantly feeding nonsense data through the I2C block and
ignoring SDA and reusing that pin as GPIO. (And a lot of other
theoretical usecases.)

Some pin controller hardware helpully only let you select groups
and makes such hacks impossible.

Also I guess the target audience of the SoC will affect the
hackishness of the usecases, and affect what they might attempt
to shoehorn into the design.

So model on whatever makes most sense, is usually how I think about
it. Or as the IETF says "rough consensus and running code".

I guess it is a bit of grayzone, and that is why both solutions coexist.

> Looking at the sh-pfc driver, I wish the hardware had followed the pinctrl-
> single model. sh-pfc is a good example of how bloated a pinctrl driver can
> become when there is no choice but model all the relationships betweens pins
> and functions in C code.

It might be true, there are so many variables to the equation that
I cannot tell.

Debuggability and readability of code and device trees and different
groups of people reading code vs device trees is another factor.

Scaringly, what is best for me as subsystem maintainer (that all
drivers look identical) is not always best for the users.

Yours,
Linus Walleij
