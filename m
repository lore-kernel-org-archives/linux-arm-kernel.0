From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 12 Jul 2010 09:37:43 +0530
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100709124050.GF22845@n2100.arm.linux.org.uk>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
Message-ID: <4C3A950F.5040900@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/9/2010 6:10 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 22, 2010 at 10:37:27AM +0530, Viresh KUMAR wrote:
>> -	spin_lock_init(&chip->lock);
>> -	spin_lock_init(&chip->irq_lock);
>> -	INIT_LIST_HEAD(&chip->list);
>> +	chip->clk = clk_get(&dev->dev, NULL);
>> +	if (IS_ERR(chip->clk)) {
>> +		ret = PTR_ERR(chip->clk);
>> +		/* clk Not present */
>> +		if (ret == -ENOENT)
>> +			chip->clk = NULL;
> 
> Please don't assume that NULL is not a valid value for a 'struct clk'.
> Eg,
> 
> struct clk *clk_get(struct device *dev, const char *id)
> {
>         return dev && strcmp(dev_name(dev), "mb:16") == 0 ? NULL : ERR_PTR(-ENOENT);
> }

I knew this. This convention is just local to the driver.

> 
> However, this patch begs the question about what you're trying to do,
> as the primecell doesn't take a clock for its operation other than the
> AMBA bus clock.

This issue is different from the issue i raised which was common to
all amba devices. This is just for this GPIO driver, we need to enable clk
before using any gpio pin.


viresh.
