From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 22:20:10 +0200
Subject: [PATCH 9/9] ARM: Kirkwood: Convert IX2-200 to pinctrl.
In-Reply-To: <20121024220429.50e2b0b8@skate>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-10-git-send-email-andrew@lunn.ch>
 <20121024220429.50e2b0b8@skate>
Message-ID: <20121024202010.GB21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 10:04:29PM +0200, Thomas Petazzoni wrote:
> Andrew,
> 
> On Wed, 24 Oct 2012 16:53:54 +0200, Andrew Lunn wrote:
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |   90 +++++++++++++++++++++++++
> >  arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   24 -------
> >  2 files changed, 90 insertions(+), 24 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> > index 865aeec..d8fa8e8 100644
> > --- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> > +++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> > @@ -16,6 +16,96 @@
> >  	};
> >  
> >  	ocp at f1000000 {
> > +		pinctrl: pinctrl at 10000 {
> > +			compatible = "marvell,88f6281-pinctrl";
> > +			reg = <0x10000 0x20>;
> 
> This definition (compatible + reg) should go in kirkwood.dtsi. The
> pinctrl unit should be declared at the SoC level. Ditto for all other
> patches.

The reg maybe. Compatibility not. We need to tell pinctrl which of the
5 different variants of kirkwood this particular kirkwood is. See

drivers/pinctrl/pinctrl-kirkwood.c

enum kirkwood_variant {
        VARIANT_MV88F6180 = V(1, 0, 0, 0, 0),
        VARIANT_MV88F6190 = V(0, 1, 0, 0, 0),
        VARIANT_MV88F6192 = V(0, 0, 1, 0, 0),
        VARIANT_MV88F6281 = V(0, 0, 0, 1, 0),
        VARIANT_MV88F6282 = V(0, 0, 0, 0, 1),
};

static struct of_device_id kirkwood_pinctrl_of_match[] __devinitdata = {
        { .compatible = "marvell,88f6180-pinctrl", .data = &mv88f6180_info },
        { .compatible = "marvell,88f6190-pinctrl", .data = &mv88f6190_info },
        { .compatible = "marvell,88f6192-pinctrl", .data = &mv88f6192_info },
        { .compatible = "marvell,88f6281-pinctrl", .data = &mv88f6281_info },
        { .compatible = "marvell,88f6282-pinctrl", .data = &mv88f6282_info },
        { }
};

What SoC is mounted on a board is a property of the board....

     Andrew
