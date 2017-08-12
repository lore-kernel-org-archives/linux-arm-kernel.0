From: icenowy@aosc.io (icenowy at aosc.io)
Date: Sat, 12 Aug 2017 12:49:46 +0800
Subject: [linux-sunxi] Re: [PATCH v6 1/6] clk: sunxi-ng: div: Add support
 for fixed post-divider
In-Reply-To: <CAGb2v675Y3AAa747-3VqsPN64YOk11v5Gm3_yq5ZeJ=YPz596g@mail.gmail.com>
References: <cover.ba2aaaa405a7ec685034e34926b8855fd6c9ab86.1500043741.git-series.plaes@plaes.org>
 <946794e97ae2c36cd67c272099e8236a589efc28.1500043741.git-series.plaes@plaes.org>
 <20170717085235.i7pwwql5dgmnf6kk@flea>
 <d3ca32de91e857a8933fd570600cda17@aosc.io>
 <CAGb2v675Y3AAa747-3VqsPN64YOk11v5Gm3_yq5ZeJ=YPz596g@mail.gmail.com>
Message-ID: <1c52cfe1ac634f01ea386fef6b1b525b@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-08-12 12:13?Chen-Yu Tsai ???
> On Sat, Aug 12, 2017 at 11:07 AM,  <icenowy@aosc.io> wrote:
>> ? 2017-07-17 16:52?Maxime Ripard ???
>>> 
>>> On Fri, Jul 14, 2017 at 05:49:23PM +0300, Priit Laes wrote:
>>>> 
>>>> SATA clock on sun4i/sun7i is of type (parent) / M / 6 where
>>>> 6 is fixed post-divider.
>>>> 
>>>> Signed-off-by: Priit Laes <plaes@plaes.org>
>>>> ---
>>>>  drivers/clk/sunxi-ng/ccu_div.c | 15 +++++++++++++--
>>>>  drivers/clk/sunxi-ng/ccu_div.h |  3 ++-
>>>>  2 files changed, 15 insertions(+), 3 deletions(-)
>>>> 
>>>> diff --git a/drivers/clk/sunxi-ng/ccu_div.c
>>>> b/drivers/clk/sunxi-ng/ccu_div.c
>>>> index c0e5c10..744502a 100644
>>>> --- a/drivers/clk/sunxi-ng/ccu_div.c
>>>> +++ b/drivers/clk/sunxi-ng/ccu_div.c
>>>> @@ -21,6 +21,9 @@ static unsigned long ccu_div_round_rate(struct
>>>> ccu_mux_internal *mux,
>>>>  {
>>>>         struct ccu_div *cd = data;
>>>> 
>>>> +       if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
>>>> +               rate *= cd->fixed_post_div;
>>>> +
>>>>         return divider_round_rate_parent(&cd->common.hw, parent,
>>>>                                          rate, parent_rate,
>>>>                                          cd->div.table, 
>>>> cd->div.width,
>>> 
>>> 
>>> 
>>> You still haven't addressed the biggest issue with this patch, see:
>>> https://patchwork.kernel.org/patch/9825565/
>> 
>> 
>> I think he has already did the changes suggested in the review.
> 
> Nope. Only half of it is fixed. First you "unapply" the post-divider,
> i.e. multiply the rate by the divider. Then you pass it to
> divider_round_rate_parent. You still have to reapply the divider
> to the result. This last part is missing. This means the clock
> rate returned by ccu_div_round_rate is going to be off.
> 
> Instead the return statement should be
> 
>     return divider_round_rate_parent(...) / cd->fixed_post_div

Oh, got it by reading other CCU clock types that has fixed postdiv.

Thanks!

> 
> ChenYu
> 
>> 
>> (P.S. during developing R40 CCU driver I found that pll-periph0-sata
>> also needs this patch, so I'm rechecking it)
>> 
>>> 
>>> Maxime
>>> 
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> 
>> 
>> --
>> You received this message because you are subscribed to the Google 
>> Groups
>> "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send 
>> an
>> email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
