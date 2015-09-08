From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Sep 2015 16:28:57 +0200
Subject: [PATCH 7/9] arm: twr-k70f120m: IOMUX driver for Kinetis SoC
In-Reply-To: <alpine.LNX.2.00.1509080953390.31192@localhost.localdomain>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl>
 <1435094387-20146-8-git-send-email-pawelo@king.net.pl>
 <CACRpkdYHBt7YJWM3Bg8ENfw7uL4fuENqW+g8YaO+P6UPBCX4HQ@mail.gmail.com>
 <alpine.LNX.2.00.1509080953390.31192@localhost.localdomain>
Message-ID: <CACRpkdZ_6eXWO+3NUz-9ai5nBaKa_HyAmwYHGU46qrmfmEwyEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 8, 2015 at 10:04 AM, Paul Osmialowski <pawelo@king.net.pl> wrote:
> On Tue, 14 Jul 2015, Linus Walleij wrote:
>
>> I want Shawn and Sascha to look at this as they worked with
>> other Freescale pin controllers. Especially I want to know if this
>> is a sibling to the other Freescale controllers or a separate hardware.
>>
>> If it is *not* a sibling I will *insist* that it use more generic pin
>> control bindings and move away from the older Freescale-specific
>> stuff.
>
> No one answered me about that. However, I looked at other Freescale
> pinctrl drivers and realised that no one of them (IMX, IMX1, MXS) is
> similar to what I need to do for Kinetis, also positions of configuration
> bits differ significantly.

OK I insist on using the generic bindings then.

>> There exist generic pin config bindings, see
>> Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>>
>> I suggest to to function+group paring and then use generic pin config
>> with this driver unless it is a very close sibling to the existing Freescale
>> pin controllers.
>>
>> Hint: if it is a sibling, it should share code with them.
>>
>> There are several drivers doing generic pin control/pin config in the kernel
>> tree.
>
> I tried to analyze few of the drivers (e.g. zynq family) and can't find
> how can I assing clock gate (clock device) to each port (PORTA, PORTB,
> PORTC,...) which is required for Kinetis. Is generic pin control capable
> to express that requirement or is it a time to desing my own pinctrl
> driver (maybe somewhat improved than the one I presented so far)?

That has nothing to do with whether you use generic pinconf or not.
I imagine if a pinctrl unit contains several blocks with individual
clocks you can either:

- Let each block/bank be a device node (this is common) and assign
  each a clocks = <&clock>;

- Keep one node and assign an array of clocks, affected block indicated
  by the index.
  clocks = <&clk1>, <&clk2>, <&clk3>, ... <clkN>;
  This property is in pluralis for this reason I guess.

> This pinctrl component is somwehat critical part of BSP. Until it is not
> sorted, I don't see a point in releasing what was developed so far.

True that, you need infrastructure first. The more important that it is
as good as possible.

Yours,
Linus Walleij
