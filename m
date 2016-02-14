From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 14 Feb 2016 16:33:49 +0800
Subject: [PATCH v2] ARM: dts: vfxxx: Add iio_hwmon node for ADC
 temperature channel
In-Reply-To: <cd32f1664a04b38b8a025414d039bd015cb9a5ff.1455278754.git.maitysanchayan@gmail.com>
References: <cd32f1664a04b38b8a025414d039bd015cb9a5ff.1455278754.git.maitysanchayan@gmail.com>
Message-ID: <20160214083349.GR6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 05:53:00PM +0530, Sanchayan Maity wrote:
> Add iio_hwmon node to expose the temperature channel on Vybrid as
> hardware monitor device using the iio_hwmon driver.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
> 
> Hello,
> 
> The first version of the patch was send quite a while ago.
> https://lkml.org/lkml/2015/9/16/932
> 
> Shawn you had requested that hyphen rather than underscore should
> be used in node name. I looked into that.
> 
> The iio_hwmon driver calls hwmon_device register_with_groups inside
> hwmon.c and this
> http://lxr.free-electrons.com/source/drivers/hwmon/hwmon.c#L103
> 
> does not allow hyphen in hwmon name attribute. I was not aware of
> this but while trying to test the change, the device probe failed
> with EINVAL. I think we should stick to the existing use of the
> bindings or we need to change the hwmon code as well along with the
> existing device tree files and binding documentation.

I disagree.

If hyphen is invalid to be part of hwmon name attribute, the following
code in iio_hwmon_probe() is plain wrong, because hyphen is very valid
to be part of node names in device tree.

        if (dev->of_node && dev->of_node->name)
                name = dev->of_node->name;

Shawn

> 
> Changes since v1:
> 1. Expose ADC1 temperature channel as well
> 2. Move the entry outside of the aips1 bus node
> 
> Best Regards,
> Sanchayan Maity.
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index a5f07e3..8ed8e47 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -673,5 +673,10 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		iio_hwmon {
> +			compatible = "iio-hwmon";
> +			io-channels = <&adc0 16>, <&adc1 16>;
> +		};
>  	};
>  };
> -- 
> 2.7.1
> 
> 
