From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 06 Oct 2014 12:31:45 -0700
Subject: [PATCH 1/2] clk: Make clk API return per-user struct clk instances
In-Reply-To: <CAAObsKDa=ia3Gbu1WkoUBjXt2GCoysK7rv=3PzLarnfS7K5ZLA@mail.gmail.com>
References: <1412255097-15928-1-git-send-email-tomeu.vizoso@collabora.com>
 <1412255097-15928-2-git-send-email-tomeu.vizoso@collabora.com>
 <20141003231515.GM10233@codeaurora.org>
 <CAAObsKDa=ia3Gbu1WkoUBjXt2GCoysK7rv=3PzLarnfS7K5ZLA@mail.gmail.com>
Message-ID: <5432EE21.7030906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2014 10:14 AM, Tomeu Vizoso wrote:
>> This is the end goal. I understand that the provider API is sort
>> of a mess with us allowing drivers to use the underscore and
>> non-underscore functions and the mixture of struct clk and struct
>> ckl_hw throughout.
>>
>>   struct clk_hw <--> struct clk_core <----> struct clk
>>                                         \-> struct clk
>>                                         |-> struct clk
> Agree this is how it should look like at some point, but for now I
> need a reference to struct clk from struct clk_hw, so providers can
> keep using the existing API. This reference would be removed once they
> move to the new clk_hw-based API.

Ok sounds like we're on the same page.

>>> +struct clk *__clk_create_clk(struct clk_core *clk_core, const char *dev_id,
>>> +                          const char *con_id);
>>> +#endif
>>> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
>>> index da4bda8..fe3712f 100644
>>> --- a/drivers/clk/clkdev.c
>>> +++ b/drivers/clk/clkdev.c
>>> @@ -168,14 +172,27 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
>>>   struct clk *clk_get_sys(const char *dev_id, const char *con_id)
>>>   {
>>>        struct clk_lookup *cl;
>>> +     struct clk *clk = NULL;
>>>
>>>        mutex_lock(&clocks_mutex);
>>>        cl = clk_find(dev_id, con_id);
>>> -     if (cl && !__clk_get(cl->clk))
>>> -             cl = NULL;
>>> +     if (cl) {
>>> +#if defined(CONFIG_COMMON_CLK)
>>> +             clk = __clk_create_clk(cl->clk->core, dev_id, con_id);
>>> +             if (clk && !__clk_get(clk)) {
>>> +                     kfree(clk);
>> This looks weird. It makes me suspect we've failed to reference
>> count something properly. Can we avoid this?
> Can you extend on this? But I see how the behaviour doesn't match the
> previous one because cl should be NULLed when __clk_get fails. I have
> fixed this.

It triggers my "that's not symmetric filter" because it requires the 
caller to free something allocated by the callee. Do we still need 
__clk_get() to be called in the common clock path? Why not just do the 
stuff we do in __clk_get() in __clk_create_clk()? Then if that fails we 
can return an error pointer indicating some sort of failure (-ENOENT?) 
and we don't need to do any sort of cleanup otherwise.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
