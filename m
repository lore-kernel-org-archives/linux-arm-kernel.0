From: claude.youn@gmail.com (Seungwhan Youn)
Date: Fri, 8 Oct 2010 19:45:14 +0900
Subject: [PATCH 3/10] ARM: S5PC100: Add SCLK_SPDIF clock
In-Reply-To: <001901cb66d1$32db1e10$98915a30$%kim@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286192545-18327-1-git-send-email-sw.youn@samsung.com>
	<001901cb66d1$32db1e10$98915a30$%kim@samsung.com>
Message-ID: <AANLkTinZuMkDNotnwDFS8_EPhbG+p_GWEZjU5thzvW++@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> +static int s5pc100_spdif_set_rate(struct clk *clk, unsigned long rate)
>> +{
>> + ? ? struct clk *pclk;
>> + ? ? int ret;
>> +
>> + ? ? pclk = clk_get_parent(clk);
>> + ? ? if (IS_ERR(pclk))
>> + ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? ret = pclk->ops->set_rate(pclk, rate);
>> + ? ? clk_put(pclk);
>> +
>> + ? ? return ret;
>
> How about following?
>
> static int parent_set_rate(struct clk *clk, unsigned long rate)
> {
> ? ? ? ?struct clk *p_clk;
> ? ? ? ?int ret;
>
> ? ? ? ?p_clk = clk_get_parent(clk);
> ? ? ? ?ret = clk_set_rate(p_clk, rate);
>
> ? ? ? ?clk_put(p_clk);
>
> ? ? ? ?return ret;
> }
>
> Hmm...isn't there any method?...

I think you mean is that adds a new clock api function that sets
parent clock rate.(am I right?) But as you know, this also needs that
S/PDIF knows it's source clock can not set rate directly and set it's
parent clock.

Actually my point was that I want to make S/PDIF does not care about
clock characteristics, so I did make it solve in clock part, not in
audio driver. And also, I do not want to modify a common function
'clk_set_rate()' that can support jassi's opinion, because I'm not
sure about side effect that I can not grantee it's safety with other
drivers.

(snip)

Thanks,
Claude
