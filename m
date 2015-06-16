From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 16 Jun 2015 10:16:19 +0100
Subject: [PATCH v2] ARM: tegra124: pmu support
In-Reply-To: <1434393968-1105-1-git-send-email-khuey@kylehuey.com>
References: <1434393968-1105-1-git-send-email-khuey@kylehuey.com>
Message-ID: <20150616091619.GA17817@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 07:46:08PM +0100, Kyle Huey wrote:
> This patch modifies the device tree for tegra124 based devices to enable the Cortex A15 PMU.  The interrupt numbers are taken from NVIDIA TRM DP-06905-001_v03p.  This patch was tested on a Jetson TK1.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
> index 4be06c6..d966d4e 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -906,16 +906,24 @@
>  
>  		cpu at 3 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <3>;
>  		};
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a15-pmu";
> +		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +	};

As these are SPIs, you should fill in the interrupt-affinity property
(see Documentation/devicetree/bindings/arm/pmu.txt). That'll avoid
potential problems with CPU renumbering, and prevent the kernel from
complaining at boot time.

Otherwise, this looks fine.

Thanks,
Mark.
