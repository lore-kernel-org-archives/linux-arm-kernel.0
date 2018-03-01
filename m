From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Mar 2018 17:24:19 -0600
Subject: [PATCH v2] ARM: tegra: fix ulpi regression on tegra20
In-Reply-To: <20180222143825.1517-1-marcel@ziswiler.com>
References: <20180222143825.1517-1-marcel@ziswiler.com>
Message-ID: <20180301232419.ypehol54rhqrqjds@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 03:38:25PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Since commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting
> during registration") ULPI has been broken on Tegra20 leading to the
> following error message during boot:
> 
> [    1.974698] ulpi_phy_power_on: ulpi write failed
> [    1.979384] tegra-ehci c5004000.usb: Failed to power on the phy
> [    1.985434] tegra-ehci: probe of c5004000.usb failed with error -110
> 
> Debugging through the changes and finally also consulting the TRM
> revealed that rather than the CDEV2 clock off OSC requiring such pin
> muxing actually the PLL_P_OUT4 clock is in use. It looks like so far it
> just worked by chance of that one having been enabled which Stephen's
> commit now changed when reparenting sclk away from pll_p_out4 leaving
> that one disabled. Fix this by properly assigning the PLL_P_OUT4 clock
> as the ULPI PHY clock.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Updated device tree binding documentation as well.
> - CCing Dmitry as well.
> 
>  Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt | 4 +++-
>  arch/arm/boot/dts/tegra20.dtsi                                   | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
