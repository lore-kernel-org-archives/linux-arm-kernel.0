From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Jan 2017 22:02:46 +0200
Subject: [PATCH 6/7] mfd: exynos-lpass: Add support for clocks
In-Reply-To: <20170125200006.gy7akzxegecyiuhu@kozik-lap>
References: <1485345031-2948-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115104eucas1p1c725f2854fb4cff98548721f79dd6a5b@eucas1p1.samsung.com>
 <1485345031-2948-7-git-send-email-m.szyprowski@samsung.com>
 <20170125200006.gy7akzxegecyiuhu@kozik-lap>
Message-ID: <20170125200246.637rax7qpz4id6zu@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 10:00:06PM +0200, Krzysztof Kozlowski wrote:
> On Wed, Jan 25, 2017 at 12:50:30PM +0100, Marek Szyprowski wrote:
> > Exynos LPASS requires some clocks to be enabled to make any access to its
> > registers. This patch adds code for handling such clocks. For current set
> > of registers it is enough to keep sfr0_ctrl clock enabled. Till now it
> > worked only because those clocks were enabled by bootloader and driver
> > probe() happened before they were disabled by clock core because of lack
> > of users. Handling those clocks is also needed to make it possible to
> > enable support for audio power domain.
> > 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  .../devicetree/bindings/mfd/samsung,exynos5433-lpass.txt       |  6 ++++++
> >  drivers/mfd/exynos-lpass.c                                     | 10 ++++++++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> > index a8deaee82c44..df664018c148 100644
> > --- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> > +++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> > @@ -5,6 +5,10 @@ Required properties:
> >   - compatible		: "samsung,exynos5433-lpass"
> >   - reg			: should contain the LPASS top SFR region location
> >  			  and size
> > + - clock-names		: should contain following required clocks: "sfr0_ctrl"
> > + - clocks		: should contain clock specifiers of all clocks, which
> > +			  input names have been specified in clock-names
> > +			  property, in same order.
> >   - #address-cells	: should be 1
> >   - #size-cells		: should be 1
> >   - ranges		: must be present
> > @@ -24,6 +28,8 @@ Example:
> >  audio-subsystem {
> >  	compatible = "samsung,exynos5433-lpass";
> >  	reg = <0x11400000 0x100>, <0x11500000 0x08>;
> > +	clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
> > +	clock-names = "sfr0_ctrl";
> >  	#address-cells = <1>;
> >  	#size-cells = <1>;
> >  	ranges;
> > diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
> > index 17915daa2e80..44d8ea1a978b 100644
> > --- a/drivers/mfd/exynos-lpass.c
> > +++ b/drivers/mfd/exynos-lpass.c
> > @@ -14,6 +14,7 @@
> >   * only version 2 as published by the Free Software Foundation.
> >   */
> >  
> > +#include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > @@ -52,6 +53,7 @@
> >  struct exynos_lpass {
> >  	/* pointer to the LPASS TOP regmap */
> >  	struct regmap *top;
> > +	struct clk *sfr0_clk;
> >  };
> >  
> >  static void exynos_lpass_core_sw_reset(struct exynos_lpass *lpass, int mask)
> > @@ -71,6 +73,8 @@ static void exynos_lpass_core_sw_reset(struct exynos_lpass *lpass, int mask)
> >  
> >  static void exynos_lpass_enable(struct exynos_lpass *lpass)
> >  {
> > +	clk_prepare_enable(lpass->sfr0_clk);
> > +
> >  	/* Unmask SFR, DMA and I2S interrupt */
> >  	regmap_write(lpass->top, SFR_LPASS_INTR_CA5_MASK,
> >  		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
> > @@ -88,6 +92,8 @@ static void exynos_lpass_disable(struct exynos_lpass *lpass)
> >  	/* Mask any unmasked IP interrupt sources */
> >  	regmap_write(lpass->top, SFR_LPASS_INTR_CPU_MASK, 0);
> >  	regmap_write(lpass->top, SFR_LPASS_INTR_CA5_MASK, 0);
> > +
> > +	clk_disable_unprepare(lpass->sfr0_clk);
> >  }
> >  
> >  static const struct regmap_config exynos_lpass_reg_conf = {
> > @@ -114,6 +120,10 @@ static int exynos_lpass_probe(struct platform_device *pdev)
> >  	if (IS_ERR(base_top))
> >  		return PTR_ERR(base_top);
> >  
> > +	lpass->sfr0_clk = clk_get(dev, "sfr0_ctrl");
> > +	if (IS_ERR(lpass->sfr0_clk))
> > +		return PTR_ERR(lpass->sfr0_clk);
> 
> devm_clk_get() or implement the remove() or the unbind should be
> suppressed.
> 
> Not related to this particular patch, but:
> 1. regmap_exit() is also missing (anyone would like to add it?),
> 2. Also I wonder, whether we would like to disable the LPASS on
>    unbind...

I forgot about one thing - please mention in the commit message that
this breaks the ABI or requires changes in DTS to provide the clock.

Best regards,
Krzysztof
