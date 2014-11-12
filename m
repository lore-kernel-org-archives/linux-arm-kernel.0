From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 12 Nov 2014 14:53:49 +0200
Subject: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for
 devconf1 register
In-Reply-To: <1415051968-4878-5-git-send-email-marek@goldelico.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-5-git-send-email-marek@goldelico.com>
Message-ID: <5463585D.9070209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/11/14 23:59, Marek Belisko wrote:
> gta04 board need for tvout enabled 2 bits in devconf1 register (tvbypass and acbias).
> Add single pinmux entry and enable it.
> 
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index e4d05f0..a456d37 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -118,6 +118,17 @@
>  			};
>  		};
>  	};
> +
> +	/* pinmux for devconf1 */
> +	control_devconf1: pinmux at 480022d8 {
> +		compatible = "pinctrl-single";
> +		reg = <0x480022d8 4>;	/* single register */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-single,bit-per-mux;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xfc0bd5>;
> +	};
>  };
>  
>  &omap3_pmx_core {
> @@ -497,3 +508,14 @@
>  		};
>  	};
>  };
> +
> +&control_devconf1 {
> +	pinctrl-name = "default";
> +	pinctrl-0 = < &tv_acbias_pins>;
> +
> +	tv_acbias_pins: pinmux_tv_acbias_pins {
> +		pinctrl-single,bits = <
> +			0 0x40800 0x40800

I think it would be good to have a comment in the .dts above, mentioning
that TVOUTBYPASS and TVACEN bits are being set.

> +		>;
> +	};
> +};
> 

OMAP3630 seems to have CONTROL_AVDAC1 and CONTROL_AVDAC2 registers. Did
you check if the SoC you use have those? It looks like they need
configuration also, if the exist.

So, I don't think tvbypass and acbias are really pinmux stuff, but it
does seem like an easy way to handle the devconf1 register, and I don't
see any issues with the setting being fixed.

However, devconf1 register seems to have bits for many devices,
including mcbsp, mmc, and even some "Force MPU writes to be nonposted" bit.

And, with a quick grep, I see CONTROL_DEVCONF1 touched in multiple
places in the kernel. I wonder if adding a pinmux entry for it could
cause some rather odd problems.

Tony, any idea about this? How should CONTROL_DEVCONFx registers be
accessed?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/22055e70/attachment.sig>
