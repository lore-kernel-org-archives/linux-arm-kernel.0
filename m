From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 05 Feb 2015 21:06:48 +0100
Subject: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
In-Reply-To: <54D3C803.30706@samsung.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <54D3C803.30706@samsung.com>
Message-ID: <54D3CD58.4030902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/15 20:44, Sylwester Nawrocki wrote:
>> +void __clk_put(struct clk *clk)
>> > +{
>> > +	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>> > +		return;
>> > +
>> > +	clk_core_put(clk->core);
>> > +	kfree(clk);
>
> Why do we have kfree() here? clk_get() doesn't allocate the data structure 
> being freed here. What happens if we do clk_get(), clk_put(), clk_get() 
> on same clock?
> 
> I suspect __clk_free_clk() should be called in __clk_release() callback
> instead, but then there is an issue of safely getting reference to
> struct clk from struct clk_core pointer.

Please ignore this comment, I missed __clk_create_clk() calls in clkdev.c
Anyway, in current -next I'm seeing random pointer dereferences while
booting Odroid U3, I'll get back to debugging this tomorrow morning.

-- 
Regards,
Sylwester
