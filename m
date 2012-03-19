From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 19 Mar 2012 12:09:01 -0700
Subject: [PATCH v7 2/3] clk: introduce the common clock framework
In-Reply-To: <20120319112858.GX3852@pengutronix.de>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-3-git-send-email-mturquette@linaro.org>
 <4F6716DD.5090900@ti.com> <20120319112858.GX3852@pengutronix.de>
Message-ID: <CAJOA=zOgHXy1_J+LG1LUWwsESwrtqAvrgHKUR22AJdsbRHa+YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 4:28 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Mon, Mar 19, 2012 at 04:52:05PM +0530, Rajendra Nayak wrote:
>> Hi Mike,
>>
>> >+/*
>> >+ * calculate the new rates returning the topmost clock that has to be
>> >+ * changed.
>> >+ */
>> >+static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
>> >+{
>> >+ ? ?struct clk *top = clk;
>> >+ ? ?unsigned long best_parent_rate = clk->parent->rate;
>>
>> Shouldn't you check for a valid parent before dereferencing it? A
>> clk_set_rate() on a root clock might throw up some issues otherwise.
>>
>
> Yes, should be checked.

The clk_calc_new_rates code assumes a valid parent pointer in several
locations.  Thanks for the catch Rajendra.  Will roll into my fixes
series.

>> >+ ? ?unsigned long new_rate;
>> >+
>> >+ ? ?if (!clk->ops->round_rate&& ?!(clk->flags& ?CLK_SET_RATE_PARENT)) {
>> >+ ? ? ? ? ? ?clk->new_rate = clk->rate;
>> >+ ? ? ? ? ? ?return NULL;
>>
>> So does this mean a clk_set_rate() fails for a clk which does not have
>> a valid .round_rate and does not have a CLK_SET_RATE_PARENT flag set?
>> I was thinking this could do a..
>> ? ? ? ? ? ? ? clk->new_rate = rate;
>> ? ? ? ? ? ? ? top = clk;
>> ? ? ? ? ? ? ? goto out;
>> ..instead.
>
> The core should make sure that either both set_rate and round_rate are
> present or none of them.

Agreed.  The documentation covers which clk_ops are hard dependencies
(based on supported operations), but the code doesn't strictly check
this.  I'll add a small state machine to __clk_init which validates
that .round_rate, .recalc_rate and .set_rate are *all* present if any
one of them are present, and present a WARN if otherwise.

Thanks,
Mike
