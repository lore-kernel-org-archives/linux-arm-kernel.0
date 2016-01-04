From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 4 Jan 2016 15:27:57 +0200
Subject: [RFC 6/9] clk: ti: add support for omap4 module clocks
In-Reply-To: <CAMuHMdUZMUSYC1XHydVQHRibWtHw2=T-7nXe=5Pf4UCcb=mKTQ@mail.gmail.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
 <1450447141-29936-7-git-send-email-t-kristo@ti.com>
 <20160101054815.21738.79820@quark.deferred.io> <568A20E5.6040005@ti.com>
 <CAMuHMdUZMUSYC1XHydVQHRibWtHw2=T-7nXe=5Pf4UCcb=mKTQ@mail.gmail.com>
Message-ID: <568A735D.2060309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2016 12:21 PM, Geert Uytterhoeven wrote:
> Hi Tero,
>
> On Mon, Jan 4, 2016 at 8:36 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> On 01/01/2016 07:48 AM, Michael Turquette wrote:
>>> Quoting Tero Kristo (2015-12-18 05:58:58)
>>>> +static int _omap4_hwmod_clk_enable(struct clk_hw *hw)
>>>> +{
>>>> +       struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>>>> +       u32 val;
>>>> +       int timeout = 0;
>>>> +       int ret;
>>>> +
>>>> +       if (!clk->enable_bit)
>>>> +               return 0;
>>>> +
>>>> +       if (clk->clkdm) {
>>>> +               ret = ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm,
>>>> hw->clk);
>>>> +               if (ret) {
>>>> +                       WARN(1,
>>>> +                            "%s: could not enable %s's clockdomain %s:
>>>> %d\n",
>>>> +                            __func__, clk_hw_get_name(hw),
>>>> +                            clk->clkdm_name, ret);
>>>> +                       return ret;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       val = ti_clk_ll_ops->clk_readl(clk->enable_reg);
>>>> +
>>>> +       val &= ~OMAP4_MODULEMODE_MASK;
>>>> +       val |= clk->enable_bit;
>>>> +
>>>> +       ti_clk_ll_ops->clk_writel(val, clk->enable_reg);
>>>> +
>>>> +       /* Wait until module is enabled */
>>>> +       while (!_omap4_is_ready(val)) {
>>>> +               udelay(1);
>>>
>>> This should really be a .prepare callback if you plan to keep the delays
>>> in there.
>>
>> If this is changed to a .prepare, then all OMAP power management is
>> effectively ruined as all clocks are going to be enabled all the time. hwmod
>> core doesn't support .prepare/.enable at the moment that well, and changing
>> that is going to be a big burden (educated guess, haven't checked this
>> yet)... The call chain that comes here is:
>>
>> device driver -> pm_runtime -> hwmod_core -> hwmod_clk_enable / disable.
>>
>> The delay within this function should usually be pretty short, just to wait
>> that the module comes up from idle.
>
> Does it take multiple ?s? Perhaps even one ?s is much longer than needed?
>
>> I recall the discussions regarding the udelays within clk_enable/disable
>> calls, but what is the preferred approach then? Typically clk_enable/disable
>> just becomes a NOP if it is not allowed to wait for hardware to complete
>> transitioning before exiting the function.
>
> FWIW, there are small loops with just a cpu_relax() in various clock drivers
> under drivers/clk/shmobile/.

Just did a quick profiling round, and the clk_enable/disable delay loops 
take anything from 0...1500ns, most typically consuming some 400-600ns. 
So, based on this, dropping the udelay and adding cpu_relax instead 
looks like a good change. I just verified that changing the udelay to 
cpu_relax works fine also, I just need to change the bail-out period to 
be something sane.

-Tero



>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
