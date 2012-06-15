From: robherring2@gmail.com (Rob Herring)
Date: Thu, 14 Jun 2012 23:32:53 -0500
Subject: [PATCH v3 1/4] clk: add DT clock binding support
In-Reply-To: <20120615031747.GG31565@S2101-09.ap.freescale.net>
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
 <1339512111-11172-2-git-send-email-robherring2@gmail.com>
 <20120615031747.GG31565@S2101-09.ap.freescale.net>
Message-ID: <4FDABAF5.3090201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2012 10:17 PM, Shawn Guo wrote:
> On Tue, Jun 12, 2012 at 09:41:48AM -0500, Rob Herring wrote:
>> +struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
>> +{
>> +	struct of_clk_provider *provider;
>> +	struct clk *clk = NULL;
> 
> Both clk and clkdev treat NULL as a valid clock and return ERR_PTR for
> error case, while all the codes in this patch just return NULL for
> error and check (clk != NULL) for valid clock.

Because Grant hates ERR_PTR... :)

> 
> Should we force the consistent behavior between DT and non-DT on this?

Yes, I agree and will change it.

Rob

> 
>> +
>> +	/* Check if we have such a provider in our array */
>> +	mutex_lock(&of_clk_lock);
>> +	list_for_each_entry(provider, &of_clk_providers, link) {
>> +		if (provider->node == clkspec->np)
>> +			clk = provider->get(clkspec, provider->data);
>> +		if (clk)
>> +			break;
>> +	}
>> +	mutex_unlock(&of_clk_lock);
>> +
>> +	return clk;
>> +}
> 
