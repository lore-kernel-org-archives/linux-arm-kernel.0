From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Aug 2013 16:17:23 +0100
Subject: [PATCH 09/33] ARM: ux500: Supply the I2C clocks lookup to the
 DBX500 DT
In-Reply-To: <20130822141900.GB17154@lee--X1>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdbE86HgPr+7LZD9BFU_OsDFFFWTaFHW_i2fNXivKZ-3Dw@mail.gmail.com>
 <20130820093034.GL31036@pengutronix.de>
 <20130822133730.GB23152@e106331-lin.cambridge.arm.com>
 <20130822141900.GB17154@lee--X1>
Message-ID: <20130822151723.GE23152@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 03:19:00PM +0100, Lee Jones wrote:
> On Thu, 22 Aug 2013, Mark Rutland wrote:
> 
> > On Tue, Aug 20, 2013 at 10:30:34AM +0100, Sascha Hauer wrote:
> > > On Tue, Aug 20, 2013 at 11:11:19AM +0200, Linus Walleij wrote:
> > > > On Thu, Jun 6, 2013 at 2:16 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > > > 
> > > > > +++ b/arch/arm/boot/dts/dbx5x0.dtsi
> > > > > @@ -572,6 +572,8 @@
> > > > >                         v-i2c-supply = <&db8500_vape_reg>;
> > > > >
> > > > >                         clock-frequency = <400000>;
> > > > > +                       clocks = <&prcc_kclk 3 3>, <&prcc_pclk 3 3>;
> > > > > +                       clock-names = "nmk-i2c.0", "apb_pclk";
> > > 
> > > Why do most clocks in this series have the instance number in the clock
> > > names? This looks very wrong to me.
> > 
> > +1. The clock names should be the input names to the unit, they
> > shouldn't vary per instance.
> 
> So I just had a quick look, and it looks like they each have their own
> clock:
> 
> 	clk = clk_reg_prcc_kclk("p1_i2c1_kclk", "i2cclk",
> 			clkrst1_base, BIT(2), CLK_SET_RATE_GATE);
> 	clk = clk_reg_prcc_kclk("p1_i2c2_kclk", "i2cclk",
> 			clkrst1_base, BIT(6), CLK_SET_RATE_GATE);
> 	clk = clk_reg_prcc_kclk("p2_i2c3_kclk", "i2cclk",
> 			clkrst2_base, BIT(0), CLK_SET_RATE_GATE);
> 	clk_register_clkdev(clk, NULL, "nmk-i2c.3");
>         
>         /* etc */
> 
> When using the names in Device Tree it doesn't actually matter what
> you call the first clock. You can call it "fred" if you wanted and it
> would still work, but in light of the naming conventions above and the
> fact that each clock can all be controlled independently, do we still
> want to use the name of the parent clock i.e. i2cclk?

Sorry, I don't follow.


The name should be the name of the clock _input_ on the block described,
as should be listed in documentation for the i2c block. The name should
not vary with instance, and the name should not (necessarily) match the
_output_ of the provider. Surely there's documentation for the i2c block
that gives a name for the clock input(s)?

On a related note, I see that this doesn't follow the primecell clock
bindings, which seem to rely on "apb_pclk" being first in the list. I
see that other primecell device bindings don't follow that in dts or
drivers, so I'm not sure how to fix that brokenness.

Thanks,
Mark.
