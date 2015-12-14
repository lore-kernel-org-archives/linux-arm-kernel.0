From: robh@kernel.org (Rob Herring)
Date: Mon, 14 Dec 2015 16:56:34 -0600
Subject: [PATCH v2] net/macb: add support for resetting PHY using GPIO
In-Reply-To: <1449830093-29433-1-git-send-email-gregory.clement@free-electrons.com>
References: <1449830093-29433-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20151214225634.GA14163@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 11:34:53AM +0100, Gregory CLEMENT wrote:
> With device tree it is no more possible to reset the PHY at board
> level. Furthermore, doing in the driver allow to power down the PHY when
> the network interface is no more used.
> 
> This reset can't be done at the PHY driver level. The PHY must be able to
> answer the to the mii bus scan to let the kernel creating a PHY device.
> 
> The patch introduces a new optional property "phy-reset-gpios" inspired
> from the one use for the FEC.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> 
> Since the v1, I used the gpiod functions. It allows to simplify the
> code and to not introduce any #ifdef.
> 
> I also rename the property in phy-reset-gpios, even if actually the
> gpiod will match both phy-reset-gpios and phy-reset-gpio.
> 
> 
>  Documentation/devicetree/bindings/net/macb.txt | 3 +++
>  drivers/net/ethernet/cadence/macb.c            | 8 ++++++++
>  drivers/net/ethernet/cadence/macb.h            | 1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
> index b5d7976..4a7fb6c 100644
> --- a/Documentation/devicetree/bindings/net/macb.txt
> +++ b/Documentation/devicetree/bindings/net/macb.txt
> @@ -19,6 +19,9 @@ Required properties:
>  	Optional elements: 'tx_clk'
>  - clocks: Phandles to input clocks.
>  
> +Optional properties:
> +- phy-reset-gpios : Should specify the gpio for phy reset
> +

This alone is simple enough, but I worry that this doesn't really scale. 
What if you need to enable clocks or regulators for the same reason? The 
mmc folks did a pwrseq binding for similar reasons. I don't think I'd 
recommend that here as I think it is kind of ugly. We really need a 
pre-probe/scan hook for drivers. This is also needed for USB devices 
mounted on boards.

But I'm not going to hold up something simple to do all that, so:

Acked-by: Rob Herring <robh@kernel.org>
