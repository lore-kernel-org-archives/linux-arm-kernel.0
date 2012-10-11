From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Thu, 11 Oct 2012 14:07:24 +0000
Subject: [PATCH 01/13] calk: davinci - add Main PLL clock driver
In-Reply-To: <50769C53.8030405@ti.com>
References: <1348682889-9509-1-git-send-email-m-karicheri2@ti.com>
 <1348682889-9509-2-git-send-email-m-karicheri2@ti.com>
 <507563C3.2000305@ti.com>
 <3E54258959B69E4282D79E01AB1F32B7041FB712@DFLE12.ent.ti.com>
 <50769C53.8030405@ti.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7041FDA05@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> -----Original Message-----
>> From: Nori, Sekhar
>> Sent: Thursday, October 11, 2012 6:16 AM
>> To: Karicheri, Muralidharan
>> Cc: mturquette at linaro.org; arnd at arndb.de; akpm at linux-foundation.org;
>> shawn.guo at linaro.org; rob.herring at calxeda.com; linus.walleij at linaro.org;
>> viresh.linux at gmail.com; linux-kernel at vger.kernel.org; Hilman, Kevin;
>> linux at arm.linux.org.uk; davinci-linux-open-source at linux.davincidsp.com; linux-arm-
>> kernel at lists.infradead.org; linux-keystone at list.ti.com - Linux developers for Keystone
>> family of devices (May contain non-TIers); linux-c6x-dev at linux-c6x.org; Chemparathy,
>> Cyril
>> Subject: Re: [PATCH 01/13] calk: davinci - add Main PLL clock driver
>> 
>> On 10/10/2012 8:04 PM, Karicheri, Muralidharan wrote:
>> 
>> >>>> +struct clk *clk_register_davinci_pll(struct device *dev, const char *name,
>> >>>> +			const char *parent_name,
>> >>>> +			struct clk_davinci_pll_data *pll_data) {
>> >>>> +	struct clk_init_data init;
>> >>>> +	struct clk_davinci_pll *pll;
>> >>>> +	struct clk *clk;
>> >>>> +
>> >>>> +	if (!pll_data)
>> >>>> +		return ERR_PTR(-ENODEV);
>> >>>> +
>> >>>> +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
>> >>>> +	if (!pll)
>> >>>> +		return ERR_PTR(-ENOMEM);
>> >>>> +	init.name = name;
>> >>>> +	init.ops = &clk_pll_ops;
>> >>>> +	init.flags = pll_data->flags;
>> >>>> +	init.parent_names = (parent_name ? &parent_name : NULL);
>> >>>> +	init.num_parents = (parent_name ? 1 : 0);
>> >>>> +
>> >>>> +	pll->pll_data	= pll_data;
>> >>>> +	pll->hw.init = &init;
>> >>>> +
>> >>>> +	clk = clk_register(NULL, &pll->hw);
>> >>>> +	if (IS_ERR(clk))
>> >>>> +		kfree(pll);
>> >>>> +
>> >>>> +	return clk;
>> >>>> +}
>> >>>
>> >>> I guess there is an an "unregister" required as well which will free
>> >>> the pll memory allocated above and unregister the clock? Not sure if
>> >>> you would ever unregister a PLL, but providing this will probably help symmetry.
>> > Sekhar,
>> >
>> > clk_unregister() itself is a null statement in clk.c. Besides none of the clk drivers
>> presently have implemented the unregister(). So I believe this is unnecessary.
>> 
>> I am ok with this.
>> 
>> > BTW, please review the v2 patch for the rest of the series. For the one you have
>> already reviewed, it should be fine.
>> 
>> Okay. I see those now. BTW, this series also has a v2 in its 0/13. Are there any
>> differences between this and the other v2, or is that merely a resend?
>> 

You are right. I did a re-send to add v2 in all of the patch subject. We are fine.

>> Thanks,
>> Sekhar
