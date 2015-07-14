From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 14 Jul 2015 12:59:53 +0200
Subject: [PATCH v9 3/4] arm/dts/ls1021a: Add DCU dts node
In-Reply-To: <1436784692-40560-3-git-send-email-jianwei.wang@freescale.com>
References: <1436784692-40560-1-git-send-email-jianwei.wang@freescale.com>
 <1436784692-40560-3-git-send-email-jianwei.wang@freescale.com>
Message-ID: <20150714105952.GK12465@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 06:51:31PM +0800, Jianwei Wang wrote:
> Add DCU node, DCU is a display controller of Freescale
> named 2D-ACE.
> 
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
> Signed-off-by: Jianwei Wang <b52261@freescale.com>
> Reviewed-by: Alison Wang <alison.wang@freescale.com>
> ---
>  .../devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt      | 20 ++++++++++++++++++++
>  MAINTAINERS                                          |  1 +
>  arch/arm/boot/dts/ls1021a.dtsi                       | 10 ++++++++++
>  3 files changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt
> 
> diff --git a/Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt b/Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt
> new file mode 100644
> index 0000000..eb61ea5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt

That's not the proper location for this file. DRM is a Linux-specific
subsystem and hence shouldn't be used in anything devicetree-related.
Documentation/devicetree/bindings/video would be a better location.

Yes, I know other DRM drivers put their binding in the drm subdirectory
but that just makes them equally wrong. I'll make a note to move these
around at some point.

Also the binding really belongs in the same patch as the driver, or a
separate patch altogether.

And, no need for the extra fsl-dcu subdirectory if you have only a
single document in it.

> @@ -0,0 +1,20 @@
> +Device Tree bindings for Freescale DCU DRM Driver
> +
> +Required properties:
> +- compatible:           Should be one of
> +	* "fsl,ls1021a-dcu".
> +	* "fsl,vf610-dcu".
> +- reg:                  Address and length of the register set for dcu.
> +- clocks:               From common clock binding: handle to dcu clock.
> +- clock-names:          From common clock binding: Shall be "dcu".
> +- panel:		The phandle to panel node.

This isn't a standard property and hence should be prefixed by the
vendor prefix. That is: "fsl,panel".

Also the above uses a weird mix of spaces and tabs for padding. Please
be more consistent.

> +
> +Examples:
> +dcu: dcu at 2ce0000 {
> +	compatible = "fsl,ls1021a-dcu";
> +	reg = <0x0 0x2ce0000 0x0 0x10000>;
> +	clocks = <&platform_clk 0>;
> +	clock-names = "dcu";
> +	big-endian;

This property isn't mentioned above. I know it's pretty obvious what it
does, but might still be worth briefly describing what it is. I'm also
wondering if that's not something that could be inferred from the
compatible string.

> +	panel = <&panel>;
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e191ded..fffb8c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3410,6 +3410,7 @@ M:	Alison Wang <alison.wang@freescale.com>
>  L:	dri-devel at lists.freedesktop.org
>  S:	Supported
>  F:	drivers/gpu/drm/fsl-dcu/
> +F:      Documentation/devicetree/bindings/drm/fsl-dcu/

You might want to shuffle around some of these hunks, so that this
particular hunk is included in the driver patch along with the binding
and the panel patch doesn't remove it only for it to be readded here.

Thierry

>  F:      Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
>  
>  DRM DRIVERS FOR NVIDIA TEGRA
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index c70bb27..6d6e3e2 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -383,6 +383,16 @@
>  				 <&platform_clk 1>;
>  		};
>  
> +		dcu: dcu at 2ce0000 {
> +			compatible = "fsl,ls1021a-dcu";
> +			reg = <0x0 0x2ce0000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 0>;
> +			clock-names = "dcu";
> +			big-endian;
> +			status = "disabled";
> +		};
> +
>  		mdio0: mdio at 2d24000 {
>  			compatible = "gianfar";
>  			device_type = "mdio";
> -- 
> 2.1.0.27.g96db324
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150714/f91ff383/attachment.sig>
