From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sat, 21 Nov 2015 20:53:38 +0200
Subject: [PATCH 03/11] dt-bindings: clock: add NXP LPC32xx clock list
 for consumers
In-Reply-To: <5570695.dzvsXZ7sfz@wuerfel>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
 <4268221.QhjAE5RLYk@wuerfel> <564F5F2E.70607@mleia.com>
 <5570695.dzvsXZ7sfz@wuerfel>
Message-ID: <5650BDB2.9070403@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 20.11.2015 23:07, Arnd Bergmann wrote:
> On Friday 20 November 2015 19:58:06 Vladimir Zapolskiy wrote:
>> On 20.11.2015 15:56, Arnd Bergmann wrote:
>>> On Friday 20 November 2015 03:05:03 Vladimir Zapolskiy wrote:
>>>> +
>>>> +/* LPC32XX System Control Block clocks */
>>>> +#define LPC32XX_CLK_RTC                0
>>>> +#define LPC32XX_CLK_DMA                1
>>>> +#define LPC32XX_CLK_MLC                2
>>>> +#define LPC32XX_CLK_SLC                3
>>>> +#define LPC32XX_CLK_LCD                4
>>>> +#define LPC32XX_CLK_MAC                5
>>>> +#define LPC32XX_CLK_SD         6
>>>> +#define LPC32XX_CLK_DDRAM      7
>>>> +#define LPC32XX_CLK_SSP0       8
>>>> +#define LPC32XX_CLK_SSP1       9
>>>> +#define LPC32XX_CLK_UART3      10
>>>> +#define LPC32XX_CLK_UART4      11
>>>> +#define LPC32XX_CLK_UART5      12
>>>> +#define LPC32XX_CLK_UART6      13
>>>> +#define LPC32XX_CLK_IRDA       14
>>>> +#define LPC32XX_CLK_I2C1       15
>>>>
>>>
>>> Any chance we can avoid the include file? This is going to make it really
>>> hard to merge everything in one merge window with the dependencies between
>>> the driver, the bindings and the platform code.
>>
>> I see only one option to avoid this commit, namely squash it with the
>> CCF driver and merge it before making changes in DTS.
>>
>> However I suppose ARM trees won't be synced on clk tree, so probably it
>> won't simplify maintainer's work.
> 
> I think the best way for this would then be to have one git branch that
> contains the binding header, and base the other patches on top of that
> branch, for both the changes going into the clk git and arm-soc.
> 
> That way, both have the commit we need, but we don't get duplicate
> commits when they are both merged into mainline.

I isolated the binding header, because in my opinion it may be reviewed
(and hopefully accepted unchanged) separately from the CCF driver. If I
am not mistaken, merging of two branches with an identical commit is
seamless.

It is hard to predict, when the CCF driver gets into mainline, but the
presence of the binding header in arm-soc tree will allow to avoid lots
of conflicts and/or code rebases concerning lpc32xx.dtsi file.

>>> If there is a way to describe the clocks based on numbers from the
>>> data sheet instead of making up your own, that makes life much
>>> easier for us.
>>
>> There are no any clock numbers in the datasheet, unfortunately.
> 
> I was thinking that maybe there would be a logical numbering based
> on the register layout, e.g. a tuple of register index and bit position,
> but it seems that the mmio area is too irregular to make that easy.

Absolutely correct. Only if we consider registers, the clock controller
registers are scattered in System Control Block, which also contains 3
wakeup controllers, partially pinmux and DMA settings, "software
interrupt" controller, fine tuned configurations of ARM core debugging
mechanisms and so on.

--
With best wishes,
Vladimir
