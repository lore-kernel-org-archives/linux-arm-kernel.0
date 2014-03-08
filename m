From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 08 Mar 2014 18:24:29 +0900
Subject: [PATCH v4 5/5] clk/exynos5260: add clock file for exynos5260
In-Reply-To: <CAPdUM4Pt0Ofh=M5pwdj+0NwSvfK4JvZbpWUS6JfD3vnTi2JaGg@mail.gmail.com>
References: <1394113551-2134-1-git-send-email-rahul.sharma@samsung.com>
 <CAGcde9Hqs92bri0Fu3y7rvMhiFMYe+N7YWT-mxL2HTsnJTvz2w@mail.gmail.com>
 <5319D3E5.4000001@gmail.com>
 <CAGcde9GetFjdRxqJfPY_1qdxzKb+4cqjsc+ALnN0PxSrApjyxg@mail.gmail.com>
 <5319E445.9000409@gmail.com>
 <CAPdUM4Pt0Ofh=M5pwdj+0NwSvfK4JvZbpWUS6JfD3vnTi2JaGg@mail.gmail.com>
Message-ID: <531AE1CD.2070203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On 03/08/2014 04:20 AM, Rahul Sharma wrote:
> Hi Tomasz,
>
> On 7 March 2014 20:52, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> On 07.03.2014 16:10, Pankaj Dubey wrote:
>>> Hi Tomasz,
>>>
>>>
>>> On Fri, Mar 7, 2014 at 11:12 PM, Tomasz Figa <tomasz.figa@gmail.com>
>>> wrote:
>>>> Hi Pankaj,
>>>>
>>>>
>>>> On 07.03.2014 14:56, Pankaj Dubey wrote:
>>>>>>
>>>>>> +static void __init exynos5260_clk_top_init(struct device_node *np)
>>>>>> +{
>>>>>> +       struct exynos5260_cmu_info cmu;
>>>>>> +       struct samsung_clk_provider *ctx;
>>>>>> +
>>>>>> +       memset(&cmu, 0, sizeof(cmu));
>>>>>> +
>>>>>> +       cmu.pll_clks = top_pll_clks;
>>>>>> +       cmu.nr_pll_clks =  ARRAY_SIZE(top_pll_clks);
>>>>>> +       cmu.mux_clks = top_mux_clks;
>>>>>> +       cmu.nr_mux_clks = ARRAY_SIZE(top_mux_clks);
>>>>>> +       cmu.div_clks = top_div_clks;
>>>>>> +       cmu.nr_div_clks = ARRAY_SIZE(top_div_clks);
>>>>>> +       cmu.gate_clks = top_gate_clks;
>>>>>> +       cmu.nr_gate_clks = ARRAY_SIZE(top_gate_clks);
>>>>>> +       cmu.nr_clk_ids = TOP_NR_CLK;
>>>>>> +       cmu.clk_regs = top_clk_regs;
>>>>>> +       cmu.nr_clk_regs = ARRAY_SIZE(top_clk_regs);
>>>>>> +
>>>>>> +       ctx = exynos5260_cmu_register_one(np, &cmu);
>>>>>> +
>>>>>> +       samsung_clk_of_register_fixed_ext(ctx, fixed_rate_ext_clks,
>>>>>> +                       ARRAY_SIZE(fixed_rate_ext_clks),
>>>>>> +                       ext_clk_match);
>>>>>> +}
>>>>>> +
>>>>>> +CLK_OF_DECLARE(exynos5260_clk_top, "samsung,exynos5260-clock-top",
>>>>>> +               exynos5260_clk_top_init);
>>>>>
>>>>>
>>>>> Well with this approach we end up adding 14 such
>>>>> exynosxxx_clk_xxx_init functions all of which has similar lines of
>>>>> code. As I know there are many upcoming Exynos SoC which will also
>>>>> have similar multiple clock controllers (in some of them there are
>>>>> upto 25 clock domains, and in that case we will end up writing 25 such
>>>>> init functions) so I have following suggestion where we can have one
>>>>> more structure which will hold all static data and match_table to
>>>>> match compatibility string and return CMU_TYPE which can be mapped to
>>>>> get proper clock_data which can be used in single clock_init function.
>>>>> Following is some sample code which I have implemented and tested on
>>>>> one of Exynos SoC. Please let me know your opinion about this.
>>>>
>>>>
>>>> Yes, this looks better indeed, however there is still a room for
>>>> improvement. Please see my comments below.
>>>>
>>>>
>>>>> =============================
>>>>>
>>>>> static struct exynosxxxx_clock_data exynosxxxx_clk_data[] __initdata = {
>>>>
>>>>
>>>> Instead of making this an array, particular elements could be separate
>>>> structures. This would simplify the code below.
>>>>
>>>>
>>>>>            {
>>>>>                    .cmu_type = CMU_TYPE_TOP,
>>>>>                    .mux_clocks = top_mux_clks,
>>>>>                    .div_clocks = top_div_clks,
>>>>>                    .pll_clocks = top_pll_clks,
>>>>>                    .clk_regs = top_clk_regs,
>>>>>                    .nr_mux_clocks = ARRAY_SIZE(top_mux_clks),
>>>>>                    .nr_div_clocks = ARRAY_SIZE(top_div_clks),
>>>>>                    .nr_pll_clocks = ARRAY_SIZE(top_pll_clks),
>>>>>                    .nr_clk_regs = ARRAY_SIZE(top_clk_regs),
>>>>>                    .nr_clks  = TOP_NR_CLK,
>>>>>            }, {
>>>>>                    .cmu_type = CMU_TYPE_EGL,
>>>>>                    .mux_clocks = egl_mux_clks,
>>>>>                    .div_clocks = egl_div_clks,
>>>>>                    .pll_clocks = egl_pll_clks,
>>>>>                     .clk_regs = egl_clk_regs,
>>>>>                    .nr_mux_clocks = ARRAY_SIZE(egl_mux_clks),
>>>>>                    .nr_div_clocks = ARRAY_SIZE(egl_div_clks),
>>>>>                    .nr_pll_clocks = ARRAY_SIZE(egl_pll_clks),
>>>>>                    .nr_clk_regs = ARRAY_SIZE(egl_clk_regs),
>>>>>                    .nr_clks  = EGL_NR_CLK,
>>>>>            }, {
>>>>>           /* Add similar elements here */
>>>>> };
>>>>>
>>>>> static struct of_device_id cmu_subtype_match_table[] = {
>>>>>            {
>>>>>                    .compatible = "exynosxxxx-cmu-top",
>>>>>                    .data   = (void *)CMU_TYPE_TOP,
>>>>
>>>>
>>>> Here the data would be just a pointer to respective clock data struct
>>>> defined above.
>>>>
>>>>
>>>>>            }, {
>>>>>                    .compatible = "exynosxxx-cmu-peris",
>>>>>                    .data   = (void *)CMU_TYPE_PERIS,
>>>>>            }, {
>>>>>           /* Add similar elements here */
>>>>> };
>>>>>
>>>>> void __init exynosxxx_clk_init(struct device_node *np)
>>>>> {
>>>>>             [snip]
>>>>>
>>>>>            match = of_match_node(cmu_subtype_match_table, np);
>>>>>
>>>>>            if (!match)
>>>>>                    panic("%s: cmu type (%s) is not supported.\n",
>>>>> __func__,
>>>>>                                    np->name);
>>>>
>>>>
>>>> This can't happen, because this function won't be called for any node
>>>> with
>>>> compatible string not declared using CLK_OF_DECLARE().
>>>
>>> Agreed.
>>>
>>>>
>>>>>            reg_base = of_iomap(np, 0);
>>>>>            if (!reg_base)
>>>>>                    panic("%s: failed to map registers\n", __func__);
>>>>>
>>>>>            cmu_type = (unsigned long) match->data;
>>>>>
>>>>>            for (; i < CMU_TYPE_ALL; i++) {
>>>>>                    clk_data = &exynosxxxx_clk_data[i];
>>>>>                    if (cmu_type == clk_data->cmu_type)
>>>>>                            break;
>>>>>            }
>>>>
>>>>
>>>> Now clk_data could be taken directly from match->data, without the need
>>>> to
>>>> iterate over an array.
> I am just curious, is it really a worth to replace 14 init functions
> with 14 same
> sized isolated structures. We will also be adding a array of these structure
> pointers and little overhead to parse this array based on compatible
> string for each cmu probe.
>
> IMHO, calling correct function meant for the given CMU, looks more
> straight and crisp. Most of the duplication is already addressed in
> exynos5260_cmu_register_one.
>
> Please, let me know if we are still looking for this change. It should
> be easy to
> change it that way.
>
>>> Good point. Let me change as per your suggestion and test. And then we
>>> will go for this change in next new version of patch.
>>
>> OK, thanks.
>>
>>
>>> Also please
>>> review rest patch also and let us know if anything still can be
>>> improved.
>>
>> I had reviewed version 3 of this series and most of my comments have been
>> addressed. I'm waiting for remaining two to be addressed, but they are
>> covered by your comments for v4.
> I will address the fixes for fin_pll and sclk_uart in the next
> version. Thanks for the
> review.
One update from my end.
Today I verified that even though I removed CLK_IGNORE_UNUSED flag from 
sclk_uartX I can
see kernel is booting fine and no issues as you mentioned. FYI I am 
using 3.14_rc1 tag and
applied all patches on top of it. For reference I have mailed all 
related patches to you.

@Tomasz,

I modified code as per our discussion and addressed all comments 
including moving fixed clock to DT
and found it's working well, so we can now finalize which way to  go ahead.
Following is some data between V4 and probable next version, which might 
help in making decision.

drivers/clk/samsung/exynos5260-clock.c

Before Change
LoC: 1890
size drivers/clk/samsung/clk-exynos5260.o
    text       data        bss        dec        hex    filename
   14226      14956          0      29182       71fe 
drivers/clk/samsung/clk-exynos5260.o

After Change:
LoC: 1806
size drivers/clk/samsung/clk-exynos5260.o
    text       data        bss        dec        hex    filename
   15446      14544          0      29990       7526 
drivers/clk/samsung/clk-exynos5260.o


>
> Regards,
> Rahul Sharma.
>
>> A link to v3 thread for reference:
>> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/27249
>>
>> Best regards,
>> Tomasz


-- 
Best Regards,
Pankaj Dubey
