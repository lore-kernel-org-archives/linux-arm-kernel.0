From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 Jan 2018 17:55:16 +0530
Subject: [PATCH v5 10/44] clk: davinci: New driver for davinci PSC clocks
In-Reply-To: <83f3d207-9645-cbdf-d6cf-b6e6a8458abe@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-11-git-send-email-david@lechnology.com>
 <e0a9af55-a8b1-c359-fe88-d038648e02f1@ti.com>
 <83f3d207-9645-cbdf-d6cf-b6e6a8458abe@lechnology.com>
Message-ID: <1b568e12-dd45-f371-a1a8-576c97a6b58e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 January 2018 10:21 PM, David Lechner wrote:

>>> +static struct clk *davinci_psc_clk_register(const char *name,
>>> +??????????????????????? const char *parent_name,
>>> +??????????????????????? struct regmap *regmap,
>>> +??????????????????????? u32 lpsc, u32 pd, u32 flags)
>>> +{
>>> +??? struct clk_init_data init;
>>> +??? struct davinci_psc_clk *psc;
>>> +??? struct clk *clk;
>>> +
>>> +??? psc = kzalloc(sizeof(*psc), GFP_KERNEL);
>>> +??? if (!psc)
>>> +??????? return ERR_PTR(-ENOMEM);
>>> +
>>> +??? init.name = name;
>>> +??? init.ops = &davinci_psc_clk_ops;
>>> +??? init.parent_names = (parent_name ? &parent_name : NULL);
>>> +??? init.num_parents = (parent_name ? 1 : 0);
>>> +??? init.flags = CLK_SET_RATE_PARENT;
>>
>> Is this needed since PSC does not cause any rate change?
> 
> Yes, because one of the PSCs is the ARM clock and for cpufreq, we
> need to propagate the rate change up the chain to SYSCLK6.

Good point. But how about treating that as an exception with a new LPSC_
quirk flag?

Thanks,
Sekhar
