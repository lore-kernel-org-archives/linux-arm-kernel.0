From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 13 Dec 2014 17:04:59 +0100 (CET)
Subject: clk: mxs: Invalid register access on HW_CLKCTRL_FRAC0?
In-Reply-To: <201412131347.22972.marex@denx.de>
References: <1022343616.100338.1418473409091.JavaMail.open-xchange@oxbaltgw00.schlund.de>
 <201412131347.22972.marex@denx.de>
Message-ID: <626823862.133104.1418486699870.JavaMail.open-xchange@oxbaltgw02.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

> Marek Vasut <marex@denx.de> hat am 13. Dezember 2014 um 13:47 geschrieben:
>
>
> On Saturday, December 13, 2014 at 01:23:29 PM, Stefan Wahren wrote:
> > Hi Fabio,
> >
> > yesterday i stumble on this note in the i.MX28 reference manual (p. 931):
> >
> > 10.8.24 Fractional Clock Control Register 0 (HW_CLKCTRL_FRAC0)
> >
> > NOTE: This register can only be addressed by byte instructions.
> > Addressing word or half-word are not allowed.
> >
> > The same applies to HW_CLKCTRL_FRAC1.
> >
> > But clk_misc_init() doesn't care about that in clk_imx28.c:
> >
> > val = readl_relaxed(FRAC0);
> > val &= ~((0x3f << BP_FRAC0_IO0FRAC) | (0x3f << BP_FRAC0_IO1FRAC));
> > val |= (30 << BP_FRAC0_IO0FRAC) | (30 << BP_FRAC0_IO1FRAC);
> > writel_relaxed(val, FRAC0);
> >
> > The function clk_ref_set_rate() in clk_ref.c write also the complete
> > register at once, but change only a byte.
> >
> > Which of them are invalid?
> >
> > Would you prefer to use writeb() to fix this?
>
> We've been bitten by doing 32-bit writes into the FRAC* registers in U-Boot,
> so
> the documentation is certainly correct.

do you think of this patch [1]?

Are only 32-bit writes critical or reads too?

Stefan

[1] - http://lists.denx.de/pipermail/u-boot/2012-February/118746.html

>
> Best regards,
> Marek Vasut
>
