From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Sep 2010 11:16:32 +0900
Subject: [PATCH 1/3] Add a common struct clk
In-Reply-To: <AANLkTi=YqY29cFebB4c9qoMkyQyHmsfCc7p4_UJL_t1p@mail.gmail.com>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<1284522014.517347.33297989274.1.gpush@pororo>
	<AANLkTi=vaOzRcoGM9AnJ+17e0-97b76F5DW964fC3Wwp@mail.gmail.com>
	<1284683074.3350.73.camel@pororo>
	<AANLkTi=YqY29cFebB4c9qoMkyQyHmsfCc7p4_UJL_t1p@mail.gmail.com>
Message-ID: <AANLkTikazxn8c2mJYDJ-td9LKq-v=0K92=g0oj3cS7W=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 17, 2010 at 9:55 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Fri, Sep 17, 2010 at 9:24 AM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
>> Hi Jassi,
>>
>>> I am not sure about the scope of your assumed task, but I would still
>>> like to bring
>>> to your notice some points.
>>>
>>> IMHO any clock api that aims to be used by multiple platforms should be generic
>>> more than this one. Let me explain.
>>
>> None of my patches change the clock API itself. The clock API is already
>> in use on ARM (ie, multiple platforms) and seems to work for most cases.
>>
>>> Clocks that are simply output of MUX'es inherit the rate of the parent
>>> clock - they do have
>>> rate yet this API would return 0 (IIRUIC).
>>
>> The proposed clock infrastructure does not provide implementations for
>> the clock operation functions (like get_rate, which you're referring to
>> here). The behaviour of the clocks is dictated by each implementation of
>> struct clk. For MUXes, the callback for clk->ops.get_rate would be
>> something like:
>>
>> unsigned long clk_mux_get_rate(struct clk *clk)
>> {
>> ? ? ? ?return clk_get_rate(to_clk_mux(clk)->parent);
>> }
>>
>> - so it just returns the rate of the parent (not 0). However, if the
>> clock implementation has a reason to return 0, it is free to do so.
>
> IMHO, the API needs to define a more generic clock that covers the 'classic'
> and mux'ed clock by same data structure.
> That implies fixing the API and modify the drivers (if need be) rather than have
> multiple implementations of API. Let platforms move to the new one at their own
> pace.
In retrospect, I think I needed to add more...
Clock API should assume that output clock of a scaling block provides
it's clk_get/set_rate,
while output clock of a MUX/Input-Pad are indicated by absence of
clk_get/set_rate.
IMHO, most users would want to set/get rate of the parent in latter
case because that
tells the reality better. You might want to do that by default in the
clk_get/set_rate function. Let the exception(0 return) be defined in
the clk's get_rate.

+unsigned long clk_get_rate(struct clk *clk)
+{
+       if (clk->ops->get_rate)
+               return clk->ops->get_rate(clk);
+      else
+               return clk_get_rate(clk->parent);
+}

The assumed definition of clock also dictates the enable/disable be
recursively called for the parent as well -- input to scaling block or
a MUX need
not be kept enabled if none needs it or be disabled while someone needs it.

I think these assumptions are modest and (may I daresay) represent
majority, while
still leaving room for exceptions(MUX output implement it's
get/set_rate, enable/disable
to override them).
I feel relieved :)

Regards.
