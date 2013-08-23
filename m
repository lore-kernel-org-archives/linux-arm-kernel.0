From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 22 Aug 2013 21:26:21 -0400
Subject: [PATCH 7/7] watchdog: orion: Update device-tree binding
 documentation
In-Reply-To: <1377182518-12554-8-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377182518-12554-8-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130823012621.GD13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 11:41:58AM -0300, Ezequiel Garcia wrote:
> Change the 'reg' property meaning, by defining three required cells.
> It's important to note this commit breaks DT-compatibility for this
> device.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/watchdog/orion-wdt.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> index 5dc8d30..bb7f1a2 100644
> --- a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> @@ -3,7 +3,10 @@
>  Required Properties:
>  
>  - Compatibility : "marvell,orion-wdt"
> -- reg		: Address of the timer registers
> +- reg		: Three cells are required.
> +		  First  cell contains the global timer control register.
> +		  Second cell contains the watchdog counter register.
> +		  Third  cell contains the RSTOUT register.
>  
>  Optional properties:
>  
> @@ -13,7 +16,9 @@ Example:
>  
>  	wdt at 20300 {
>  		compatible = "marvell,orion-wdt";
> -		reg = <0x20300 0x28>;
> +		reg = <0x20300 0x4
> +		       0x20324 0x4
> +		       0x20108 0x4>;

I don't like this.  It reaches outside of the wdt register.  I think a
more clean way to do this is to do a provider/consumer relationship as
in reset.txt.  eg, here you would retain the original reg binding, and
add a reset phandle.

thx,

Jason.
