From: wangbintian@gmail.com (Brent Wang)
Date: Sat, 16 May 2015 10:54:58 +0800
Subject: [PATCH v4 4/5] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <20150515193041.GO31753@codeaurora.org>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <1430827599-11560-5-git-send-email-bintian.wang@huawei.com>
 <20150515002527.GD31753@codeaurora.org>
 <5555A37B.1090105@huawei.com>
 <20150515193041.GO31753@codeaurora.org>
Message-ID: <CAAS=xmjsFoQg-HgWA5-e=cF3qF+PcVNc3i_3Z5EBPNJ2HyOZKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello  Stephen,

2015-05-16 3:30 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 05/15, Bintian wrote:
>> On 2015/5/15 8:25, Stephen Boyd wrote:
>> >On 05/05, Bintian Wang wrote:
>> >>diff --git a/drivers/clk/hisilicon/clkdivider-hi6220.c b/drivers/clk/hisilicon/clkdivider-hi6220.c
>> >>+
>> >>+/**
>> >>+ * struct hi6220_clk_divider - divider clock for hi6220
>> >>+ *
>> >>+ * @hw:            handle between common and hardware-specific interfaces
>> >>+ * @reg:   register containing divider
>> >>+ * @shift: shift to the divider bit field
>> >>+ * @width: width of the divider bit field
>> >>+ * @mask:  mask for setting divider rate
>> >>+ * @table: the div table that the divider supports
>> >>+ * @lock:  register lock
>> >>+ */
>> >>+struct hi6220_clk_divider {
>> >>+   struct clk_hw   hw;
>> >>+   void __iomem    *reg;
>> >>+   u8              shift;
>> >>+   u8              width;
>> >>+   u32             mask;
>> >>+   const struct clk_div_table *table;
>> >>+   spinlock_t      *lock;
>> >>+};
>> >
>> >The clk-divider.c code has been made "reusable". Can you please
>> >try to use the functions that it now exposes instead of
>> >copy/pasting it and modifying it to suit your needs? A lot of
>> >this code looks the same.
>> In fact, I discussed this problem with Rob Herring and Mike Turquette
>> in the 96boards internal mail list before.
>>
>> The divider in hi6220 has a mask bit to guarantee writing the correct
>> bits in register when setting rate, but the index of this mask bit has
>> no rules to get (e.g. by left shift some fixed bits), so I add this
>> divider clock to handle it, we can regard hi6220_clk_divider as a
>> special case of generic divider clock.
>>
>> If I don't add this divider clock for hi6220 chip, then I should change
>> the core APIs "clk_register_divider" and "clk_register_divider_table",
>> and then many other drivers will be updated.
>> So I think just add this divider clock is a good solution now.
>
> I think you missed my point. I didn't suggest using
> clk_register_divider or clk_register_divider_table(). I'm
> suggesting to use
>
> unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
>                 unsigned int val, const struct clk_div_table *table,
>                 unsigned long flags);
> long divider_round_rate(struct clk_hw *hw, unsigned long rate,
>                 unsigned long *prate, const struct clk_div_table *table,
>                 u8 width, unsigned long flags);
> int divider_get_val(unsigned long rate, unsigned long parent_rate,
>                 const struct clk_div_table *table, u8 width,
>                 unsigned long flags);
Got it and I will prepare next version soon.

>
>> >>+           return ERR_PTR(-ENOMEM);
>> >>+   }
>> >>+
>> >>+   for (i = 0; i < max_div; i++) {
>> >>+           table[i].div = min_div + i;
>> >>+           table[i].val = table[i].div - 1;
>> >>+   }
>> >>+
>> >>+   init.name = name;
>> >>+   init.ops = &hi6220_clkdiv_ops;
>> >>+   init.flags = flags | CLK_IS_BASIC;
>> >
>> >It's basic?
>> I rechecked this flag, it's really useless to us, so I can remove it.
>> But can you tell me which case I should use it?
>
> I think the basic flag is there for drivers that want to know what type
> of clock they're dealing with when all they have is the struct clk_hw
> pointer. I like to discourage use of this flag in hopes of deleting
> it someday.
>
>>
>> How about just send this patch for review not the whole patch set in
>> next version?
>>
>
> Yes a single patch is fine. I take it you want the patch to go
> through arm-soc with some Ack from us?
Yes, exactly.
The dts file includes the clock head file,  this patch goes through
arm-soc is a good choice.

Thanks,

Bintian
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
