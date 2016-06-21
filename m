From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Jun 2016 08:29:58 -0500
Subject: [PATCH] can: rcar_canfd: Add Classical CAN only mode support
In-Reply-To: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <20160621132958.GA5283@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 03:46:47PM +0100, Ramesh Shanmugasundaram wrote:
> The controller can operate in one of the two global modes
>  - CAN FD only mode (default)
>  - Classical CAN (CAN2.0) only mode
> 
> This patch adds support for Classical CAN only mode. It can be enabled
> by defining the optional device tree property "renesas,can-nofd" of this
> node.
> 
> Note: R-Car Gen3 h/w manual v0.51E shows bit6 of RSCFDnCFDGCFG as
> reserved, which is incorrect. This bit is same as RSCFDnGCFG.
> 
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
> Hi Marc, All,
> 
>    This patch is based on top of can-next(tag:linux-can-next-for-4.8-20160617).
> 
> Thanks,
> Ramesh.
> ---
>  .../devicetree/bindings/net/can/rcar_canfd.txt     |   9 +-
>  drivers/net/can/rcar/rcar_canfd.c                  | 355 ++++++++++++++-------
>  2 files changed, 249 insertions(+), 115 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> index d45182b..a343359 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> @@ -32,6 +32,12 @@ below properties.
>  - assigned-clocks: phandle of canfd clock.
>  - assigned-clock-rates: maximum frequency of this clock.
>  
> +Optional property:
> +The controller can operate in either CAN FD only mode (default) or
> +Classical CAN only mode. The mode is global to both the channels. In order to
> +enable the later, define the following optional property.
> + - renesas,can-nofd: puts the controller in Classical CAN only mode.

renesas,no-can-fd would be a bit more readable.

> +
>  Example
>  -------
>  
> @@ -63,11 +69,12 @@ SoC common .dtsi file:
>  
>  Board specific .dts file:
>  
> -E.g. below enables Channel 1 alone in the board.
> +E.g. below enables Channel 1 alone in the board in Classical CAN only mode.
>  
>  &canfd {
>          pinctrl-0 = <&canfd1_pins>;
>          pinctrl-names = "default";
> +	renesas,can-nofd;

Now we have a mixture of tabs and spaces.

>          status = "okay";
>  
>  	channel1 {
