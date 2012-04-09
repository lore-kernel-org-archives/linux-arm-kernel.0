From: robherring2@gmail.com (Rob Herring)
Date: Mon, 09 Apr 2012 09:18:27 -0500
Subject: [PATCH 4/7] dt/clock: Add handling for fixed clocks and a clock
 node setup iterator
In-Reply-To: <20120409084930.GA18692@S2101-09.ap.freescale.net>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-5-git-send-email-robherring2@gmail.com>
 <20120314075930.GF21337@S2101-09.ap.freescale.net>
 <4F81A53B.7020804@gmail.com>
 <20120409084930.GA18692@S2101-09.ap.freescale.net>
Message-ID: <4F82EFB3.80402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2012 03:49 AM, Shawn Guo wrote:
> On Sun, Apr 08, 2012 at 09:48:27AM -0500, Rob Herring wrote:
> ...
>> So I started implementing support for multiple outputs, but ran into a
>> complication. If you have multiple clocks on a node, then you have to
>> have a clk_src_get function to translate the clock cell value to a
>> struct clk.
> 
> So this is how clk_src_get looks like.
> 
> struct clk *clk_src_get(struct of_phandle_args *a, void *data)
> {
>         struct clk **clks = data;
>         return clks[a->args[0]];
> }
> 
>> This would also require allocating an array of struct clk's
>> to do the lookup.
> 
> And this how allocating looks like.
> 
>         clks = kzalloc(sizeof(*clks)  * num, GFP_KERNEL);
>         if (!clks)
>                 return -ENOMEM;
> 
> Seriously, not a big complication, right?

I didn't say it can't be done. I'm saying I don't see the benefit to
supporting it vs. the added code to iterate over the array, handle
errors in the middle, and added matching function.

You still haven't given any benefits of supporting multiple clocks. It's
slightly fewer dts lines, but not really anything else.

> 
>> This is all doable, but I don't see the benefit over
>> having a single node per fixed clock. We're not likely to have *lots* of
>> fixed clocks. I think we should leave fixed-clock defined as a single
>> output.
> 
> The problem is there is nothing specific to fixed-clock.  If you have
> some reason to not support blob node for fixed-clock, the reason will
> apply on clk_gate, clk_divider and clk_mux too.  Then, which clocks
> will support the #clock-cells in the binding document?
> 

But fixed-clock is a specific binding and each binding can define
#clock-cells however they want. New bindings can define whatever they want.

If you did a clk mux binding, you're not going to have multiple lists of
mux selections for multiple outputs, so we're going to effectively
limited there to 1 output as well.

I don't think people are going to define clocks generically in DT at the
mux, clk gate and divider level anyway. If you only have a few clocks
then you may, and 1 clock output per node is probably okay. If you have
hundreds of clocks then you probably won't, and will have a SOC specific
binding anyway.

Rob

> So to me, you need to either have it implemented or remove it from the
> binding document completely.
> 
> Regards,
> Shawn
> 
>> If you really see the benefit, you can add a new binding
>> "multiple-fixed-clocks" or something platform specific.
>>
