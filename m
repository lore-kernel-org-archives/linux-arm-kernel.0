From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 30 Jun 2017 12:22:28 -0700
Subject: [PATCH V1 7/9] clk: sprd: add adjustable pll support
In-Reply-To: <CAAfSe-smKqgd42jDAGDA=NtYvRZExNanU7fHrRkT4W-WH-2=ug@mail.gmail.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
 <20170618015855.27738-8-chunyan.zhang@spreadtrum.com>
 <20170620013710.GJ4493@codeaurora.org>
 <CAAfSe-sMy3aM9=LwpVivvHKy4hVw3GEd3U-hZe17pXM5fJRxPg@mail.gmail.com>
 <20170630014452.GL22780@codeaurora.org>
 <CAAfSe-smKqgd42jDAGDA=NtYvRZExNanU7fHrRkT4W-WH-2=ug@mail.gmail.com>
Message-ID: <20170630192228.GO22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30, Chunyan Zhang wrote:
> Hi Stephen,
> 
> On 30 June 2017 at 09:44, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 06/22, Chunyan Zhang wrote:
> >> On 20 June 2017 at 09:37, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >> > On 06/18, Chunyan Zhang wrote:
> >> >> +     pll->factors[member].width
> >> >> +
> >> >> +#define pmask(pll, member)                                   \
> >> >> +     ((pwidth(pll, member)) ?                                \
> >> >> +     GENMASK(pwidth(pll, member) + pshift(pll, member) - 1,  \
> >> >> +     pshift(pll, member)) : 0)
> >> >> +
> >> >> +#define pinternal(pll, cfg, member)  \
> >> >> +     (cfg[pindex(pll, member)] & pmask(pll, member))
> >> >> +
> >> >> +#define pinternal_val(pll, cfg, member)      \
> >> >> +     (pinternal(pll, cfg, member) >> pshift(pll, member))
> >> >> +
> >> >> +static unsigned long pll_get_refin_rate(struct ccu_pll *pll)
> >> >
> >> > pll could be const?
> >>
> >> What this function returns is a factor used to calculate the pll rate
> >> later, I will rename this function in the next iterator.
> >>
> >
> > Rename is fine, but pll can still be marked const?
> 
> Oh, sorry I misunderstood :)
> You mean mark the input parameter "pll" const, right?

Yes.

> >> >> +
> >> >> +static int ccu_pll_helper_set_rate(struct ccu_pll *pll,
> >> >> +                                unsigned long rate,
> >> >> +                                unsigned long parent_rate)
> >> >> +{
> >> >> +     u32 mask, shift, width, ibias_val, index, kint, nint;
> >> >> +     u32 reg_num = pll->regs[0], i = 0;
> >> >> +     unsigned long refin, fvco = rate;
> >> >> +     struct reg_cfg *cfg;
> >> >> +
> >> >> +     cfg = kcalloc(reg_num, sizeof(*cfg), GFP_KERNEL);
> >> >> +     if (!cfg)
> >> >> +             return -ENOMEM;
> >> >> +
> >> >> +     refin = pll_get_refin_rate(pll);
> >> >> +
> >> >> +     mask = pmask(pll, PLL_PREDIV);
> >> >> +     index = pindex(pll, PLL_PREDIV);
> >> >> +     width = pwidth(pll, PLL_PREDIV);
> >> >> +     if (width && (ccu_pll_readl(pll, index) & mask))
> >> >> +             refin = refin * 2;
> >> >> +
> >> >> +     mask = pmask(pll, PLL_POSTDIV);
> >> >> +     index = pindex(pll, PLL_POSTDIV);
> >> >> +     width = pwidth(pll, PLL_POSTDIV);
> >> >> +     cfg[index].msk = mask;
> >> >> +     if (width && ((pll->fflag == 1 && fvco <= pll->fvco) ||
> >> >> +                   (pll->fflag == 0 && fvco > pll->fvco)))
> >> >> +             cfg[index].val |= mask;
> >> >> +
> >> >> +     if (width && fvco <= pll->fvco)
> >> >> +             fvco = fvco * 2;
> >> >> +
> >> >> +     mask = pmask(pll, PLL_DIV_S);
> >> >> +     index = pindex(pll, PLL_DIV_S);
> >> >> +     cfg[index].val |= mask;
> >> >> +     cfg[index].msk |= mask;
> >> >> +
> >> >> +     mask = pmask(pll, PLL_SDM_EN);
> >> >> +     index = pindex(pll, PLL_SDM_EN);
> >> >> +     cfg[index].val |= mask;
> >> >> +     cfg[index].msk |= mask;
> >> >> +
> >> >> +     nint  = fvco/(refin * CCU_PLL_1M);
> >> >> +
> >> >> +     mask = pmask(pll, PLL_NINT);
> >> >> +     index = pindex(pll, PLL_NINT);
> >> >> +     shift = pshift(pll, PLL_NINT);
> >> >> +     cfg[index].val |= (nint << shift) & mask;
> >> >> +     cfg[index].msk |= mask;
> >> >> +
> >> >> +     mask = pmask(pll, PLL_KINT);
> >> >> +     index = pindex(pll, PLL_KINT);
> >> >> +     width = pwidth(pll, PLL_KINT);
> >> >> +     shift = pshift(pll, PLL_KINT);
> >> >> +#ifndef CONFIG_64BIT
> >> >> +     i = width < 21 ? 0 : i - 21;
> >> >> +#endif
> >> >
> >> > What's this? Why do we depend on CONFIG_64BIT?
> >>
> >> On 32-bit SoCs, the largest width we can support is limited due to the
> >> limitation of calculation precision.
> >
> > Does the hardware width change? Still not clear to me what's
> > going on here.
> 
> I heard from my colleague, that because the calculation precision on
> Spreadtrum's 32-bit SoCs is different from on 64-bit SoCs,  when the
> width of the value of PLL_KINT is larger than 21, the value is too
> large to be multiplied on 32-bit Spreadtrum's SoCs.

It sounds like you're saying that the clk hardware is not
changing, but the sizeof(long) is different on 64-bit and 32-bit
CPUs so you've added this ifndef here for that.

> 
> i = width < 21 ? 0 : i - 21;
> 
> Here ' i ' is used to adjust 'shift' rather than 'width'  like below (
> wrote the code back for convenience of understanding)
> 
> +       kint = DIV_ROUND_CLOSEST(((fvco - refin * nint * CCU_PLL_1M)/10000) *
> +       ((mask >> (shift + i)) + 1), refin * 100) << i;
> 

Having the types for all these variables would also be helpful.

  u32 mask, shift, width, kint, nint;
  unsigned long refin, fvco;

Why don't we do 64-bit math here instead of 32-bit math? And use
DIV_ROUND_CLOSEST_ULL?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
