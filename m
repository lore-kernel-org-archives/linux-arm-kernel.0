From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Apr 2012 16:00:53 +0530
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416102503.GA32687@glitch>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch>
Message-ID: <4F8BF4DD.2080501@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/2012 3:55 PM, Domenico Andreoli wrote:
> On Mon, Apr 16, 2012 at 10:49:37AM +0530, Viresh Kumar wrote:
>> From: Russell King <rmk+kernel@arm.linux.org.uk>
>> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
>> +int clk_register_single_clkdev(struct clk *clk, const char *dev_id,
>> +		const char *con_id)
>> +{
>> +	struct clk_lookup *cl;
>> +
>> +	if (!clk || (!dev_id && !con_id))
>> +		return -ENOMEM;
> 
> I would return -EINVAL here.

Will fix it.

>> +
>> +	cl = clkdev_alloc(clk, con_id, "%s", dev_id);
> 
> clkdev_alloc() allows you to specify dev_fmt and possibly other arguments
> to build the dev_id on the fly, could clk_register_single_clkdev()
> preserve this ability?

Can be done. Maybe we can create two versions here: with and without dev_fmt.

>> +	if (!cl)
>> +		return -ENOMEM;
>> +
>> +	clkdev_add(cl);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(clk_register_single_clkdev);
>> +
>> +int clk_register_clkdevs(struct clk *clk, struct clk_lookup *cl, size_t num)
>> +{
>> +	unsigned i;
>> +
>> +	if (!clk || !cl || !num)
>> +		return -ENOMEM;
> 
> I would return -EINVAL here as well.

Will fix this too.

-- 
viresh
