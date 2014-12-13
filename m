From: marex@denx.de (Marek Vasut)
Date: Sat, 13 Dec 2014 19:39:11 +0100
Subject: clk: mxs: Invalid register access on HW_CLKCTRL_FRAC0?
In-Reply-To: <626823862.133104.1418486699870.JavaMail.open-xchange@oxbaltgw02.schlund.de>
References: <1022343616.100338.1418473409091.JavaMail.open-xchange@oxbaltgw00.schlund.de>
 <201412131347.22972.marex@denx.de>
 <626823862.133104.1418486699870.JavaMail.open-xchange@oxbaltgw02.schlund.de>
Message-ID: <201412131939.11514.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, December 13, 2014 at 05:04:59 PM, Stefan Wahren wrote:
> Hi Marek,
> 
> > Marek Vasut <marex@denx.de> hat am 13. Dezember 2014 um 13:47
> > geschrieben:
> > 
> > On Saturday, December 13, 2014 at 01:23:29 PM, Stefan Wahren wrote:
> > > Hi Fabio,
> > > 
> > > yesterday i stumble on this note in the i.MX28 reference manual (p.
> > > 931):
> > > 
> > > 10.8.24 Fractional Clock Control Register 0 (HW_CLKCTRL_FRAC0)
> > > 
> > > NOTE: This register can only be addressed by byte instructions.
> > > Addressing word or half-word are not allowed.
> > > 
> > > The same applies to HW_CLKCTRL_FRAC1.
> > > 
> > > But clk_misc_init() doesn't care about that in clk_imx28.c:
> > > 
> > > val = readl_relaxed(FRAC0);
> > > val &= ~((0x3f << BP_FRAC0_IO0FRAC) | (0x3f << BP_FRAC0_IO1FRAC));
> > > val |= (30 << BP_FRAC0_IO0FRAC) | (30 << BP_FRAC0_IO1FRAC);
> > > writel_relaxed(val, FRAC0);
> > > 
> > > The function clk_ref_set_rate() in clk_ref.c write also the complete
> > > register at once, but change only a byte.
> > > 
> > > Which of them are invalid?
> > > 
> > > Would you prefer to use writeb() to fix this?
> > 
> > We've been bitten by doing 32-bit writes into the FRAC* registers in
> > U-Boot, so
> > the documentation is certainly correct.
> 
> do you think of this patch [1]?

Yes

> Are only 32-bit writes critical or reads too?

I cannot tell about reads, but writes for sure . Sorry I'm not of more help.

> Stefan
> 
> [1] - http://lists.denx.de/pipermail/u-boot/2012-February/118746.html
> 
> > Best regards,
> > Marek Vasut

Best regards,
Marek Vasut
