From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Thu, 8 Mar 2018 14:31:26 +0000
Subject: [PATCH v2] ARM: tegra: fix ulpi regression on tegra20
In-Reply-To: <20180308141501.GH3529@ulmo>
References: <20180222143825.1517-1-marcel@ziswiler.com>
 <20180308141501.GH3529@ulmo>
Message-ID: <1520519485.23006.6.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-03-08 at 15:15 +0100, Thierry Reding wrote:
> On Thu, Feb 22, 2018 at 03:38:25PM +0100, Marcel Ziswiler wrote:
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > Since commit f8f8f1d04494 ("clk: Don't touch hardware when
> > reparenting
> > during registration") ULPI has been broken on Tegra20 leading to
> > the
> > following error message during boot:
> > 
> > [    1.974698] ulpi_phy_power_on: ulpi write failed
> > [    1.979384] tegra-ehci c5004000.usb: Failed to power on the phy
> > [    1.985434] tegra-ehci: probe of c5004000.usb failed with error
> > -110
> > 
> > Debugging through the changes and finally also consulting the TRM
> > revealed that rather than the CDEV2 clock off OSC requiring such
> > pin
> > muxing actually the PLL_P_OUT4 clock is in use. It looks like so
> > far it
> > just worked by chance of that one having been enabled which
> > Stephen's
> > commit now changed when reparenting sclk away from pll_p_out4
> > leaving
> > that one disabled. Fix this by properly assigning the PLL_P_OUT4
> > clock
> > as the ULPI PHY clock.
> > 
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > ---
> > 
> > Changes in v2:
> > - Updated device tree binding documentation as well.
> > - CCing Dmitry as well.
> > 
> >  Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt |
> > 4 +++-
> >  arch/arm/boot/dts/tegra20.dtsi                                   |
> > 2 +-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> Applied, though I've split this into two separate patches, one going
> into for-4.17/dt-bindings and the other going into for-4.17/arm/dt.

Thanks, Thierry!

BTW: Do you know what is happening with my T30 USB patch? Is there
anything I may do about it?

> Thanks,
> Thierry
