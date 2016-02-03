From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 Feb 2016 20:07:46 +0100
Subject: [PATCH v3 2/2] clk: sunxi: Refactor A31 PLL6 so that it can be
 reused
In-Reply-To: <20160202075239.e4318e9dced1eeed29c593f6@free.fr>
References: <1454008958-12655-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454008958-12655-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160130185714.7abcf1de9ef8108c2f48c7fe@free.fr>
 <20160201201754.GI4652@lukather>
 <20160202075239.e4318e9dced1eeed29c593f6@free.fr>
Message-ID: <20160203190746.GJ4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 07:52:39AM +0100, Jean-Francois Moine wrote:
> On Mon, 1 Feb 2016 21:17:54 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > > Also, for the H3 PLL periph1 (aka PLL8), why didn't you create a
> > > 'pll8x2' clock with 'pll8' as a divider?
> > 
> > No one seems to use it. We can always add it later in a separate
> > patch when someone will.
> 
> Well, then, I don't understand. The pll periph/peripheral/periph0,
> aka PLL6 works well for many SoCs and there is no need to change
> its DT definition.
> 
> In the patch header, you wrote:
> 
> > Remove the fixed dividers from the PLL6 driver to be able to have a
> > reusable driver that can be used across several SoCs that share the same
> > controller, but don't have the same set of dividers for this clock, and to
> > also be reused multiple times in the same SoC, since we're droping the
> > clock name.
> 
> then, for the H3, you do
> (the comment should be "until pll8 can be reused"),

No. The comment is right. Even though pll8 was just another instance
of pll6, the pll6 driver couldn't be reused because the clock name was
hardcoded in the driver, and you couldn't register two clocks with the
same name.

This was done because this driver has several outputs, the main PLL
output, plus all the various dividers it might have in the various
SoCs.

So, no. It was not working fine on "many" SoCs. And this is exactly
what this patch fixes.

> > -		/* dummy clock until pll6 can be reused */
> > -		pll8: pll8_clk {
> > +		pll8: clk at 01c20044 {
> >  			#clock-cells = <0>;
> > -			compatible = "fixed-clock";
> > -			clock-frequency = <1>;
> > +			compatible = "allwinner,sun6i-a31-pll6-clk";
> > +			reg = <0x01c20044 0x4>;
> > +			clocks = <&osc24M>;
> >  			clock-output-names = "pll8";
> >  		};
> 
> that is, you add the PLL8, don't you?

I guess it's just a matter of interpretation, but no, I'm just
removing the placeholder that was there.

> 
> And, further, you change the MMC clocks:
> 
> > @@ -243,7 +243,7 @@
> >  			#clock-cells = <1>;
> >  			compatible = "allwinner,sun4i-a10-mmc-clk";
> >  			reg = <0x01c20088 0x4>;
> > -			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
> > +			clocks = <&osc24M>, <&pll6>, <&pll8>;
> >  			clock-output-names = "mmc0",
> >  					     "mmc0_output",
> >  					     "mmc0_sample";
> 
> where the PLL8 is already used.
> 
> So, how can you say
> 
> > No one seems to use it. We can always add it later in a separate
> > patch when someone will.

Because I was replying to a request from you asking about
pll8x2. The code you quote is about pll8...

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/d4be01d1/attachment.sig>
