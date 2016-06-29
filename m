From: megi@xff.cz (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Wed, 29 Jun 2016 17:30:51 +0200
Subject: [linux-sunxi] [PATCH 1/3] clk: sunxi: Add a driver for the CCU
In-Reply-To: <20160629085116.caf701e214440cdf4b1045c8@free.fr>
References: <bfb8ceb4-5445-3f43-0a16-bd0e83f2af22@xff.cz>
 <536aa072-d110-1b08-fa25-72c1645e2459@xff.cz>
 <20160629085116.caf701e214440cdf4b1045c8@free.fr>
Message-ID: <a827aa49-dde3-23fb-7c44-0dc8fd61948b@xff.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.6.2016 08:51, Jean-Francois Moine wrote:
> On Tue, 28 Jun 2016 21:31:06 +0200
> Ond?ej Jirman <megi@xff.cz> wrote:
> 
>>
>> On 28.6.2016 17:37, Jean-Francois Moine wrote:
>>> Most of the clocks in the Allwinner's SoCs are configured in the CCU
>>> (Clock Configuration Unit).
>>>
>>> The PLL clocks are driven from the main clock. Their rates are controlled
>>> by a set of multiply and divide factors, named from the Allwinner's
>>> documentation:
>>> - multipliers: 'n' and 'k'
>>> - dividers: 'd1', 'd2', 'm' and 'p'
>>>
>>> The peripheral clocks may receive their inputs from one or more parents,
>>> thanks to a mux. Their rates are controlled by a set of divide factors
>>> only, named 'm' and 'p'.
>>>
>>> This driver also handles:
>>> - fixed clocks,
>>> - the phase delays for the MMCs,
>>> - the clock gates,
>>> - the bus gates,
>>> - and the resets.
>>>
>>> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
>>> ---
>>>  drivers/clk/sunxi/Makefile |   2 +
>>>  drivers/clk/sunxi/ccu.c    | 980 +++++++++++++++++++++++++++++++++++++++++++++
>>>  drivers/clk/sunxi/ccu.h    | 153 +++++++
>>>  3 files changed, 1135 insertions(+)
>>>  create mode 100644 drivers/clk/sunxi/ccu.c
>>>  create mode 100644 drivers/clk/sunxi/ccu.h
> 	[snip]
>>> diff --git a/drivers/clk/sunxi/ccu.c b/drivers/clk/sunxi/ccu.c
>>> new file mode 100644
>>> index 0000000..5749f9c
>>> --- /dev/null
>>> +++ b/drivers/clk/sunxi/ccu.c
> 	[snip]
>>> +static void ccu_pll_set_flat_factors(struct ccu *ccu, u32 mask, u32 val)
>>> +{
>>> +	u32 reg, m_val, p_val;
>>> +	u32 m_mask = (1 << ccu->m_width) - 1;
>>> +	u32 p_mask = (1 << ccu->p_width) - 1;
>>
>> I see you have shifted the factor values to be set in the caller of this
>> function, but then you have to shift masks too, to match. It might be
>> clearer to do both shifts in this function.
> 
> Oops, yes. Thanks. (I did not test yet your patch about the CPU
> frequency)
> 
>>> +	reg = readl(ccu->base + ccu->reg);
>>> +	m_val = reg & m_mask;
>>> +	p_val = reg & p_mask;
>>> +
>>> +	spin_lock(&ccu_lock);
>>> +
>>> +	/* increase p, then m */
>>> +	if (ccu->p_width && p_val < (val & p_mask)) {
>>> +		reg &= ~p_mask;
>>> +		reg |= val & p_mask;
>>> +		writel(reg, ccu->base + ccu->reg);
>>> +		udelay(10);
>>> +	}
>>> +	if (ccu->m_width && m_val < (val & m_mask)) {
>>> +		reg &= ~m_mask;
>>> +		reg |= val & m_mask;
>>> +		writel(reg, ccu->base + ccu->reg);
>>> +		udelay(10);
>>> +	}
>>> +
>>> +	/* set other factors */
>>> +	reg &= ~(mask & ~(p_mask | m_mask));
>>> +	reg |= val & ~(p_mask | m_mask);
>>> +	writel(reg, ccu->base + ccu->reg);
>>> +
>>> +	/* decrease m */
>>> +	if (ccu->m_width && m_val > (val & m_mask)) {
>>> +		reg &= ~m_mask;
>>> +		reg |= val & m_mask;
>>> +		writel(reg, ccu->base + ccu->reg);
>>> +		udelay(10);
>>> +	}
>>> +
>>> +	/* wait for PLL stable */
>>> +	if (ccu->lock_reg) {
>>> +		u32 lock;
>>> +
>>> +		lock = BIT(ccu->lock_bit);
>>> +		WARN_ON(readl_relaxed_poll_timeout(ccu->base + ccu->lock_reg,
>>> +							reg, !(reg & lock),
>>> +							100, 70000));
>>> +	}
> 	[snip]
>>
>> Any reason why you're waiting for the lock after decreasing m and not
>> before? PLL output may till run too fast before reducing the postdivider
>> potentially causing a crash. But I might be misunderstanding what m is
>> exactly.
> 
> I just followed what is done in the function
>  sunxi_clk_factors_set_flat_facotrs() from Allwinnertech:
> 
> 	1).try to increase factor p first
> 	2).try to increase factor m first
> 	3. write factor n & k
> 	4. do pair things for 2). decease factor m
> 	5. wait for PLL state stable
> 	6.do pair things for 1).  decease factor p
> 
> As this is written, it seems m is a pre-divider.
> 

Interesting. :) I've reverse engineered their arisc code, and there the
order for setting up/changing PLL1 is:

1. try to increase factor p first
2. try to increase factor m first
3. write factor n & k
4. wait for PLL state stable
5. do pair things for 2). decease factor m
6. do pair things for 1).  decease factor p

That's why I asked.

So all this depends on the design of this clock source. It may be
different for different PLLs.

Hard to know what to believe. Perhaps it would be possible to create a
PLL stress tester that would try both approaches and see whether one of
them is more stable/leads to creashes?

regards,
  Ondrej

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160629/24e0a893/attachment-0001.sig>
