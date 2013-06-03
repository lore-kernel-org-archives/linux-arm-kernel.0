From: jp.francois@cynove.com (jean-philippe francois)
Date: Mon, 3 Jun 2013 09:50:53 +0200
Subject: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in clock36xx.c
In-Reply-To: <20130531193211.21525.68958@quantum>
References: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
 <20130531193211.21525.68958@quantum>
Message-ID: <CAGGh5h2uV-cpaf1un-bf6H8BBw=XLZWNNhihXxhVLGpGva8OdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/31 Mike Turquette <mturquette@linaro.org>:
> Quoting Jean-Philippe Francois (2013-05-30 01:50:27)
>> omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of the clock
>> to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all concerned clock
>> have parent defined as clk_divider. Instead of using container_of to eventually get
>> to the register and directly mess with the divider, change freq via clk_set_rate,
>> and let the clock framework toggle the divider value.
>> Tested with  3.9 on dm3730.
>>
>> Signed-off-by: Jean-Philippe Fran??ois <jp.francois@cynove.com>
>
> Did you use git-format-patch to create this patch?  Its a bit nicer to
> use that or if you just use diff then use "diff -up" or "diff -uprN"
> (taken from Documentation/SubmittingPatches.txt).
>
It is easier for my build system to work with tarball + quilt patches, so
I am not working with git. I will look into the alternative you provided.

> Also did you test this to make sure it works?  I don't mean a boot test,
> but actually disabling/re-enabling an HSDIVIDER on 3630?  The previous
> code just programmed the clksel field to 1, and this code divides the
> rate by 2, then restores it.  I just used that as an example in my
> previous email and it needs to be verified that it works (though it
> should if I remember this errata correctly).
>

Yes, it is exactly what happens on my board when using the camera, because
the sensor clock is provided by the SoC. So this patch works for this
particular clock.
If the asked frequency is the lower limit of the frequency range, then
asking for half the
frequency won't change the divider, but I think it is not a problem in practice.

> If that testing is done and everything looks good then please add:
>
> Acked-by: Mike Turquette <mturquette@linaro.org>
>
How should I proceed ? Should I just add the acked by below, or should
I resend the patch ?

Jean-Philippe Fran?ois

>>
>> Index: b/arch/arm/mach-omap2/clock36xx.c
>> ===================================================================
>> --- a/arch/arm/mach-omap2/clock36xx.c
>> +++ b/arch/arm/mach-omap2/clock36xx.c
>> @@ -39,30 +39,25 @@
>>   */
>>  int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
>>  {
>> -       struct clk_hw_omap *parent;
>> -       struct clk_hw *parent_hw;
>> -       u32 dummy_v, orig_v, clksel_shift;
>>         int ret;
>>
>>         /* Clear PWRDN bit of HSDIVIDER */
>>         ret = omap2_dflt_clk_enable(clk);
>>
>> -       parent_hw = __clk_get_hw(__clk_get_parent(clk->clk));
>> -       parent = to_clk_hw_omap(parent_hw);
>> -
>> -       /* Restore the dividers */
>> +       /* kick parent's clksel register after toggling PWRDN bit */
>>         if (!ret) {
>> -               clksel_shift = __ffs(parent->clksel_mask);
>> -               orig_v = __raw_readl(parent->clksel_reg);
>> -               dummy_v = orig_v;
>> -
>> -               /* Write any other value different from the Read value */
>> -               dummy_v ^= (1 << clksel_shift);
>> -               __raw_writel(dummy_v, parent->clksel_reg);
>> -
>> -               /* Write the original divider */
>> -               __raw_writel(orig_v, parent->clksel_reg);
>> +               struct clk *parent = clk_get_parent(clk->clk);
>> +               unsigned long parent_rate = clk_get_rate(parent);
>> +               ret = clk_set_rate(parent, parent_rate/2);
>> +               if(ret)
>> +                       goto badfreq;
>> +               ret = clk_set_rate(parent, parent_rate);
>> +               if(ret)
>> +                       goto badfreq;
>>         }
>> +       return ret;
>>
>> + badfreq :
>> +       omap2_dflt_clk_disable(clk);
>>         return ret;
>>  }
