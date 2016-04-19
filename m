From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Tue, 19 Apr 2016 15:11:55 +0800
Subject: [RESEND PATCH v10 2/6] clk: hisilicon: add CRG driver for hi3519
 soc
In-Reply-To: <20160416004055.GN26353@codeaurora.org>
References: <1459411811-12390-1-git-send-email-xuejiancheng@hisilicon.com>
 <1459411811-12390-3-git-send-email-xuejiancheng@hisilicon.com>
 <20160416004055.GN26353@codeaurora.org>
Message-ID: <5715DA3B.1070605@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 2016/4/16 8:40, Stephen Boyd wrote:
> On 03/31, Jiancheng Xue wrote:
>> diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
>> new file mode 100644
>> index 0000000..ee9df82
>> --- /dev/null
>> +++ b/drivers/clk/hisilicon/clk-hi3519.c
>> @@ -0,0 +1,129 @@
>> +/*
>> + * Hi3519 Clock Driver
>> + *
>> + * Copyright (c) 2015-2016 HiSilicon Technologies Co., Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
[...]
>> +static int hi3519_clk_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +	struct hisi_clock_data *clk_data;
>> +
>> +	clk_data = hisi_clk_init(np, HI3519_NR_CLKS);
>> +	if (!clk_data)
>> +		return -ENODEV;
>> +
>> +	hisi_clk_register_fixed_rate(hi3519_fixed_rate_clks,
>> +				     ARRAY_SIZE(hi3519_fixed_rate_clks),
>> +				     clk_data);
>> +	hisi_clk_register_mux(hi3519_mux_clks, ARRAY_SIZE(hi3519_mux_clks),
>> +					clk_data);
>> +	hisi_clk_register_gate(hi3519_gate_clks,
>> +			ARRAY_SIZE(hi3519_gate_clks), clk_data);
>> +
>> +	return hisi_reset_init(np);
> 
> Now that this is a platform driver we need to do lots of cleanup
> in error cases. I mean we need to unregister clks, OF clk
> providers, and reset controllers. Please add all that code too.
> 
Practically, clock driver is always needed during the whole system running.
It must be probed and never be removed. Is it a must for clock driver being
a platform driver? If it's not, I'd prefer to use CLK_OF_DECLARE instead.
Could you help me to understand the advantage of platform driver here? If
it's really a must, I will continue to fix these bugs as you pointed. It indeed
needs to be changed a lot including drivers/clk/hisilicon/clk.c.

Thank you!

Regards,
Jiancheng
