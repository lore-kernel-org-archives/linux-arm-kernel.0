From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 10 Jan 2013 13:06:16 -0800
Subject: [PATCH 1/2] clk: Add composite clock type
In-Reply-To: <50E794D0.7040907@nvidia.com>
References: <1357278706-28149-1-git-send-email-pgaikwad@nvidia.com>
 <50E75538.5010706@codeaurora.org> <50E794D0.7040907@nvidia.com>
Message-ID: <50EF2D48.2080004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/13 18:49, Prashant Gaikwad wrote:
> On Saturday 05 January 2013 03:48 AM, Stephen Boyd wrote:
>> On 01/03/13 21:51, Prashant Gaikwad wrote:
>>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>>> index f0b269a..baf7608 100644
>>> --- a/drivers/clk/Makefile
>>> +++ b/drivers/clk/Makefile
>>> @@ -2,7 +2,8 @@
>>>   obj-$(CONFIG_HAVE_CLK)        += clk-devres.o
>>>   obj-$(CONFIG_CLKDEV_LOOKUP)    += clkdev.o
>>>   obj-$(CONFIG_COMMON_CLK)    += clk.o clk-fixed-rate.o clk-gate.o \
>>> -                   clk-mux.o clk-divider.o clk-fixed-factor.o
>>> +                   clk-mux.o clk-divider.o clk-fixed-factor.o \
>>> +                   clk-composite.o
>> This list is getting a little out of hand. Should we sort it
>> alphabetically and put each file on one line?
>
> Do you want me to do it in this patch?
>
>

No.

>>> +static u8 clk_composite_get_parent(struct clk_hw *hw)
>>> +{
>>> +    struct clk_composite *composite = to_clk_composite(hw);
>>> +    const struct clk_ops *mux_ops = composite->mux_ops;
>>> +    struct clk_hw *mux_hw = composite->mux_hw;
>>> +
>>> +    mux_hw->clk = hw->clk;
>> Looks like this is already done down in the register function. Why are
>> we doing it again here and in each op?
>
> Some ops gets called during clk_init which is before clk_register
> returns.
>
>

Hmm. Ok.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
