From: mturquette@ti.com (Turquette, Mike)
Date: Sat, 26 Nov 2011 22:03:47 -0800
Subject: [PATCH v3 4/5] clk: basic gateable and fixed-rate clks
In-Reply-To: <20111126134807.GD19025@S2100-06.ap.freescale.net>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-5-git-send-email-mturquette@linaro.org>
 <20111126134807.GD19025@S2100-06.ap.freescale.net>
Message-ID: <CAJOA=zOMKKRKZ2P8XKAVLPWbhttizWubRiTjtCBz=myjivnRaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 26, 2011 at 5:48 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Mon, Nov 21, 2011 at 05:40:46PM -0800, Mike Turquette wrote:
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
> What I have seen is drivers/clk/clk-basic.c.

Will fix in v4.

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
>> +
>> + ? ? clk_init(NULL, clk);
>> +
>> + ? ? return 0;
>
> The device tree support needs to get this 'struct clk *', so we may
> want to have all these registering functions return the 'clk'.

Thanks for the input.  Truthfully I'm very DT-ignorant so I'm happy to
reshape any APIs for that topic.  Hope to fix that soon.

Thanks for reviewing,
Mike
