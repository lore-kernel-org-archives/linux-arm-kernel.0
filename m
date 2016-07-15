From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Fri, 15 Jul 2016 12:38:54 +0200
Subject: [PATCH v2 06/14] ARM: sun8i: clk: Add clk-factor rate application
 method
In-Reply-To: <20160715085356.GR4761@lukather>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com> <20160630204001.GC5485@lukather>
 <0b71ed7e-98c9-109e-85e6-ceb95131d88a@megous.com>
 <20160715085356.GR4761@lukather>
Message-ID: <085e185a-ac76-dd3f-9b0e-a7dc9c0c09f3@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.7.2016 10:53, Maxime Ripard wrote:
> On Fri, Jul 01, 2016 at 02:50:57AM +0200, Ond?ej Jirman wrote:
>>>>  /**
>>>> + * sun8i_h3_apply_pll1_factors() - applies n, k, m, p factors to the
>>>> + * register using an algorithm that tries to reserve the PLL lock
>>>> + */
>>>> +
>>>> +static void sun8i_h3_apply_pll1_factors(struct clk_factors *factors, struct factors_request *req)
>>>> +{
>>>> +	const struct clk_factors_config *config = factors->config;
>>>> +	u32 reg;
>>>> +
>>>> +	/* Fetch the register value */
>>>> +	reg = readl(factors->reg);
>>>> +
>>>> +	if (FACTOR_GET(config->pshift, config->pwidth, reg) < req->p) {
>>>> +		reg = FACTOR_SET(config->pshift, config->pwidth, reg, req->p);
>>>> +
>>>> +		writel(reg, factors->reg);
>>>> +		__delay(2000);
>>>> +	}
>>>
>>> So there was some doubts about the fact that P was being used, or at
>>> least that it was useful.
>>
>> p is necessary to reduce frequencies below 288 MHz according to the
>> datasheet.
> 
> Yes, but you could reach those frequencies without P, too, and it's
> not part of any OPP provided by Allwinner.

The arisc firmware for H3 contains table of factors for frequences from
0 to 2GHz and, P is used below 240MHz. M is never used, BTW. (other
datasheets specify M as for testing use only, whatever that means - not
H3, but it seems it's the same PLL block)


... snip ...
	{ .n = 9, .k = 0, .m = 0, .p = 2 }, // 60 => 60 MHz
	{ .n = 10, .k = 0, .m = 0, .p = 2 }, // 66 => 66 MHz
	{ .n = 11, .k = 0, .m = 0, .p = 2 }, // 72 => 72 MHz
	{ .n = 12, .k = 0, .m = 0, .p = 2 }, // 78 => 78 MHz
	{ .n = 13, .k = 0, .m = 0, .p = 2 }, // 84 => 84 MHz
	{ .n = 14, .k = 0, .m = 0, .p = 2 }, // 90 => 90 MHz
	{ .n = 15, .k = 0, .m = 0, .p = 2 }, // 96 => 96 MHz
	{ .n = 16, .k = 0, .m = 0, .p = 2 }, // 102 => 102 MHz
	{ .n = 17, .k = 0, .m = 0, .p = 2 }, // 108 => 108 MHz
	{ .n = 18, .k = 0, .m = 0, .p = 2 }, // 114 => 114 MHz
	{ .n = 9, .k = 0, .m = 0, .p = 1 }, // 120 => 120 MHz
	{ .n = 10, .k = 0, .m = 0, .p = 1 }, // 126 => 132 MHz
	{ .n = 10, .k = 0, .m = 0, .p = 1 }, // 132 => 132 MHz
	{ .n = 11, .k = 0, .m = 0, .p = 1 }, // 138 => 144 MHz
	{ .n = 11, .k = 0, .m = 0, .p = 1 }, // 144 => 144 MHz
	{ .n = 12, .k = 0, .m = 0, .p = 1 }, // 150 => 156 MHz
	{ .n = 12, .k = 0, .m = 0, .p = 1 }, // 156 => 156 MHz
	{ .n = 13, .k = 0, .m = 0, .p = 1 }, // 162 => 168 MHz
	{ .n = 13, .k = 0, .m = 0, .p = 1 }, // 168 => 168 MHz
	{ .n = 14, .k = 0, .m = 0, .p = 1 }, // 174 => 180 MHz
	{ .n = 14, .k = 0, .m = 0, .p = 1 }, // 180 => 180 MHz
	{ .n = 15, .k = 0, .m = 0, .p = 1 }, // 186 => 192 MHz
	{ .n = 15, .k = 0, .m = 0, .p = 1 }, // 192 => 192 MHz
	{ .n = 16, .k = 0, .m = 0, .p = 1 }, // 198 => 204 MHz
	{ .n = 16, .k = 0, .m = 0, .p = 1 }, // 204 => 204 MHz
	{ .n = 17, .k = 0, .m = 0, .p = 1 }, // 210 => 216 MHz
	{ .n = 17, .k = 0, .m = 0, .p = 1 }, // 216 => 216 MHz
	{ .n = 18, .k = 0, .m = 0, .p = 1 }, // 222 => 228 MHz
	{ .n = 18, .k = 0, .m = 0, .p = 1 }, // 228 => 228 MHz
	{ .n = 9, .k = 0, .m = 0, .p = 0 }, // 234 => 240 MHz
	{ .n = 9, .k = 0, .m = 0, .p = 0 }, // 240 => 240 MHz
	{ .n = 10, .k = 0, .m = 0, .p = 0 }, // 246 => 264 MHz
	{ .n = 10, .k = 0, .m = 0, .p = 0 }, // 252 => 264 MHz
	{ .n = 10, .k = 0, .m = 0, .p = 0 }, // 258 => 264 MHz
	{ .n = 10, .k = 0, .m = 0, .p = 0 }, // 264 => 264 MHz
	{ .n = 11, .k = 0, .m = 0, .p = 0 }, // 270 => 288 MHz
	{ .n = 11, .k = 0, .m = 0, .p = 0 }, // 276 => 288 MHz
... snip ...


>>>> +	if (FACTOR_GET(config->mshift, config->mwidth, reg) < req->m) {
>>>> +		reg = FACTOR_SET(config->mshift, config->mwidth, reg, req->m);
>>>> +
>>>> +		writel(reg, factors->reg);
>>>> +		__delay(2000);
>>>> +	}
>>>> +
>>>> +	reg = FACTOR_SET(config->nshift, config->nwidth, reg, req->n);
>>>> +	reg = FACTOR_SET(config->kshift, config->kwidth, reg, req->k);
>>>> +
>>>> +	writel(reg, factors->reg);
>>>> +	__delay(20);
>>>> +
>>>> +	while (!(readl(factors->reg) & (1 << config->lock)));
>>>
>>> So, they are applying the dividers first, and then applying the
>>> multipliers, and then wait for the PLL to stabilize.
>>
>> Not exactly, first we are increasing dividers if the new dividers are
>> higher that that what's already set. This ensures that because
>> application of dividers is immediate by the design of the PLL, the
>> application of multipliers isn't. So the VCO would still run at the same
>> frequency for a while gradually rising to a new value for example,
>> while the dividers would be reduced immediately. Leading to crash.
>>
>> PLL
>> --------------------------
>> PRE DIV(f0) -> VCO(f1) -> POST DIV(f2)
>>    P             K,N           M
>>
>> Example: (we set all factors at once, reducing dividers and multipliers
>> at the same time at 0ms - this should lead to no change in the output
>> frequency, but...)
>>
>> -1ms: f0 = 24MHz, f1 = 2GHz,   f2 = 1GHz
>>  0ms: f0 = 24MHz, f1 = 2GHz,   f2 = 2GHz       - boom
>>  1ms: f0 = 24MHz, f1 = 1.5GHz, f2 = 1.5GHz
>>  2ms: f0 = 24MHz, f1 = 1GHz,   f2 = 1GHz
>>
>> The current code crashes exactly at boom, you don't get any more
>> instructions to execute.
>>
>> See.
>>
>> So this patch first increases dividers (only if necessary), changes
>> multipliers and waits for change to happen (takes around 2000 cycles),
>> and then decreases dividers (only if necessary).
>>
>> So we get:
>>
>> -1ms: f0 = 24MHz, f1 = 2GHz,   f2 = 1GHz
>>  0ms: f0 = 24MHz, f1 = 2GHz,   f2 = 1GHz   - no boom, multiplier
>>                                              reduced
>>  1ms: f0 = 24MHz, f1 = 1.5GHz, f2 = 0.75GHz
>> 1.9ms: f0 = 24MHz, f1 = 1GHz,   f2 = 0.5GHz - we got PLL sync
>>  2ms: f0 = 24MHz, f1 = 1GHz,   f2 = 1GHz   - and here we reduce divider
>> at last
> 
> Awesome explanation, thanks!
> 
> So I guess it really all boils down to the fact that the CPU is
> clocked way outside of it's operating frequency while the PLL
> stabilizes, right?

It may be, depending on the factors before and after change. I haven't
tested what factors the mainline kernel calculates for each frequency.
The arisc never uses M, and only uses P at frequencies that would not
allow for this behavior.

I created a test program for arisc that runs a loop on the main CPU
using msgbox to send pings to the arisc CPU, and the vary the PLL1
randomly from the arisc, and haven't been able to lockup the main CPU
yet with either method.

There's also AXI clock, that depends on PLL1. Arisc firmware uses the
same method to change it while changing CPUX clock. If the clock would
rise above certain frequency, AXI divider is increased before the PLL1
change. If it would fall below certain frequency it is decreased after
the PLL1 change.

Though, aw kernel has axi divider set to 3 for all PLL1 frequencies, so
this has no effect in practice.

It's all smoke and mirrors. :D

> If so, then yes, trying to switch to the 24MHz oscillator before
> applying the factors, and then switching back when the PLL is stable
> would be a nice solution.
> 
> I just checked, and all the SoCs we've had so far have that
> possibility, so if it works, for now, I'd like to stick to that.

It would need to be tested. U-boot does the change only once, while the
kernel would be doing it all the time and between various frequencies
and PLL settings. So the issues may show up with this solution too.

>>>> +
>>>> +	if (FACTOR_GET(config->mshift, config->mwidth, reg) > req->m) {
>>>> +		reg = FACTOR_SET(config->mshift, config->mwidth, reg, req->m);
>>>> +
>>>> +		writel(reg, factors->reg);
>>>> +		__delay(2000);
>>>> +	}
>>>> +
>>>> +	if (FACTOR_GET(config->pshift, config->pwidth, reg) > req->p) {
>>>> +		reg = FACTOR_SET(config->pshift, config->pwidth, reg, req->p);
>>>> +
>>>> +		writel(reg, factors->reg);
>>>> +		__delay(2000);
>>>> +	}
>>>
>>> However, this is kind of weird, why would you need to re-apply the
>>> dividers? Nothing really changes. Have you tried without that part?
>>
>> See above, we either increase before PLL change, or reduce dividers
>> after the change. Nothing is re-applied.
>>
>>> Since this is really specific, I guess you could simply make the
>>> clk_ops for the nkmp clocks public, and just re-implement set_rate
>>> using that logic.
>>
>> I would argue that this may be necessary for other PLL clocks too, if
>> you can get out of bounds output frequency, by changing the dividers too
>> early or too late. So perhaps this code should be generalized for other
>> PLL clocks too, instead.
> 
> We can scale down the problem a bit. The only PLL we modify are the
> CPU, audio and video ones.
> 
> The CPU should definitely be addressed, but what would be the outcome
> of an out of bounds audio pll for example? Is it just taking more time
> to stabilize, or would it hurt the system?

I have no idea. Given the low frequencies, you'll probably just get some
transient audio noise.

> In the former case, then we can just wait. In the latter, we of course
> need to come up with a solution.
> 
> Maxime
> 
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/392e824b/attachment.sig>
