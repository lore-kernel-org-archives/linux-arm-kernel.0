From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 19 Dec 2011 13:24:08 +0800
Subject: [PATCH v3 2/4] ARM: pxa168: Add SDHCI support
In-Reply-To: <4EEEC8E1.1060903@einfochips.com>
References: <87r51fwxgt.fsf@laptop.org>
 <1321849572-2944-1-git-send-email-tanmay.upadhyay@einfochips.com>
 <874nxkmaky.fsf@laptop.org> <m2sjklfmuf.fsf@bob.laptop.org>
 <CAN1soZxmKct+qGUE2_W+FZufR+gcYZu6Dsj+TkJ06PaO8rV-TQ@mail.gmail.com>
 <4EEEC3BF.6010708@einfochips.com>
 <CAN1soZxnSsZ8SDp=ueu0iMaz59pq7p09DoYD27qCridrrAkmuw@mail.gmail.com>
 <4EEEC8E1.1060903@einfochips.com>
Message-ID: <CAN1soZxZjdzivfttUhDDvjUDiyiAC5SSKtB0rXR1D=3=q6O0wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 1:17 PM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
>
>
> On Monday 19 December 2011 10:32 AM, Haojian Zhuang wrote:
>>
>> On Mon, Dec 19, 2011 at 12:55 PM, Tanmay Upadhyay
>> <tanmay.upadhyay@einfochips.com> ?wrote:
>>>
>>>
>>> On Monday 19 December 2011 10:15 AM, Haojian Zhuang wrote:
>>>>
>>>> On Fri, Dec 16, 2011 at 7:15 AM, Chris Ball<cjb@laptop.org> ? ?wrote:
>>>>>
>>>>> Hi Eric and Jason,
>>>>>
>>>>> On Thu, Dec 01 2011, Chris Ball wrote:
>>>>>>
>>>>>> Hi Eric, Jason,
>>>>>>
>>>>>> Please could you ACK this patch if you agree with it, and I'll take it
>>>>>> and the rest of the series via the MMC tree? ?Thanks.
>>>>>
>>>>> Ping?
>>>>>
>>>>> Thanks,
>>>>>
>>>>> - Chris.
>>>>>
>>>> NACK.
>>>>
>>>>>>> +/* Offset defined in arch/arm/mach-mmp/include/mach/regs-apmu.h are
>>>>>>> for MMP2
>>>>>>> + * PXA168 has different offset */
>>>>>>> +#undef APMU_SDH2
>>>>>>> +#undef APMU_SDH3
>>>>>>> +
>>>>>>> +#define APMU_SDH2 ? APMU_REG(0xe0)
>>>>>>> +#define APMU_SDH3 ? APMU_REG(0xe4)
>>>>>>> +
>>>>
>>>> Please don't use #undef at here. If the register setting is different,
>>>> I prefer to use two different clk operations.
>>>>
>>> Sorry I couldn't get you. Could you please elaborate? Here regs-apmu.h
>>> defines clock register offsets. They are correct for MMP2, but not for
>>> PXA168. So I thought to correct them in a PXA168 specific file. Could you
>>> please point me a better way?
>>>
>>> Thanks,
>>>
>>> Tanmay
>>
>> APMU_PXA168_SDH2
>> APMU_MMP2_SDH2
>>
>> I think this is better.
>>
>
> Thanks for the suggestion. This looks a better option. However, I would like
> add here that not only the register offset, but also the register bits are
> different for MMP2 & PXA168. So, the code that would control SD/MMC clock
> will be architecture specific & hence in different architecture specific
> files. Hope this solution looks good to all of you in that case as well.
>
> Thanks,
>
> Tanmay

+static void sdh_clk_enable(struct clk *clk)
+{
+       void __iomem *clk_reg_offset = clk->clk_rst;
+
+       /* Can't see any clean way to do this: Bits 3 & 0 in registers
+        * for host 0 & 2 should be set for host 1 & 3 also */
+       if (clk_reg_offset == APMU_SDH0 || clk_reg_offset == APMU_SDH1)
+               __raw_writel(__raw_readl(APMU_SDH0) | 0x9, APMU_SDH0);
+       if (clk_reg_offset == APMU_SDH2 || clk_reg_offset == APMU_SDH3)
+               __raw_writel(__raw_readl(APMU_SDH2) | 0x9, APMU_SDH2);
+
+       __raw_writel(__raw_readl(clk->clk_rst) | clk->enable_val, clk->clk_rst);
+}
+
+struct clkops sdh_clk_ops = {
+       .enable         = sdh_clk_enable,
+       .disable        = sdh_clk_disable,
+};
+

+static APMU_CLK_OPS(sdh1, SDH0, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh2, SDH1, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh3, SDH2, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh4, SDH3, 0x12, 48000000, &sdh_clk_ops);
+

You defined both sdh_clk_ops & APMU_CLK_OPS. So you can define
pxa168_sdh_clk_ops in pxa168.c, and mmp2_sdh_clk_ops in mmp2.c.
