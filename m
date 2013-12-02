From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Dec 2013 11:51:18 +0000
Subject: [PATCH 1/2] chipidea: ci_hdrc_imx: Allow handling the clock
 for an USB phy/hub
In-Reply-To: <1384394987-15134-1-git-send-email-festevam@gmail.com>
References: <1384394987-15134-1-git-send-email-festevam@gmail.com>
Message-ID: <20131202115118.GG12952@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:09:46AM +0000, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When using external USB PHY or USB hub, it is common that they require a clock
> input.
> 
> Add a 'clk_phy' clock, so that it can be retrieved from the device tree and 
> enabled in the driver, so that the clock can properly drive the external 
> USB phy/hub.

As this clock feeds the PHY, it should be described on the PHY node.
It's a property of the PHY itself.

> 
> Tested on a imx6q-udoo board, that connects via USBH1 to a USB2514 hub.
> 
> In this board the USB2514 is clocked from a 24MHz clock that comes from the 
> imx6q CLKO2 pin.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  .../devicetree/bindings/usb/ci13xxx-imx.txt          |  2 ++
>  drivers/usb/chipidea/ci_hdrc_imx.c                   | 20 +++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> index b4b5b79..07ba38c 100644
> --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> @@ -18,6 +18,8 @@ Optional properties:
>  - vbus-supply: regulator for vbus
>  - disable-over-current: disable over current detect
>  - external-vbus-divider: enables off-chip resistor divider for Vbus
> +- clocks: phandle to the clock that drives the USB hub

If you're using clock-names, define clocks in terms of it:

- clocks: a list of phandle + clock-specifier pairs corresponding to
  entries in clock-names.

> +- clock-names: must be "phy"

s/must be/should contain/

Thanks,
Mark.
