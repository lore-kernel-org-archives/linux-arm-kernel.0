From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Fri, 1 Jul 2016 02:50:57 +0200
Subject: [PATCH v2 06/14] ARM: sun8i: clk: Add clk-factor rate application
 method
In-Reply-To: <20160630204001.GC5485@lukather>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com> <20160630204001.GC5485@lukather>
Message-ID: <0b71ed7e-98c9-109e-85e6-ceb95131d88a@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30.6.2016 22:40, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Jun 25, 2016 at 05:45:03AM +0200, megous at megous.com wrote:
>> From: Ondrej Jirman <megous@megous.com>
>>
>> PLL1 on H3 requires special factors application algorithm,
>> when the rate is changed. This algorithm was extracted
>> from the arisc code that handles frequency scaling
>> in the BSP kernel.
>>
>> This commit adds optional apply function to
>> struct factors_data, that can implement non-trivial
>> factors application method, when necessary.
>>
>> Also struct clk_factors_config is extended with position
>> of the PLL lock flag.
> 
> Have you tested the current implementation, and found that it was not
> working, or did you duplicate the arisc code directly?

I have tested the current implementation, and it was not working. It
depended on some other factors, like the initial setup done by u-boot.
It didn't work reliably.

Then I reverse engineered arisc, in an effort to see what's the
difference, between mainline and BSP code.

>>  /**
>> + * sun8i_h3_apply_pll1_factors() - applies n, k, m, p factors to the
>> + * register using an algorithm that tries to reserve the PLL lock
>> + */
>> +
>> +static void sun8i_h3_apply_pll1_factors(struct clk_factors *factors, struct factors_request *req)
>> +{
>> +	const struct clk_factors_config *config = factors->config;
>> +	u32 reg;
>> +
>> +	/* Fetch the register value */
>> +	reg = readl(factors->reg);
>> +
>> +	if (FACTOR_GET(config->pshift, config->pwidth, reg) < req->p) {
>> +		reg = FACTOR_SET(config->pshift, config->pwidth, reg, req->p);
>> +
>> +		writel(reg, factors->reg);
>> +		__delay(2000);
>> +	}
> 
> So there was some doubts about the fact that P was being used, or at
> least that it was useful.

p is necessary to reduce frequencies below 288 MHz according to the
datasheet.

>> +	if (FACTOR_GET(config->mshift, config->mwidth, reg) < req->m) {
>> +		reg = FACTOR_SET(config->mshift, config->mwidth, reg, req->m);
>> +
>> +		writel(reg, factors->reg);
>> +		__delay(2000);
>> +	}
>> +
>> +	reg = FACTOR_SET(config->nshift, config->nwidth, reg, req->n);
>> +	reg = FACTOR_SET(config->kshift, config->kwidth, reg, req->k);
>> +
>> +	writel(reg, factors->reg);
>> +	__delay(20);
>> +
>> +	while (!(readl(factors->reg) & (1 << config->lock)));
> 
> So, they are applying the dividers first, and then applying the
> multipliers, and then wait for the PLL to stabilize.

Not exactly, first we are increasing dividers if the new dividers are
higher that that what's already set. This ensures that because
application of dividers is immediate by the design of the PLL, the
application of multipliers isn't. So the VCO would still run at the same
frequency for a while gradually rising to a new value for example,
while the dividers would be reduced immediately. Leading to crash.

PLL
--------------------------
PRE DIV(f0) -> VCO(f1) -> POST DIV(f2)
   P             K,N           M

Example: (we set all factors at once, reducing dividers and multipliers
at the same time at 0ms - this should lead to no change in the output
frequency, but...)

-1ms: f0 = 24MHz, f1 = 2GHz,   f2 = 1GHz
 0ms: f0 = 24MHz, f1 = 2GHz,   f2 = 2GHz       - boom
 1ms: f0 = 24MHz, f1 = 1.5GHz, f2 = 1.5GHz
 2ms: f0 = 24MHz, f1 = 1GHz,   f2 = 1GHz

The current code crashes exactly at boom, you don't get any more
instructions to execute.

See.

So this patch first increases dividers (only if necessary), changes
multipliers and waits for change to happen (takes around 2000 cycles),
and then decreases dividers (only if necessary).

So we get:

-1ms: f0 = 24MHz, f1 = 2GHz,   f2 = 1GHz
 0ms: f0 = 24MHz, f1 = 2GHz,   f2 = 1GHz   - no boom, multiplier
                                             reduced
 1ms: f0 = 24MHz, f1 = 1.5GHz, f2 = 0.75GHz
1.9ms: f0 = 24MHz, f1 = 1GHz,   f2 = 0.5GHz - we got PLL sync
 2ms: f0 = 24MHz, f1 = 1GHz,   f2 = 1GHz   - and here we reduce divider
at last

>> +
>> +	if (FACTOR_GET(config->mshift, config->mwidth, reg) > req->m) {
>> +		reg = FACTOR_SET(config->mshift, config->mwidth, reg, req->m);
>> +
>> +		writel(reg, factors->reg);
>> +		__delay(2000);
>> +	}
>> +
>> +	if (FACTOR_GET(config->pshift, config->pwidth, reg) > req->p) {
>> +		reg = FACTOR_SET(config->pshift, config->pwidth, reg, req->p);
>> +
>> +		writel(reg, factors->reg);
>> +		__delay(2000);
>> +	}
> 
> However, this is kind of weird, why would you need to re-apply the
> dividers? Nothing really changes. Have you tried without that part?

See above, we either increase before PLL change, or reduce dividers
after the change. Nothing is re-applied.

> Since this is really specific, I guess you could simply make the
> clk_ops for the nkmp clocks public, and just re-implement set_rate
> using that logic.

I would argue that this may be necessary for other PLL clocks too, if
you can get out of bounds output frequency, by changing the dividers too
early or too late. So perhaps this code should be generalized for other
PLL clocks too, instead.

> 
> You might also need to set an upper limit on P, since the last value
> (4) is not a valid one.

I think, that should be done by the factors calculation function already.

> I guess you could do that by adding a max field in the __ccu_div
> structure.
> 
> Maxime
> 

regards,
  Ondrej

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160701/76a7525e/attachment.sig>
