From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 29 Nov 2015 15:00:12 +0200
Subject: [PATCH 09/11] clk: lpc32xx: add common clock framework driver
In-Reply-To: <4933690.HhBPeGYMb3@wuerfel>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
 <3762298.NKYXldtldq@wuerfel> <564F6172.3090509@mleia.com>
 <4933690.HhBPeGYMb3@wuerfel>
Message-ID: <565AF6DC.40100@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 20.11.2015 22:20, Arnd Bergmann wrote:
> On Friday 20 November 2015 20:07:46 Vladimir Zapolskiy wrote:
>> On 20.11.2015 16:04, Arnd Bergmann wrote:
>>> On Friday 20 November 2015 03:05:09 Vladimir Zapolskiy wrote:
>>>> +
>>>> +struct clk_proto_t {
>>>> +       const char *name;
>>>> +       const u8 parents[LPC32XX_CLK_PARENTS_MAX];
>>>> +       u8 num_parents;
>>>> +       unsigned long flags;
>>>> +};
>>>> +
>>>> +#define CLK_PREFIX(LITERAL)            LPC32XX_CLK_ ## LITERAL
>>>> +#define NUMARGS(...)   (sizeof((int[]){__VA_ARGS__})/sizeof(int))
>>>> +
>>>> +#define LPC32XX_CLK_DEFINE(_idx, _name, _flags, ...)           \
>>>> +       [CLK_PREFIX(_idx)] = {                                  \
>>>> +               .name = #_name,                                 \
>>>> +               .flags = _flags,                                \
>>>> +               .parents = { __VA_ARGS__ },                     \
>>>> +               .num_parents = NUMARGS(__VA_ARGS__),            \
>>>> +        }
>>>> +
>>>
>>> Try to not outsmart yourself with the macros. It's better to avoid
>>> string concatenation so it's possible to grep for uses of some
>>> constant.
>>>
>>> I would probably not use a macro at all here and just open-code the
>>> entire table. If you ensure that '0' is not a valid parent, then
>>> you can leave out the .num_parents field and just look for the
>>> zero-termination.
>>
>> Macros are here for simplicity, code size reduction and to avoid some
>> stupid mistakes like different number of .parents and .num_parents.
>>
>> I believe macro unwrapping in this code will add another 1000 LoC and
>> will result in quite unreadable and less maintainable code.
> 
> I mean specifically the macro above:
> 
> static const struct clk_proto_t clk_proto[LPC32XX_CLK_CCF_MAX] __initconst = {
> +       LPC32XX_CLK_DEFINE(XTAL, xtal, 0x0),
> +       LPC32XX_CLK_DEFINE(XTAL_32K, xtal_32k, 0x0),
> +
> +       LPC32XX_CLK_DEFINE(RTC, rtc, 0x0, LPC32XX_CLK_XTAL_32K),
> +       LPC32XX_CLK_DEFINE(OSC, osc, CLK_IGNORE_UNUSED, LPC32XX_CLK_XTAL),
> +       LPC32XX_CLK_DEFINE(SYS, sys, CLK_IGNORE_UNUSED,
> +               LPC32XX_CLK_OSC, LPC32XX_CLK_PLL397X),
> +       LPC32XX_CLK_DEFINE(PLL397X, pll_397x, CLK_IGNORE_UNUSED,
> +               LPC32XX_CLK_RTC),
> 
> can become
> 
> static const struct clk_proto_t clk_proto[] __initconst = {
> 	[LPC32XX_CLK_XTAL]	= { "xtal" },
> 	[LPC32XX_CLK_XTAL_32K]	= { "xtal_32k" },
> 	[LPC32XX_CLK_RTC]	= { "rtc",
> 			.parents = { LPC32XX_CLK_XTAL_32K, 0 } },

this one and all below are two lines instead of one.

Also .num_parents is not set at compilation stage, this will require
running over parents arrays for every registered clock on boot, it might
noticeably slow down the booting process on a 200MHz core.

The clocks in the beginning have not so many parents, at the opposite
extreme the situation is worse:

	LPC32XX_CLK_DEFINE(TEST1, test1, 0x0,
		LPC32XX_CLK_PERIPH, LPC32XX_CLK_RTC, LPC32XX_CLK_OSC),
	LPC32XX_CLK_DEFINE(TEST2, test2, 0x0,
		LPC32XX_CLK_HCLK, LPC32XX_CLK_PERIPH, LPC32XX_CLK_USB,
		LPC32XX_CLK_OSC, LPC32XX_CLK_PLL397X),

vs.

	[LPC32XX_CLK_TEST1]	= { "test1",
		.parents = { LPC32XX_CLK_PERIPH, LPC32XX_CLK_RTC,
			     LPC32XX_CLK_OSC, 0 } },
	[LPC32XX_CLK_TEST1]	= { "test2",
		.parents = { LPC32XX_CLK_HCLK, LPC32XX_CLK_PERIPH,
			     LPC32XX_CLK_USB, LPC32XX_CLK_OSC,
			     LPC32XX_CLK_PLL397X, 0 } },


> 	[LPC32XX_CLK_OSC]	= { "osc", CLK_IGNORE_UNUSED,
> 			.parents = { LPC32XX_CLK_XTAL, 0 } },
> 	[LPC32XX_CLK_SYS]	= { "sys", CLK_IGNORE_UNUSED,
> 			.parents = { LPC32XX_CLK_OSC, LPC32XX_CLK_PLL397X, 0) },
> 	[LPC32XX_CLK_PLL397X]	= { "pll_397x", CLK_IGNORE_UNUSED,
> 			.parents = { LPC32XX_CLK_RTC, 0 },
> 
> Not harder to read at all, not really longer, but easier to grep for.
> 

If it is not principal, I would prefer to keep the original notation,
but convert stringified values to plane strings, all in all the table is
fixed and it is not supposed to be updated anymore.

But in general I got your idea, I can implement it in v2, if you ask.

--
With best wishes,
Vladimir
