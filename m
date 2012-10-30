From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Wed, 31 Oct 2012 00:10:24 +0100
Subject: [PATCH v2 1/5] clk: samsung: add common clock framework support
 for Samsung platforms
In-Reply-To: <CAJuYYwQuTcu_qRyLs8JXhUg=T36iuW_bKryxSVpBXm6iMbsH4w@mail.gmail.com>
References: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
 <1349629855-4962-2-git-send-email-thomas.abraham@linaro.org>
 <50856C6B.3090001@samsung.com>
 <CAJuYYwQuTcu_qRyLs8JXhUg=T36iuW_bKryxSVpBXm6iMbsH4w@mail.gmail.com>
Message-ID: <50905E60.6090005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 10/29/2012 11:09 AM, Thomas Abraham wrote:
> Hi Sylwester,
> 
> Thanks for your comments. As usual, your comments are very helpful.

Thanks.
> On 22 October 2012 21:25, Sylwester Nawrocki<s.nawrocki@samsung.com>  wrote:
>> Hi Thomas,
>>
>> On 10/07/2012 07:10 PM, Thomas Abraham wrote:
>>> All Samsung platforms include several types of clocks including fixed-rate,
>>> mux, divider and gate clock types. There are typically hundreds of such clocks
>>> on each of the Samsung platforms. To enable Samsung platforms to register these
>>> clocks using the common clock framework, a bunch of utility functions are
>>> introduced here which simplify the clock registration process.
>>>
>>> In addition to the basic types of clock supported by common clock framework,
>>> a Samsung specific representation of the PLL clocks is also introduced.
>>>
>>> Both legacy and device tree based Samsung platforms are supported. On legacy
>>> platforms, the clocks are statically instantiated and registered with common
>>> clock framework. On device tree enabled platforms, the device tree is
>>> searched and all clock nodes found are registered. It is also possible to
>>> register statically instantiated clocks on device tree enabled platforms.
>>>
>>> Cc: Mike Turquette<mturquette@ti.com>
>>> Cc: Kukjin Kim<kgene.kim@samsung.com>
>>> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
>>
>> Thanks for the patch. I'm trying to use this series on an Exynos4412
>> SoC based board. I think it wasn't tested with Exynos4x12 (with FDT
>> support), was it ?
> 
> No, it has not been tested on any Exynos4x12 based board. I have
> tested it only for Exynos4210 based origen board.

OK, thanks. I've had some issues with the root clocks on Exynos4412 
and I put this on a back burner for a while. I plan to get back to 
this, possibly after ELCE/LinuxCon.

>>> ---
>>>   drivers/clk/Makefile         |    1 +
>>>   drivers/clk/samsung/Makefile |    5 +
>>>   drivers/clk/samsung/clk.c    |  414 ++++++++++++++++++++++++++++++++++++++++++
>>>   drivers/clk/samsung/clk.h    |  212 +++++++++++++++++++++
>>>   4 files changed, 632 insertions(+), 0 deletions(-)
>>>   create mode 100644 drivers/clk/samsung/Makefile
>>>   create mode 100644 drivers/clk/samsung/clk.c
>>>   create mode 100644 drivers/clk/samsung/clk.h
...
>>> +/* register a samsung pll type clock */
>>> +void __init samsung_clk_register_pll(const char *name, const char **pnames,
>>> +                             struct device_node *np,
>>> +                             int (*set_rate)(unsigned long rate),
>>> +                             unsigned long (*get_rate)(unsigned long rate))
>>> +{
>>> +     struct samsung_pll_clock *clk_pll;
>>> +     struct clk *clk;
>>> +     struct clk_init_data init;
>>> +     int ret;
>>> +
>>> +     clk_pll = kzalloc(sizeof(*clk_pll), GFP_KERNEL);
>>> +     if (!clk_pll) {
>>> +             pr_err("%s: could not allocate pll clk %s\n", __func__, name);
>>> +             return;
>>> +     }
>>> +
>>> +     init.name = name;
>>> +     init.ops =&samsung_pll_clock_ops;
>>> +     init.flags = CLK_GET_RATE_NOCACHE;
>>> +     init.parent_names = pnames;
>>> +     init.num_parents = 1;
>>> +
>>> +     clk_pll->set_rate = set_rate;
>>> +     clk_pll->get_rate = get_rate;
>>> +     clk_pll->hw.init =&init;
>>> +
>>> +     /* register the clock */
>>> +     clk = clk_register(NULL,&clk_pll->hw);
>>> +     if (IS_ERR(clk)) {
>>> +             pr_err("%s: failed to register pll clock %s\n", __func__,
>>> +                             name);
>>> +             kfree(clk_pll);
>>> +             return;
>>> +     }
>>> +
>>> +#ifdef CONFIG_OF
>>> +     if (np)
>>> +             of_clk_add_provider(np, of_clk_src_simple_get, clk);
>>> +#endif
>>
>> Is it really required to do clk_register() and of_clk_add_provider() for
>> each single clock ? This seems more heavy than it could be. Looking at
> 
> of_clk_add_provider call for every clock instance is not really
> required but it does allow platform code to lookup the clock and
> retrieve/display the clock speed. That was the intention to add a
> lookup for all the clocks.

Hmm, do you mean calling clk_get() with NULL 'dev' argument ?
It's probably not a big deal to look up the clocks root node and
then use of_clk_get() function to find required clock ?

>> drivers/clk/mxs/clk-imx28.c, it registers only single clock provider for
>> whole group of clocks. Also, couldn't we statically define most of the
>> clocks and still register them so they can be used with platforms using
>> FDT ? Something along the lines of imx28 implementation (arch/arm/boot/dts
>> /imx28.dtsi), where a clock is specified at consumer device node by
>> a phandle to the clock controller node and a clock index ?
> 
> We could do it that way. I was tempted to list out all the clocks in
> device tree and then register them so that there is no static
> definition of the clocks needed. You seem to prefer not to do that. I
> am fine with either way, static or device tree based registration.

Ok, it's also worth noting that clk_get() would have been more expensive
when there would be a need to iterate over large number of clock providers.
Indexed look up might be a better alternative.

Exynos SoCs have fairly complex clock tree structure, I personally do find
it harder to understand from a bit bulky description in form of a device
tree node list. Comparing to the original Samsung clock API there is now 
more clock objects, since, e.g. single struct clk_clksrc is now represented 
by mux, div and gate clock group, which makes things slightly more 
complicated, i.e. there is even more clocks to be listed.

>> Besides that, what bothers me with in the current approach is the
>> clock consumers being defined through one big data structure together
>> with the actual clocks. Not all clock objects are going to have
>> consumers, some resources are waisted by using flat tables of those
>> big data structure objects. Perhaps we could use two tables, one for the
>> platform clocks and one for the consumers ? These common clock driver
>> is intended to cover all Samsung SoC, I would expect all samsung
>> sub-archs getting converted to use it eventually, with as many of them
>> as possible then reworked to support device tree. It's a lot of work
>> and is going to take some time, but it would be good to have it planned
>> in advance. That said I'm not sure the common samsung clock driver in
>> non-dt variant would be really a temporary thing.
> 
> Non-dt support in Samsung common clock driver will be maintained. But
> for existing Exynos4 non-dt platforms, it should be possible to
> convert them to completely device tree based platforms.

OK, let's then focus on device tree support for exynos4+ SoCs. I hope we 
could have the clocks statically defined and still freely accessible in 
the device tree.

>>> +     /*
>>> +      * Register a clock lookup for the pll-type clock even if this
>>> +      * has been instantiated from device tree. This helps to do
>>> +      * clk_get() lookup on this clock for pruposes of displaying its
>>> +      * clock speed at boot time.
>>> +      */
>>> +     ret = clk_register_clkdev(clk, name, NULL);
>>> +     if (ret)
>>> +             pr_err("%s: failed to register clock lookup for %s", __func__,
>>> +                             name);
>>> +}
...
>>> +
>>> +#ifdef CONFIG_OF
>>> +/* register a samsung gate type clock instantiated from device tree */
>>> +void __init samsung_of_clk_register_gate(struct device_node *np)
>>> +{
>>> +     struct samsung_gate_clock clk_gate;
>>> +     const char *clk_name = np->name;
>>> +     const char *parent_name;
>>> +     u32 reg_info[2];
>>> +
>>> +     of_property_read_string(np, "clock-output-names",&clk_name);
>>> +     parent_name = of_clk_get_parent_name(np, 0);
>>> +     if (of_property_read_u32_array(np, "reg-info", reg_info, 2))
>>> +             pr_err("%s: invalid register info in node\n", __func__);
>>> +
>>> +     clk_gate.name = clk_name;
>>> +     clk_gate.parent_name = parent_name;
>>> +     clk_gate.reg = (void __iomem *)(reg_base + reg_info[0]);
>>> +     clk_gate.bit_idx = reg_info[1];
>>> +     clk_gate.dev_name = NULL;
>>> +     clk_gate.flags = 0;
>>> +     clk_gate.gate_flags = 0;
>>
>> Some clocks need CLK_SET_RATE_PARENT for the drivers to work
>> as before. So far it is not set for any mux, div nor gate clock.
> 
> Ok. I will fix this.
> 
> So about the static vs device tree based clock registration, what
> would you suggest?

Defining the clocks statically has my preference, it would be nice to 
hear more opinions on that though. I think on a heavily utilised SoC 
the list of clock nodes could have grown significantly. And with 
preprocessor support at the dt compiler (not sure if it is already 
there) indexed clock definitions could be made more explicit.

These are roughly our conclusions from discussing this patch series
with Tomasz F.

--
Thanks,
Sylwester
