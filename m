From: marex@denx.de (Marek Vasut)
Date: Sat, 13 Dec 2014 13:47:22 +0100
Subject: clk: mxs: Invalid register access on HW_CLKCTRL_FRAC0?
In-Reply-To: <1022343616.100338.1418473409091.JavaMail.open-xchange@oxbaltgw00.schlund.de>
References: <1022343616.100338.1418473409091.JavaMail.open-xchange@oxbaltgw00.schlund.de>
Message-ID: <201412131347.22972.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, December 13, 2014 at 01:23:29 PM, Stefan Wahren wrote:
> Hi Fabio,
> 
> yesterday i stumble on this note in the i.MX28 reference manual (p. 931):
> 
>     10.8.24 Fractional Clock Control Register 0 (HW_CLKCTRL_FRAC0)
> 
>     NOTE: This register can only be addressed by byte instructions.
> Addressing word or half-word are not allowed.
> 
> The same applies to HW_CLKCTRL_FRAC1.
> 
> But clk_misc_init() doesn't care about that in clk_imx28.c:
> 
>     val = readl_relaxed(FRAC0);
>     val &= ~((0x3f << BP_FRAC0_IO0FRAC) | (0x3f << BP_FRAC0_IO1FRAC));
>     val |= (30 << BP_FRAC0_IO0FRAC) | (30 << BP_FRAC0_IO1FRAC);
>     writel_relaxed(val, FRAC0);
> 
> The function clk_ref_set_rate() in clk_ref.c write also the complete
> register at once, but change only a byte.
> 
> Which of them are invalid?
> 
> Would you prefer to use writeb() to fix this?

We've been bitten by doing 32-bit writes into the FRAC* registers in U-Boot, so 
the documentation is certainly correct.

Best regards,
Marek Vasut
