From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Nov 2012 09:32:16 +0900
Subject: [PATCH 6/7] ARM: mach-shmobile: sh73a0: Minimal setup using DT
In-Reply-To: <67705146.EhpdzQI6yT@avalon>
References: <1353889014-17142-1-git-send-email-horms@verge.net.au>
 <CANqRtoQmNh5Sz-YLPMvEbp0FhYW=s2tBez+Duex1vyr=yVnPuA@mail.gmail.com>
 <20121126045805.GC12790@verge.net.au> <67705146.EhpdzQI6yT@avalon>
Message-ID: <20121127003216.GB9724@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 01:53:06PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 26 November 2012 13:58:06 Simon Horman wrote:
> > On Mon, Nov 26, 2012 at 01:23:12PM +0900, Magnus Damm wrote:
> > > On Mon, Nov 26, 2012 at 9:16 AM, Simon Horman <horms@verge.net.au> wrote:
> > > > Allow a minimal setup of the sh73a0 SoC using a flattened device tree.
> > > > 
> > > > * Allow configuration of the i2c controllers using a flattened device
> > > >   tree.
> > > > 
> > > > * SCI serial controller and CMT clock source, whose drivers do not yet
> > > >   support configuration using a flattened device tree, are still
> > > >   configured
> > > >   using C code in order to allow booting of a board with this SoC.
> > > > 
> > > > An example dts snuppet follows:
> > > >         i2c0: i2c at 0xe6820000 {
> > > >         
> > > >                 #address-cells = <1>;
> > > >                 #size-cells = <0>;
> > > >                 compatible = "renesas,rmobile-iic";
> > > >                 reg = <0xe6820000 0x425>;
> > > >                 interrupt-parent = <&gic>;
> > > >                 interrupts = <0 167 0x4
> > > >                 
> > > >                               0 170 0x4>;
> > > >         
> > > >         };
> > > >         
> > > >         i2c1: i2c at 0xe6822000 {
> > > >         
> > > >                 #address-cells = <1>;
> > > >                 #size-cells = <0>;
> > > >                 compatible = "renesas,rmobile-iic";
> > > >                 reg = <0xe6822000 0x425>;
> > > >                 interrupt-parent = <&gic>;
> > > >                 interrupts = <0 51 0x4
> > > >                 
> > > >                               0 44 0x4>;
> > > >                 
> > > >                 touchscreen at 55 {
> > > >                 
> > > >                         compatible = "sitronix,st1232";
> > > >                         reg = <0x55>;
> > > >                         interrupt-parent = <&gic>;
> > > >                         interrupts = <0 9 0x4>;
> > > >                 
> > > >                 };
> > > >         
> > > >         };
> > > >         
> > > >         i2c2: i2c at 0xe6824000 {
> > > >         
> > > >                 #address-cells = <1>;
> > > >                 #size-cells = <0>;
> > > >                 compatible = "renesas,rmobile-iic";
> > > >                 reg = <0xe6824000 0x425>;
> > > >                 interrupt-parent = <&gic>;
> > > >                 interrupts = <0 171 0x4
> > > >                 
> > > >                               0 174 0x4>;
> > > >         
> > > >         };
> > > >         
> > > >         i2c3: i2c at 0xe6826000 {
> > > >         
> > > >                 #address-cells = <1>;
> > > >                 #size-cells = <0>;
> > > >                 compatible = "renesas,rmobile-iic";
> > > >                 reg = <0xe6826000 0x425>;
> > > >                 interrupt-parent = <&gic>;
> > > >                 interrupts = <0 183 0x4
> > > >                 
> > > >                               0 186 0x4>;
> > > >         
> > > >         };
> > > >         
> > > >         i2c4: i2c at 0xe6828000 {
> > > >         
> > > >                 #address-cells = <1>;
> > > >                 #size-cells = <0>;
> > > >                 compatible = "renesas,rmobile-iic";
> > > >                 reg = <0xe6828000 0x425>;
> > > >                 interrupt-parent = <&gic>;
> > > >                 interrupts = <0 187 0x4
> > > >                 
> > > >                               0 190 0x4>;
> > > >         
> > > >         };
> > > 
> > > Uhm, doesn't the above want to go into sh73a0.dtsi?
> > 
> > There are two things that I am unsure of:
> > 
> > * What should go into sh73a0.dtsi and what should go into
> >   sh73a0-kzm9g-refere3nce.dts.
> > 
> >   The i2c seems like it should go into sh73a0.dtsi as it is part of the
> >   soc. Likewise the interrupt controllers.
> > 
> >   But when it comes to mmcif and sdhi I am less sure. Both of these make use
> >   of regulators. Are the regulators part of the board or the SoC?
> 
> It depends on the regulators. In theory you could have on-SoC regulators that 
> would thus be part of the SoC. In practice I'm not sure how often that 
> happens.
> 
> Most of the regulators are provided by the PMIC, so we can create PMIC-
> specific .dtsi files that would be included by boards. See twl4030.dtsi for an 
> example. Other board-specific regulators, including fixed regulators, should 
> be provided by the board.
> 
> >   If the are part of the board then it makes it more difficult to put mmcif
> >   and sdhi into sh73a0.dtsi as they need to reference the regulators
> >   somehow.
> 
> I think you can split a node across several files. You could have
> 
>         mmcif: mmcif at 0x10010000 {
>                 compatible = "renesas,sh-mmcif";
>                 reg = <0xe6bd0000 0x100>;
>                 interrupt-parent = <&gic>;
>                 interrupts = <0 140 0x4
>                               0 141 0x4>;
>                 reg-io-width = <4>;
>         };
> 
> in the SoC .dtsi, and
> 
>         &mmcif {
>                 vmmc-supply = <&fixedregulator1v8>;
>                 vqmmc-supply = <&fixedregulator1v8>;
>         };
> 
> in the board .dts.

Thanks, I discovered that after writing my previous email.
I think it is an approach well suited to the needs of kzm9g
and I intend to use it.

> > * What to do the of_dev_auxdata.
> > 
> >   Currently I add this in patch 4 to the board-kzm9g.c. It is used to force
> >   the name of the i2c, mmcif and sdhi devices in order to allow their clock
> >   lookup to work (though come to think of it it may not be necessary for
> >   mmcif and sdhi).
> 
> Shouldn't clocks be specified as an attribute in DT nodes that reference the 
> clock node ?

Oh, I will look into that.

Magnus's suggestion was to register the names that DT will use
in the clock .c file.

In either case I think we can get rid of auxdata.

> >   In any case, the location of the of_dev_auxdata might be come a bit
> >   tricky if it covers devices in both the board and SoC dts files.
