From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 19 Oct 2015 23:36:18 +0800
Subject: [PATCH V3 1/2] clk: imx6: Add SPDIF_GCLK clock in clock tree
In-Reply-To: <20151019152807.20687.15779@quantum>
References: <cover.1444471684.git.shengjiu.wang@freescale.com>
 <ee897786f33c9ba67b560964a76485891f2f63a8.1444471684.git.shengjiu.wang@freescale.com>
 <20151019152807.20687.15779@quantum>
Message-ID: <20151019153618.GA14709@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Mon, Oct 19, 2015 at 08:28:07AM -0700, Michael Turquette wrote:
> Quoting Shengjiu Wang (2015-10-10 03:15:06)
> > Correct SPDIF clock setting issue in clock tree, the SPDIF_GCLK is also
> > one clock of SPDIF, which is missed before.
> > 
> > We found an issue that imx can't enter low power mode with spdif
> > if IMX6x_CLK_SPDIF is used as the core clock of spdif. Because
> > spdif driver will register IMX6x_CLK_SPDIF clock to regmap, regmap will do
> > clk_prepare in init function, then IMX6x_CLK_SPDIF clock is prepared in probe,
> > so its parent clock (PLL clock) is prepared, the prepare operation of
> > PLL clock is to enable the clock. But I.MX needs all PLL clock is disabled,
> > then it can enter low power mode.
> > 
> > So we can't use IMX6x_CLK_SPDIF as the core clock of spdif, the correct spdif
> > core clock is SPDIF_GCLK, which share same gate bit with IMX6x_CLK_SPDIF clock.
> > SPDIF_GCLK's parent clock is ipg clock.
> 
> I'm confused by this. Is there really a new clock signal to be added, or
> this just to workaround some reference counting problems with regmap?

I was confused by the previous version of the patch, and asked Shengjiu
to improve the commit log, which seems still not so good.  In short, the
patch does add a missing clock, and the missing of the clock is
discovered by a low-power-mode issue when SPDIF driver is enabled.

> 
> > 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> 
> Please Cc the linux-clk at vger.kernel.org mailing list for future clock
> driver patches.

Right, should have reminded him.  I will keep my eyes more closely on
this.

Shawn
