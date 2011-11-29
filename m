From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 29 Nov 2011 11:22:23 -0800
Subject: [RFC V1 7/8] ARM i.MX: prepare common clk support
In-Reply-To: <20111129030944.GB19236@b20223-02.ap.freescale.net>
References: <1322046755-13511-1-git-send-email-richard.zhao@linaro.org>
 <1322046755-13511-8-git-send-email-richard.zhao@linaro.org>
 <CAPtuhTgSB8Af4Xtux93-VLXSrK5KkzFOez9V5tcmbkKwbZ_8Rw@mail.gmail.com>
 <20111129030944.GB19236@b20223-02.ap.freescale.net>
Message-ID: <CAPtuhThNZA707gQhjt9-V_B8=5UN9o1JgNTm_Dj8eLO-WNmJQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 7:09 PM, Richard Zhao <richard.zhao@linaro.org> wrote:
> On Mon, Nov 28, 2011 at 06:36:33PM -0800, Mike Turquette wrote:
>> On Wed, Nov 23, 2011 at 3:12 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
>> > +#define DEFINE_CLK_DIVIDER(_name, _parent, _flags, _reg, _shift, _width) \
>> > + ? ? ? struct clk_divider _name = { \
>> > + ? ? ? ? ? ? ? .clk = { \
>> > + ? ? ? ? ? ? ? ? ? ? ? .name = #_name, \
>> > + ? ? ? ? ? ? ? ? ? ? ? .ops = &clk_divider_ops, \
>> > + ? ? ? ? ? ? ? ? ? ? ? .parent = _parent, \
>> > + ? ? ? ? ? ? ? ? ? ? ? .flags = _flags, \
>> > + ? ? ? ? ? ? ? }, \
>> > + ? ? ? ? ? ? ? .reg = (_reg), \
>> > + ? ? ? ? ? ? ? .shift = (_shift), \
>> > + ? ? ? ? ? ? ? .width = (_width), \
>> > + ? ? ? ? ? ? ? .lock = &imx_ccm_lock, \
>> > + ? ? ? }
>> > +
>> > +#define DEFINE_CLK_MUX(_name, _reg, _shift, _width, _clks) \
>> > + ? ? ? struct clk_mux _name = { \
>> > + ? ? ? ? ? ? ? .clk = { \
>> > + ? ? ? ? ? ? ? ? ? ? ? .name = #_name, \
>> > + ? ? ? ? ? ? ? ? ? ? ? .ops = &clk_mux_ops, \
>> > + ? ? ? ? ? ? ? }, \
>> > + ? ? ? ? ? ? ? .reg = (_reg), \
>> > + ? ? ? ? ? ? ? .shift = (_shift), \
>> > + ? ? ? ? ? ? ? .width = (_width), \
>> > + ? ? ? ? ? ? ? .clks = (_clks), \
>> > + ? ? ? ? ? ? ? .num_clks = ARRAY_SIZE(_clks), \
>> > + ? ? ? ? ? ? ? .lock = &imx_ccm_lock, \
>> > + ? ? ? }
>> > +
>> > +#define DEFINE_CLK_FIXED(_name, _rate) \
>> > + ? ? ? struct clk_hw_fixed _name = { \
>> > + ? ? ? ? ? ? ? .clk = { \
>> > + ? ? ? ? ? ? ? ? ? ? ? .name = #_name, \
>> > + ? ? ? ? ? ? ? ? ? ? ? .ops = &clk_hw_fixed_ops, \
>> > + ? ? ? ? ? ? ? }, \
>> > + ? ? ? ? ? ? ? .fixed_rate = (_rate), \
>> > + ? ? ? }
>> > +
>> > ?#endif /* CONFIG_GENERIC_CLK */
>> > ?#endif /* __ASSEMBLY__ */
>> > ?#endif /* __ASM_ARCH_MXC_CLOCK_H__ */
>> > --
>> > 1.7.5.4
>> >
>> >
>> >
>>
>> Can you move these into clk.h/approriate header? ?Just add _lock to it
>> and it'll work fine for your code.
> Yes, I can add _lock and share the macros in common header. But I still

On second thought you don't need to resubmit with these in clk.h; I'll
absorb them into clk.h with my next common clk patchset.

> need a wraper for imx to eliminate _lock, right?

No.  Taking code from your patch 8/8:

+static DEFINE_CLK_DIVIDER(perclk_pred1, &perclk_lp_apm.clk, 0,
MXC_CCM_CBCDR, 6, 2);
+static DEFINE_CLK_DIVIDER(perclk_pred2, &perclk_pred1.clk, 0,
MXC_CCM_CBCDR, 3, 3);
+static DEFINE_CLK_DIVIDER(perclk_podf, &perclk_pred2.clk,
CLK_PARENT_SET_RATE, MXC_CCM_CBCDR, 0, 3);

becomes,

+static DEFINE_CLK_DIVIDER(perclk_pred1, &perclk_lp_apm.clk, 0,
MXC_CCM_CBCDR, 6, 2, &imx_ccm_lock);
+static DEFINE_CLK_DIVIDER(perclk_pred2, &perclk_pred1.clk, 0,
MXC_CCM_CBCDR, 3, 3, &imx_ccm_lock);
+static DEFINE_CLK_DIVIDER(perclk_podf, &perclk_pred2.clk,
CLK_PARENT_SET_RATE, MXC_CCM_CBCDR, 0, 3, &imx_ccm_lock);

Regards,
Mike

>
> Thanks for review
> Richard
>>
>> Thanks,
>> Mike
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
>
