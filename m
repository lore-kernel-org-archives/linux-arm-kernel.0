From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 20 Oct 2016 09:19:13 +0200
Subject: [PATCH 3/3] ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
In-Reply-To: <1476908324-12313-3-git-send-email-dinguyen@opensource.altera.com>
References: <1476908324-12313-1-git-send-email-dinguyen@opensource.altera.com>
 <1476908324-12313-3-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20161020071913.rlka3or4c7fzjpyv@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed, Oct 19, 2016 at 03:18:44PM -0500, dinguyen at opensource.altera.com wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> Enable the QSPI node and add the flash chip.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |   33 +++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> index 02e22f5..2f75e0f 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> @@ -175,6 +175,39 @@
>  	status = "okay";
>  };
>  
> +&qspi {
> +	status = "okay";
> +
> +	flash: flash at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "n25q256a";
> +		reg = <0>;
> +		spi-max-frequency = <100000000>;
> +
> +		m25p,fast-read;
> +		cdns,page-size = <256>;
> +		cdns,block-size = <16>;
> +		cdns,read-delay = <4>;
> +		cdns,tshsl-ns = <50>;
> +		cdns,tsd2d-ns = <50>;
> +		cdns,tchsh-ns = <4>;
> +		cdns,tslch-ns = <4>;
> +
> +		partition at qspi-boot {
> +			/* 8MB for raw data. */
> +			label = "Flash 0 Raw Data";
> +			reg = <0x0 0x800000>;
> +		};
> +
> +		partition at qspi-rootfs {
> +			/* 120MB for jffs2 data. */
> +			label = "Flash 0 jffs2 Filesystem";
> +			reg = <0x800000 0x7800000>;
> +		};
> +	};
> +};
> +

What is the current preferred way of handling the partitions?
This doesn't fit my Sockit configuration for example. So I would always
have to patch the devicetree.

On the Socrates I didn't specify the partitions, because I did not
want to force a specific configuration.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
