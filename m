From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 31 Jan 2016 15:26:28 +0100
Subject: [PATCH v3 2/2] clk: sunxi: Refactor A31 PLL6 so that it can be
 reused
In-Reply-To: <CAGb2v67S9mhr1hbmM3nuLO+wTGA3ff2vUhBgm+PTnd_5vGS3ng@mail.gmail.com>
References: <1454008958-12655-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454008958-12655-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160130185714.7abcf1de9ef8108c2f48c7fe@free.fr>
 <CAGb2v67S9mhr1hbmM3nuLO+wTGA3ff2vUhBgm+PTnd_5vGS3ng@mail.gmail.com>
Message-ID: <20160131152628.aefb1c8f52d789e12f30129d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 31 Jan 2016 20:08:40 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Sun, Jan 31, 2016 at 1:57 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > On Thu, 28 Jan 2016 20:22:38 +0100
> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> >
> >> Remove the fixed dividers from the PLL6 driver to be able to have a
> >> reusable driver that can be used across several SoCs that share the same
> >> controller, but don't have the same set of dividers for this clock, and to
> >> also be reused multiple times in the same SoC, since we're droping the
> >> clock name.
	[snip]
> > Hi Maxime,
> >
> > Do you know that the DT definitions cannot be changed when they are in
> > the mainline kernel?
> 
> This rule varies depending on who you talk to. :)
> 
> > Also, for the H3 PLL periph1 (aka PLL8), why didn't you create a
> > 'pll8x2' clock with 'pll8' as a divider?
> 
> If it's used, it can be added later. No need to bloat the DT.

In
	[PATCH v3 2/2] clk: sunxi: Refactor A31 PLL6 so that it can be reused

  diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi

you may see:

> -		/* dummy clock until pll6 can be reused */
> -		pll8: pll8_clk {
> +		pll8: clk at 01c20044 {
>  			#clock-cells = <0>;
> -			compatible = "fixed-clock";
> -			clock-frequency = <1>;
> +			compatible = "allwinner,sun6i-a31-pll6-clk";
> +			reg = <0x01c20044 0x4>;
> +			clocks = <&osc24M>;
>  			clock-output-names = "pll8";
>  		};

So, the pll periph1 is already there.

I was just saying that adding a pll8x2 would avoid changing the actual
pll6 and a lot of DT definitions.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
