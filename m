From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 23 Apr 2014 19:41:54 +0800
Subject: [PATCH] mx-drm: imx-tve: correct DDC property name to
 'ddc-i2c-bus'
In-Reply-To: <1397110745-15731-1-git-send-email-shawn.guo@freescale.com>
References: <1397110745-15731-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140423114152.GG2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 02:19:05PM +0800, Shawn Guo wrote:
> Commit 62e3879 (imx-drm: imx-tve: Fix DDC I2C bus property) was trying
> to use 'ddc-i2c-bus' as the DDC property name (we can see that from the
> commit log), but unfortunately 'i2c-ddc-bus' which is a typo was
> actually used in the code.  This results in some unnecessary
> inconsistency and confusions, because all the documented DDC property
> in device tree bindings use 'ddc-i2c-bus'.
> 
>   Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
>   Documentation/devicetree/bindings/panel/simple-panel.txt
>   Documentation/devicetree/bindings/video/dvi-connector.txt
> 
> Let's fix it before the error spreads.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/boot/dts/imx53-mba53.dts | 2 +-

Okay, I just want to get this little error fixed.  But it seems to
become hard :)

Arnd, Olof,

Can you please give your ACKs on the dts change, so that I can ask
Russell to take the patch?  Otherwise, I will have to split the patch,
which doesn't make too much sense.

Shawn

>  drivers/staging/imx-drm/imx-tve.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
> index 7c8c129..a3431d7 100644
> --- a/arch/arm/boot/dts/imx53-mba53.dts
> +++ b/arch/arm/boot/dts/imx53-mba53.dts
> @@ -244,7 +244,7 @@
>  &tve {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_vga_sync_1>;
> -	i2c-ddc-bus = <&i2c3>;
> +	ddc-i2c-bus = <&i2c3>;
>  	fsl,tve-mode = "vga";
>  	fsl,hsync-pin = <4>;
>  	fsl,vsync-pin = <6>;
> diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
> index 575533f..a23f4f7 100644
> --- a/drivers/staging/imx-drm/imx-tve.c
> +++ b/drivers/staging/imx-drm/imx-tve.c
> @@ -582,7 +582,7 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
>  	tve->dev = dev;
>  	spin_lock_init(&tve->lock);
>  
> -	ddc_node = of_parse_phandle(np, "i2c-ddc-bus", 0);
> +	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
>  	if (ddc_node) {
>  		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
>  		of_node_put(ddc_node);
> -- 
> 1.8.3.2
> 
> 
