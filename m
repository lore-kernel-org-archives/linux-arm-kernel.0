From: Ying.Liu@freescale.com (Liu Ying)
Date: Tue, 20 Aug 2013 18:08:48 +0800
Subject: [PATCH 0/3] refactor some ldb related clocks
In-Reply-To: <1376991823.4000.22.camel@pizza.hi.pengutronix.de>
References: <1376987932-5540-1-git-send-email-Ying.Liu@freescale.com>
 <1376991823.4000.22.camel@pizza.hi.pengutronix.de>
Message-ID: <52134030.4030502@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2013 05:43 PM, Philipp Zabel wrote:
> Am Dienstag, den 20.08.2013, 16:38 +0800 schrieb Liu Ying:
>> The ldb_di[0/1]_ipu_div clock dividers in the CSCMR2 register
>> of i.MX53, i.MX6Q and i.MX6DL SoCs can be configured to a 1/3.5
>> drivider or a 1/7 divider. The common clock framework cannot
>> deal with the two dividers directly even with the divider table
>> which only supports integral dividers. So, the idea is to take
>> the 1/3.5 and 1/7 dividers as separate fixed factor dividers and
>> introduce a new multiplexer clock to be derived from the them.
>> Then, the ldb display clock trees can be setup correctly.
>> This series contains the necessary clock driver changes, dts code
>> changes and imx-drm/ldb driver changes to fullfill the task.
> 
> I don't see how this improves the situation. Does this solve any real
> problem?
>

I don't see any functional problem without this series.
But, it may correct ldb_di[n] clock frequency returned from clk_get_rate() when using 1/7 divider.
Furthermore, since this series makes the ldb related clocks from pll to ldb_di[0/1] have the CLK_SET_RATE_PARENT flag set, the imx-drm/ldb driver may set the clocks' frequency more flexibly, i.e.,
only calling clk_set_rate() for ldb_di[n] clock would be an alternative.

> While I admit to having introduced the combination of 1/3.5 fixed
> divider and configurable 1/1,1/2 divder clocks to describe this
> fractional divider for the reasons you state, I think the correct
> solution would be to improve the table divider to support fractional
> values and get rid of the virtual ldb_di<n>_div_3_5 clocks, not
> introduce more virtual clocks.

Yes, it's good to support fractional values for the table divider(not sure if there is any plan for this).
I see there is something similar in 'include/linux/sh_clk.h'.

> 
> regards
> Philipp
> 
> 

Regards,
Liu Ying
