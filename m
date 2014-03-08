From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 08 Mar 2014 13:53:31 +0900
Subject: [PATCH v4 5/5] clk/exynos5260: add clock file for exynos5260
In-Reply-To: <CAPdUM4O30494Q27OuEfEFu6KYYpGX7RAjwvnkwS5b0dq3kkTTg@mail.gmail.com>
References: <1394113551-2134-1-git-send-email-rahul.sharma@samsung.com>
 <CAGcde9Hqs92bri0Fu3y7rvMhiFMYe+N7YWT-mxL2HTsnJTvz2w@mail.gmail.com>
 <CAPdUM4O30494Q27OuEfEFu6KYYpGX7RAjwvnkwS5b0dq3kkTTg@mail.gmail.com>
Message-ID: <531AA24B.6090305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2014 03:41 AM, Rahul Sharma wrote:
> HI Pankaj,
>
> On 7 March 2014 19:26, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
>> Hi Rahul,
>>
>> On Thu, Mar 6, 2014 at 10:45 PM, Rahul Sharma <rahul.sharma@samsung.com> wrote:
>>> Add support for exynos5260 clocks in clock driver.
>>>
>>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Even though my signed-off-by is present in this patch I can't see my
>> email-id in cc list. Please check why?
> Yea this is strange. I always use git send. let me check it. I will also add
> you manually for next version.
>
>> [snip]
>>
>>> +#include "clk-exynos5260.h"
>>> +#include "clk.h"
>>> +#include "clk-pll.h"
>>> +
>>> +#include <dt-bindings/clk/exynos5260-clk.h>
>> Better to move "exynos5260-clk.h" from "dt-bindings/clk" to "dt-bindings/clock"
>> as patch for moving all such headers already landed and looks good also.
>>
> yea correct. I changed this.
>
>> [snip]
>>
>>> +/*
>>> + * Applicable for all 2550 Type PLLS for Exynos5260, listed below
>>> + * DISP_PLL, EGL_PLL, KFC_PLL, MEM_PLL,
>>> + * BUS_PLL, MEDIA_PLL, G3D_PLL.
>>> + */
>>> +static const struct samsung_pll_rate_table pll2550_24mhz_tbl[] = {
>> shouldn't we mark rate_table with __initconst?
>>
> added.

Not only this, but for all const struct samsung_pll_rate_table in this file.

>
>> [snip]
>>
>>> + * Applicable for 2650 Type PLL for AUD_PLL.
>>> + */
>>> +static const struct samsung_pll_rate_table pll2650_24mhz_tbl[] = {
>> Ditto.
>>
>> [snip]
>>
>>> +#else
>>> +static void exynos5260_clk_sleep_init(void) {}
>> This will fail to compile if CONFIG_PM_SLEEP is not defined. Keep function
>> signature same.
>>
> Done.
>
>>> +#endif
>>> +
>>> +static struct samsung_clk_provider *
>>> +__init exynos5260_cmu_register_one(struct device_node *np,
>>> +                       struct exynos5260_cmu_info *cmu)
>>> +{
>>> +       void __iomem *reg_base;
>>> +       struct samsung_clk_provider *ctx;
>>> +
>>> +       reg_base = of_iomap(np, 0);
>>> +       if (!reg_base)
>>> +               panic("%s: failed to map registers\n", __func__);
>>> +
>>> +       ctx = samsung_clk_init(np, reg_base, cmu->nr_clk_ids);
>>> +       if (!ctx)
>>> +               panic("%s: unable to alllocate ctx\n", __func__);
>>> +
>>> +       if (cmu->pll_clks)
>>> +               samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_clks,
>>> +                       reg_base);
>>> +       if (cmu->mux_clks)
>>> +               samsung_clk_register_mux(ctx,  cmu->mux_clks,
>>> +                       cmu->nr_mux_clks);
>>> +       if (cmu->div_clks)
>>> +               samsung_clk_register_div(ctx, cmu->div_clks, cmu->nr_div_clks);
>>> +       if (cmu->gate_clks)
>>> +               samsung_clk_register_gate(ctx, cmu->gate_clks,
>>> +                       cmu->nr_gate_clks);
>>> +       if (cmu->clk_regs)
>>> +               exynos5260_clk_sleep_init(reg_base, cmu->clk_regs,
>>> +                       cmu->nr_clk_regs);
>>> +
>>> +       return ctx;
>> As far as I can see only one user of this return "ctx" is only
>> "exynos5260_clk_top_init", other init functions just ignoring this
>> return value.
>> This can be avoided if we register "fin_pll" (as well as all phyclocks
>> as they are also fixed rate clocks) clock via DT.
>> As I have already done it for another ExynosXXX SoC and it worked for
>> me, on the same hand when today I tried this on Exynos5260, I can see
>> it's working well and I can register "fin_pll" as "fixed_clock" via DT
>> and kernel booted without any issues. Late registration of parent
>> clock does not causing any issues and CCF takes care of that.
> Hmmn... thats why we are able to chain multiple CMUs :). But I consistently
> see "divide by zero" asserts during mct init. I will send you the logs
> offline. If
> I just ensure that "fin_pll" registers before other CMUs, no problem. I am
> surprised why you are not getting this issue.
>
>> If required I can send the changes internally or if you are OK I can
> If fix is in same file/dt please highlight those here else; better you post a
> independent fix. Even UART behaves weird in my setup with IGNORE flag
> removed.
OK. Apart from removing fixed clock registration related code from 
clk-exynos5260.c and
clk-exynos5260.h (remove FIN_PLL macros renumber other CMU_TOP clock ids),
following changes are required in exynos5260 DT file,
so that fixed clocks can be registered via DT and used.

Changes in exynos5260-xyref5260-evt0.dts

     clocks {
          compatible = "simple-bus";
          #address-cells = <1>;
          #size-cells = <0>;

-        fin_pll: oscillator at 0 {
-            compatible = "samsung,exynos5260-oscclk";
+        fin_pll: clock-fin-pll {
+            compatible = "fixed-clock";
+            reg = <0>;
+            #clock-cells = <0>;
              clock-frequency = <24000000>;
+            clock-output-names = "fin_pll";
+        };
+

Changes in exynos5260.dtsi

mct: mct at 100B0000 {
              compatible = "samsung,exynos4210-mct";
              reg = <0x100B0000 0x1000>;
-            clocks = <&clock_top FIN_PLL>, <&clock_peri PERI_CLK_MCT>;
+            clocks = <&fin_pll>, <&clock_peri PERI_CLK_MCT>;
              clock-names = "fin_pll", "mct";

With above changes it's working well for me.

Thanks,
Pankaj Dubey
>
> Rest of the changes are pretty trivial. I should be able to handle this.
>
>> also upload next version of this patch with this fix, along with
>> addressing all other comments .
>>
>> [snip]
>>
>>> +struct samsung_fixed_rate_clock fixed_rate_ext_clks[] __initdata = {
>>> +       FRATE(FIN_PLL, "fin_pll", NULL, CLK_IS_ROOT, 0),
>>> +};
>> In this version you removed other fixed clocks (phyclks and ioclks)
>> but I can not see corresponding DT patches where it has been moved.
>> Or am I missing anything here?
> I will update DT patch set. Those are already dependent on dt based probe
> for sysram. I will be updating the next week, probably.
>
>> [snip]
>>
>>> +static void __init exynos5260_clk_top_init(struct device_node *np)
>>> +{
>>> +       struct exynos5260_cmu_info cmu;
>>> +       struct samsung_clk_provider *ctx;
>>> +
>>> +       memset(&cmu, 0, sizeof(cmu));
>>> +
>>> +       cmu.pll_clks = top_pll_clks;
>>> +       cmu.nr_pll_clks =  ARRAY_SIZE(top_pll_clks);
>>> +       cmu.mux_clks = top_mux_clks;
>>> +       cmu.nr_mux_clks = ARRAY_SIZE(top_mux_clks);
>>> +       cmu.div_clks = top_div_clks;
>>> +       cmu.nr_div_clks = ARRAY_SIZE(top_div_clks);
>>> +       cmu.gate_clks = top_gate_clks;
>>> +       cmu.nr_gate_clks = ARRAY_SIZE(top_gate_clks);
>>> +       cmu.nr_clk_ids = TOP_NR_CLK;
>>> +       cmu.clk_regs = top_clk_regs;
>>> +       cmu.nr_clk_regs = ARRAY_SIZE(top_clk_regs);
>>> +
>>> +       ctx = exynos5260_cmu_register_one(np, &cmu);
>>> +
>>> +       samsung_clk_of_register_fixed_ext(ctx, fixed_rate_ext_clks,
>>> +                       ARRAY_SIZE(fixed_rate_ext_clks),
>>> +                       ext_clk_match);
>>> +}
>>> +
>>> +CLK_OF_DECLARE(exynos5260_clk_top, "samsung,exynos5260-clock-top",
>>> +               exynos5260_clk_top_init);
>> Well with this approach we end up adding 14 such
>> exynosxxx_clk_xxx_init functions all of which has similar lines of
>> code. As I know there are many upcoming Exynos SoC which will also
>> have similar multiple clock controllers (in some of them there are
>> upto 25 clock domains, and in that case we will end up writing 25 such
>> init functions) so I have following suggestion where we can have one
>> more structure which will hold all static data and match_table to
>> match compatibility string and return CMU_TYPE which can be mapped to
>> get proper clock_data which can be used in single clock_init function.
>> Following is some sample code which I have implemented and tested on
>> one of Exynos SoC. Please let me know your opinion about this.
>>
>> =============================
>>
>> static struct exynosxxxx_clock_data exynosxxxx_clk_data[] __initdata = {
>>          {
>>                  .cmu_type = CMU_TYPE_TOP,
>>                  .mux_clocks = top_mux_clks,
>>                  .div_clocks = top_div_clks,
>>                  .pll_clocks = top_pll_clks,
>>                  .clk_regs = top_clk_regs,
>>                  .nr_mux_clocks = ARRAY_SIZE(top_mux_clks),
>>                  .nr_div_clocks = ARRAY_SIZE(top_div_clks),
>>                  .nr_pll_clocks = ARRAY_SIZE(top_pll_clks),
>>                  .nr_clk_regs = ARRAY_SIZE(top_clk_regs),
>>                  .nr_clks  = TOP_NR_CLK,
>>          }, {
>>                  .cmu_type = CMU_TYPE_EGL,
>>                  .mux_clocks = egl_mux_clks,
>>                  .div_clocks = egl_div_clks,
>>                  .pll_clocks = egl_pll_clks,
>>                   .clk_regs = egl_clk_regs,
>>                  .nr_mux_clocks = ARRAY_SIZE(egl_mux_clks),
>>                  .nr_div_clocks = ARRAY_SIZE(egl_div_clks),
>>                  .nr_pll_clocks = ARRAY_SIZE(egl_pll_clks),
>>                  .nr_clk_regs = ARRAY_SIZE(egl_clk_regs),
>>                  .nr_clks  = EGL_NR_CLK,
>>          }, {
>>         /* Add similar elements here */
>> };
>>
>> static struct of_device_id cmu_subtype_match_table[] = {
>>          {
>>                  .compatible = "exynosxxxx-cmu-top",
>>                  .data   = (void *)CMU_TYPE_TOP,
>>          }, {
>>                  .compatible = "exynosxxx-cmu-peris",
>>                  .data   = (void *)CMU_TYPE_PERIS,
>>          }, {
>>         /* Add similar elements here */
>> };
>>
>> void __init exynosxxx_clk_init(struct device_node *np)
>> {
>>           [snip]
>>
>>          match = of_match_node(cmu_subtype_match_table, np);
>>
>>          if (!match)
>>                  panic("%s: cmu type (%s) is not supported.\n", __func__,
>>                                  np->name);
>>
>>          reg_base = of_iomap(np, 0);
>>          if (!reg_base)
>>                  panic("%s: failed to map registers\n", __func__);
>>
>>          cmu_type = (unsigned long) match->data;
>>
>>          for (; i < CMU_TYPE_ALL; i++) {
>>                  clk_data = &exynosxxxx_clk_data[i];
>>                  if (cmu_type == clk_data->cmu_type)
>>                          break;
>>          }
>>
>>          ctx = samsung_clk_init(np, reg_base, clk_data->nr_clks);
>>          if (!ctx)
>>                  panic("%s: unable to alllocate ctx\n", __func__);
>>
>>          if (clk_data->nr_pll_clocks)
>>            samsung_clk_register_pll(ctx, clk_data->pll_clocks,
>>                                  clk_data->nr_pll_clocks,
>>                                  reg_base);
>>          if (clk_data->nr_mux_clocks)
>>                  samsung_clk_register_mux(ctx, clk_data->mux_clocks,
>>                                  clk_data->nr_mux_clocks);
>>          if (clk_data->nr_div_clocks)
>>                  samsung_clk_register_div(ctx, clk_data->div_clocks,
>>                                  clk_data->nr_div_clocks);
>>          if (clk_data->nr_gate_clocks)
>>                  samsung_clk_register_gate(ctx, clk_data->gate_clocks,
>>                                  clk_data->nr_gate_clocks);
>>            if (cmu->nr_clk_regs)
>>               exynosxxx_clk_sleep_init(reg_base, cmu->clk_regs,
>>                         cmu->nr_clk_regs);
>>           [snip]
>>
>>   }
>> CLK_OF_DECLARE(cmu_top, "exynosxxxx-cmu-top", exynosxxxx_clk_init);
>> CLK_OF_DECLARE(cmu_egl, "exynosxxxx-cmu-egl", exynosxxxx_clk_init);
>> /* add more clock domain entries here */
>>
>> =======================================================
>>
>>> diff --git a/drivers/clk/samsung/clk-exynos5260.h b/drivers/clk/samsung/clk-exynos5260.h
>>> new file mode 100644
>>> index 0000000..7c3717a
>>> --- /dev/null
>>> +++ b/drivers/clk/samsung/clk-exynos5260.h
>>> @@ -0,0 +1,448 @@
>>> +#ifndef __CLK_EXYNOS5260_H
>>> +#define __CLK_EXYNOS5260_H
>>> +
> let me reply this along with Tomasz's comment in next message.
>
> Regards,
> Rahul Sharma
>
>> Thanks,
>> Pankaj Dubey


-- 
Best Regards,
Pankaj Dubey
