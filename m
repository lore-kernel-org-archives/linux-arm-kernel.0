From: dev@lynxeye.de (Lucas Stach)
Date: Wed, 22 Jul 2015 22:15:29 +0200
Subject: [Patch v3 1/5] mtd: nand: tegra: add devicetree binding
In-Reply-To: <20150721210537.GL24125@google.com>
References: <1431282602-7137-1-git-send-email-dev@lynxeye.de>
 <1431282602-7137-2-git-send-email-dev@lynxeye.de>
 <20150721210537.GL24125@google.com>
Message-ID: <1437596129.2289.2.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 21.07.2015, 14:05 -0700 schrieb Brian Norris:
> On Sun, May 10, 2015 at 08:29:58PM +0200, Lucas Stach wrote:
> > This adds the devicetree binding for the Tegra 2 NAND flash
> > controller.
> > 
> > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > ---
> >  .../bindings/mtd/nvidia,tegra20-nand.txt           | 29 ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > new file mode 100644
> > index 0000000..522d442
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > @@ -0,0 +1,29 @@
> > +NVIDIA Tegra NAND Flash controller
> > +
> > +Required properties:
> > +- compatible: Must be one of:
> > +  - "nvidia,tegra20-nand"
> > +- reg: MMIO address range
> > +- interrupts: interrupt output of the NFC controller
> > +- clocks: Must contain an entry for each entry in clock-names.
> > +  See ../clocks/clock-bindings.txt for details.
> > +- clock-names: Must include the following entries:
> > +  - nand
> > +- resets: Must contain an entry for each entry in reset-names.
> > +  See ../reset/reset.txt for details.
> > +- reset-names: Must include the following entries:
> > +  - nand
> > +
> > +Optional properties:
> > +- nvidia,wp-gpios: GPIO used to disable write protection of the flash
> 
> I think write-protect is a pretty common function, so we might want to
> just remove the 'nvidia,' prefix, so we can eventually move your code to
> the core nand_base.c library (BTW, I noticed you grab the GPIO, but you
> don't do anything with it; is that intentional?). In fact, I've seen
> requests for that very feature on the mailing list.
> 

Actually I request and activate the GPIO in the driver, so the chip is
permanently unprotected.

I agree that it would be nice to integrate this better into the NAND
core. If it's okay for you I'll drop the nvidia prefix and follow up
with patches to move this to the core after this driver is in. I don't
really want this driver get blocked on more dependencies.

> > +
> > +  Example:
> > +	nand at 70008000 {
> > +		compatible = "nvidia,tegra20-nand";
> > +		reg = <0x70008000 0x100>;
> > +		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
> > +		clock-names = "nand";
> > +		resets = <&tegra_car 13>;
> > +		reset-names = "nand";
> > +	};
> 
> Otherwise, looks good.
> 
> Reviewed-by: Brian Norris <computersforpeace@gmail.com>
> 
> I have a few comments on the NAND driver, too.
> 
Thanks for the review.

Regards,
Lucas
