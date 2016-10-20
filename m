From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 20 Oct 2016 15:45:34 +0200
Subject: [PATCH] ARM: dts: rockchip: add i2c-bus subnode to edp
In-Reply-To: <1476950845-28242-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1476950845-28242-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <7604646.6yosK0XMNL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 20. Oktober 2016, 10:07:25 schrieb Tomeu Vizoso:
> Add an empty 'i2c-bus' subnode to the edp node just so that the I2C core
> doesn't attemp to parse the 'ports' subnode as containing i2c devices.
> 
> This is to avoid spurious failure messages such as:
> 
> i2c i2c-6: of_i2c: modalias failure on /dp at ff970000/ports

On the one hand, the edp really has an i2c bus - with its only client the EDID 
listening at 0x50 (and maybe 0x30).

On the other hand, adding an empty bus to the (implementation independent) 
devicetree just to make the Linux i2c subsystem happy sounds heavily like a 
implementation-specific hack, as the edp i2c bus doesn't leak into the outside 
world otherwise.

I guess this empty i2c bus not being part of the binding document points 
heavily into the implementation-specific corner :-) .

My short search on other patches touching this didn't reveal anything but 
maybe this was already discussed somewhere and found to be ok?


Another option could be to just make of_i2c_register_device silent if 
of_modalias_node returns -ENODEV?


Heiko

> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Randy Li <randy.li@rock-chips.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 2f814ffeb605..94f4b7eecca2 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -1075,6 +1075,11 @@
>  				};
>  			};
>  		};
> +
> +		i2c-bus {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
>  	};
> 
>  	hdmi: hdmi at ff980000 {
