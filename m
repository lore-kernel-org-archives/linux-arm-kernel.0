From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 16 Dec 2011 16:57:52 -0800
Subject: [PATCH v4 5/6] clk: basic gateable and fixed-rate clks
In-Reply-To: <4EE830D5.5070305@gmail.com>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
 <1323834838-2206-6-git-send-email-mturquette@linaro.org>
 <4EE830D5.5070305@gmail.com>
Message-ID: <CAJOA=zMcRzZ8LAzFzf_=1L2ZCrFHHjx_PTsxkb6US4HpWp8BOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 9:15 PM, Ryan Mallon <rmallon@gmail.com> wrote:
> On 14/12/11 14:53, Mike Turquette wrote:
>
>> Many platforms support simple gateable clks and fixed-rate clks that
>> should not be re-implemented by every platform.
>>
>> This patch introduces a gateable clk with a common programming model of
>> gate control via a write of 1 bit to a register. ?Both set-to-enable and
>> clear-to-enable are supported.
>>
>> Also introduced is a fixed-rate clk which has no reprogrammable aspects.
>>
>> The purpose of both types of clks is documented in drivers/clk/basic.c.
>>
>> TODO: add support for a simple divider, simple mux and a dummy clk for
>> stubbing out platform support.
>>
>> Based on original patch by Jeremy Kerr and contribution by Jamie Iles.
>>
>> Signed-off-by: Mike Turquette <mturquette@linaro.org>
>> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
>> Cc: Jamie Iles <jamie@jamieiles.com>
>
> <snip>
>
>> +int clk_register_gate(struct device *dev, const char *name, unsigned long flags,
>> + ? ? ? ? ? ? struct clk *fixed_parent, void __iomem *reg, u8 bit_idx,
>> + ? ? ? ? ? ? int set_to_enable)
>> +{
>> + ? ? struct clk_hw_gate *gclk;
>> + ? ? struct clk *clk;
>> +
>> + ? ? gclk = kmalloc(sizeof(struct clk_hw_gate), GFP_KERNEL);
>> +
>> + ? ? if (!gclk) {
>> + ? ? ? ? ? ? pr_err("%s: could not allocate gated clk\n", __func__);
>> + ? ? ? ? ? ? return -ENOMEM;
>> + ? ? }
>> +
>> + ? ? clk = &gclk->clk;
>> +
>> + ? ? /* struct clk_hw_gate assignments */
>> + ? ? gclk->fixed_parent = fixed_parent;
>> + ? ? gclk->reg = reg;
>> + ? ? gclk->bit_idx = bit_idx;
>> +
>> + ? ? /* struct clk assignments */
>> + ? ? clk->name = name;
>> + ? ? clk->flags = flags;
>> +
>> + ? ? if (set_to_enable)
>> + ? ? ? ? ? ? clk->ops = &clk_hw_gate_set_enable_ops;
>> + ? ? else
>> + ? ? ? ? ? ? clk->ops = &clk_hw_gate_set_disable_ops;
>
>
> You could avoid having two sets of operations if you stored the
> set_to_enable value in struct clk_hw_gate. It might be useful to store
> additional information in struct clk_hw_gate if you also want to extend
> to supporting non-32bit registers (readb, etc), clocks with write only
> registers, or support clocks which require more than one bit to be set
> or cleared to enable them, etc. See the basic mmio gpio driver for a
> similar case.

I haven't given the basic clks enough attention, mostly because I
haven't started using them yet in my own platform's conversion to
common struct clk :-/

I think the original reason for the extra operations is to avoid the
conditional in the enable/disable path, but if we're going to end up
adding other conditionals anyways (such as the register locking in the
iMX platform implementation) then we should probably forget about that
approach and just deal with the complexity in one set of common
enable/disable functions.

Thanks for the review,
Mike

>
> ~Ryan
>
