From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 17 Jul 2015 10:59:47 +0200
Subject: [RESEND PATCH v3] ARM: tegra124: pmu support
In-Reply-To: <1436808945-14524-1-git-send-email-khuey@kylehuey.com>
References: <1436808945-14524-1-git-send-email-khuey@kylehuey.com>
Message-ID: <20150717085946.GB3057@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 10:35:45AM -0700, Kyle Huey wrote:
> This patch modifies the device tree for tegra124 based devices to enable
> the Cortex A15 PMU.  The interrupt numbers are taken from NVIDIA TRM
> DP-06905-001_v03p.  This patch was tested on a Jetson TK1.
> 
> Updated for proper ordering and to add interrupt-affinity values.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Is there any way to test this? What are the effects of adding this? Does
it enable using perf for profiling?

> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
> index 13cc7ca..de07d7e 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -918,31 +918,40 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		cpu at 0 {
> +		A15_0: cpu at 0 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
>  		};
>  
> -		cpu at 1 {
> +		A15_1: cpu at 1 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <1>;
>  		};
>  
> -		cpu at 2 {
> +		A15_2: cpu at 2 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <2>;
>  		};
>  
> -		cpu at 3 {
> +		A15_3: cpu at 3 {
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
> +		interrupt-affinity = <&A15_0>, <&A15_1>, <&A15_2>, <&A15_3>;

These labels look somewhat artificial to me, perhaps we could do
something like the following instead?

	interrupt-affinity = <&{/cpus/cpu@0}>, ...;

That's slightly more obvious and avoids the need to "invent" labels for
the CPUs.

No need to respin, I can fix that up when applying if nobody objects to
using the alternative notation.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/ac176d0d/attachment.sig>
