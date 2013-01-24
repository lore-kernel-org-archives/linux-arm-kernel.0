From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 24 Jan 2013 21:52:50 +0100
Subject: [RFC PATCH 6/6] ARM: kirkwood: consolidate mv643xx_eth init for DT
In-Reply-To: <20130124203824.GG1758@titan.lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <3084778.eWbl5o3HSt@bender> <20130124203824.GG1758@titan.lakedaemon.net>
Message-ID: <33979531.bU6WbEu7BD@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 January 2013 15:38:24 Jason Cooper wrote:
> On Thu, Jan 24, 2013 at 09:27:24PM +0100, Florian Fainelli wrote:
> > On Thursday 24 January 2013 13:16:22 Jason Cooper wrote:
> > > > >Ian's patch appears to do so.  I'll respin this series using it vice my
> > > > >lookup table.
> > > > >
> > > > Sounds good, while at it, I wonder if we could not simplify Ian's
> > > > patch to be limited to the actual Ethernet MAC driver and use
> > > > Thomas's mvdio device tree binding for the MDIO bits of mv643xx_eth.
> > > > What do you think?
> > > 
> > > It sounds like you just volunteered ;-)  Do you think you have the time
> > > to knock it out for v3.9?
> > 
> > I do not have any kirkwood board at the moment and I really want to be able to 
> > test this properly especially with the "clock must be enabled for ethernet not 
> > be lost". Let me get one and I should be able to do it. Let's adopt your patch 
> > for the moment, and once I have a kirkwood board I can deal with the ethernet 
> > driver device tree bindings.
> > 
> > Does that sound ok with you?
> 
> using Ian's patch as is, I have the following in kirkwood.dtsi:
> 
> +
> +               smi0: mdio at 72000 {
> +                       compatible = "marvell,mdio-mv643xx";
> +                       reg = <0x72000 0x4000>;
> +                       interrupts = <46>;
> +                       status = "disabled";
> +               };
> +
> +               smi1: mdio at 76000 {
> +                       compatible = "marvell,mdio-mv643xx";
> +                       reg = <0x76000 0x4000>;
> +                       interrupts = <47>;
> +                       status = "disabled";
> +               };
> +
> +               egiga0 {
> +                       compatible = "marvell,mv643xx-eth";
> +                       reg = <0x72000 0x4000>;
> +                       mdio = <&smi0>;
> +                       port_number = <0>;
> +                       phy_addr = <0x80>;
> +                       interrupts = <11>;
> +                       clocks = <&gate_clk 0>;
> +                       status = "disabled";
> +               };
> +
> +               egiga1 {
> +                       compatible = "marvell,mv643xx-eth";
> +                       reg = <0x76000 0x4000>;
> +                       mdio = <&smi1>;
> +                       port_number = <1>;
> +                       phy_addr = <0x81>;
> +                       interrupts = <15>;
> +                       clocks = <&gate_clk 19>;
> +                       status = "disabled";
> +               };
> 
> I'll see if I can get it working as is, then we can migrate to Thomas'
> mdio bindings.
> 
> btw - it might be a shared smi, I haven't looked yet, and haven't
> tested...

Ok, the existing mv643xx-eth SMI code also deals with an interrupt-driven SMI
completion scheme, which is not handled yet with Thomas's mvmdio driver.
-- 
Florian
