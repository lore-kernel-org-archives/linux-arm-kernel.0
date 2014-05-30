From: elder@linaro.org (Alex Elder)
Date: Fri, 30 May 2014 09:05:31 -0500
Subject: [PATCH v2 2/5] clk: bcm281xx: implement prerequisite clocks
In-Reply-To: <5387F8EF.3030607@linaro.org>
References: <1400590362-11177-1-git-send-email-elder@linaro.org>
 <1400590362-11177-3-git-send-email-elder@linaro.org>
 <20140524005358.23136.8918@quantum> <5387F8EF.3030607@linaro.org>
Message-ID: <5388902B.9080302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2014 10:20 PM, Alex Elder wrote:
> On 05/23/2014 07:53 PM, Mike Turquette wrote:
>> Quoting Alex Elder (2014-05-20 05:52:39)
>>> @@ -743,11 +746,16 @@ struct clk *kona_clk_setup(struct kona_clk *bcm_clk)
>>>         clk = clk_register(NULL, &bcm_clk->hw);
>>>         if (IS_ERR(clk)) {
>>>                 pr_err("%s: error registering clock %s (%ld)\n", __func__,
>>> -                       init_data->name, PTR_ERR(clk));
>>> +                       name, PTR_ERR(clk));
>>>                 goto out_teardown;
>>>         }
>>>         BUG_ON(!clk);
>>>  
>>> +       /*  Make it so we can look the clock up using clk_find() */
>>
>> s/clk_find/clk_get/ ?
>>
>>> +       bcm_clk->cl.con_id = name;
>>> +       bcm_clk->cl.clk = clk;
>>> +       clkdev_add(&bcm_clk->cl);
>>
>> This is not so nice. I'll explain more below.
> 
> OK, despite what I said before, I do need this, or
> something like it, so I can look up clocks by name.
> (Continued below.)
...

I've been thinking this morning about ways to at least
improve this.  The problem is worse than just prerequisite
clocks polluting the global name space.  Right now *all*
clocks get their name registered this way, because any one
of them could be tagged as a prerequisite, and therefore
in need of lookup by name.

If I had a device structure to associate the clock names
with it would help, but I don't have one.  There is no
other way to define a separate name space, it's either
associated with a device, or it's global.

Given all that, I could prefix or suffix the clock names
with some special string, in order to sort of carve out a
reserved portion of the global name space.

I could specify the prerequisite clock by its index in
its CCU's clocks array.  I could then manufacture a
of_phandle_args structure and use of_clk_get_from_provider()
to look up what we need, but that seems kind of kludgy.
Maybe a new function could encapsulate the messy details
of that.

Do you have any suggestions?  I can create some new
common code if appropriate, but only if it represents
missing functionality that's generally useful.

					-Alex
