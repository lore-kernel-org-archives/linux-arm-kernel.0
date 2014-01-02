From: zhangfei.gao@linaro.org (zhangfei)
Date: Thu, 02 Jan 2014 10:19:26 +0800
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <20131231132003.GR8064@book.gsilab.sittig.org>
References: <1388241295-20051-1-git-send-email-zhangfei.gao@linaro.org>
 <1388241295-20051-3-git-send-email-zhangfei.gao@linaro.org>
 <201312292205.02135.arnd@arndb.de>
 <20131231132003.GR8064@book.gsilab.sittig.org>
Message-ID: <52C4CCAE.6070001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/31/2013 09:20 PM, Gerhard Sittig wrote:
> On Sun, Dec 29, 2013 at 22:05 +0100, Arnd Bergmann wrote:
>>
>> On Saturday 28 December 2013, Zhangfei Gao wrote:
>>
>>> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>> +{
>>> +	struct dw_mci_k3_priv_data *priv = host->priv;
>>> +	u32 rate = priv->clk_table[ios->timing];
>>> +	int ret;
>>
>> [ ... ]
>>
>>> +
>>> +	ret = clk_set_rate(host->ciu_clk, rate);
>>> +	if (ret)
>>> +		dev_warn(host->dev, "failed to set clock rate %uHz\n", rate);
>>> +
>>> +	host->bus_hz = clk_get_rate(host->ciu_clk);
>>> +}
>>
>> Why do you call clk_get_rate() here, shouldn't it always be the same
>> rate that you have just set?
>
> Not necessarily.  What you pass to clk_set_rate() is the
> rate/frequency that you _want_, while what you get from
> clk_get_rate() is the rate you _got_ taking the specific input
> clock rate and the available sets of multipliers/dividers into
> consideration.  Both values should be similar (roughly the same),
> but they need not be identical.  The order of the difference
> depends on the granularity of the hardware dividers or whether
> PLLs are used.
>
> So, re-fetching the resulting rate after setting up a desired
> rate actually better reflects the status-quo for diagnostics or
> for subsequent processing.

Thanks Gerhard for the professional explanation.
