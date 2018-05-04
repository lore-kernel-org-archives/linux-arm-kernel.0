From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 4 May 2018 15:03:40 +0800
Subject: [PATCH v4 6/7] ARM: dts: Add support for emtrion emCON-MX6 series
In-Reply-To: <95F51F4B902CAC40AF459205F6322F01B83109E5C3@BMK019S01.emtrion.local>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-7-jan.tuerk@emtrion.com>
 <20180428031231.GB3693@dragon>
 <95F51F4B902CAC40AF459205F6322F01B83109E5C3@BMK019S01.emtrion.local>
Message-ID: <20180504070339.GS3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 12:00:06PM +0200, T?rk, Jan wrote:
> > > +/ {
> > > +   aliases {
> > > +           mmc0 = &usdhc3;
> > > +           mmc2 = &usdhc1;
> > > +           mmc1 = &usdhc2;
> > > +           mmc3 = &usdhc4;
> > > +           boardID = &boardID;
> >
> > Why do you need this boardID alias?
> I wanted to have a generic entry point to address the board-id on all CPU-modules with their different SoC's resulting in different devicetree paths.
> Also as it now has the generic "gpio at 3a" name, there would be no other way in differencing the board Identifying GPIO-expander from an additionally
> attached one (except platform code etc.)
> With the alias every code could look up the information required over the alias path with the same piece of code.

Okay.  But no uppercase please.  Otherwise, you introduce the following
DTC warnings (with W=1 switch) we are trying to clean up.

 Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'

> >
> > > +   };

<snip>

> > > &pinctrl_nor_flash
> > > +            &pinctrl_usdhc2
> > > +            &pinctrl_spdif_out     &pinctrl_spdif_in
> > > +            &pinctrl_cpi1          &pinctrl_cpi2
> > > +           >;
> >
> > Again, please do not put consumer device specific pins in hog group.
> > Also, it's confusing to have the same pinctrl in both hog and consumer device
> > node, like pinctrl_nor_flash and pinctrl_usdhc2 here.
> 
> About pinctrl_nor_flash I fully agree, that's a mistake.
> pinctrl_usdhc2 is not connected on the avari, and therefore not enabled.
> As told before it is added to the Hog group to force the default pinmuxing without enabling the hardware itself.

If you want to do such default pinmuxing, please do it in your firmware.
We generally do not want to use hog group too much, because that makes
it difficult to find out which client devices consume which pins.

> 
> >
> > > +};

<snip>

> > > +&i2c1 {
> > > +   clock-frequency = <100000>;
> > > +   pinctrl-names = "default";
> > > +   pinctrl-0 = <&pinctrl_i2c1>;
> > > +   status = "okay";
> > > +
> > > +   rtc: rtc at 68 {
> >
> > Is the label actually used?  If yes, I would suggest a more specific name like
> > ds1307.
> Really? Why should it be a generic name for "gpio" and "pmic" but not a generic name for an "rtc" chip?

I'm talking about label not node name.  That said I was suggesting
something like:

	ds1307: rtc at 68

> 
> >
> > > +           compatible = "dallas,ds1307";
> > > +           reg = <0x68>;
> > > +   };

Shawn
