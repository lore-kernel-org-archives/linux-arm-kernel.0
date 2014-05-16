From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 17 May 2014 01:16:50 +0200
Subject: [PATCH v4 6/8] ARM: dts: Exynos: add cpu nodes, opp and cpu clock
 configuration data
In-Reply-To: <1400029876-5830-7-git-send-email-thomas.ab@samsung.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-7-git-send-email-thomas.ab@samsung.com>
Message-ID: <53769C62.4060900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Please see my comments inline.

On 14.05.2014 03:11, Thomas Abraham wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> For all Exynos based platforms, add CPU nodes, operating points and cpu
> clock data for migrating from Exynos specific cpufreq driver to using
> generic cpufreq-cpu0 driver.
> 
> Cc: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts         |    6 +++
>  arch/arm/boot/dts/exynos4210-trats.dts          |    6 +++
>  arch/arm/boot/dts/exynos4210-universal_c210.dts |    6 +++
>  arch/arm/boot/dts/exynos4210.dtsi               |   35 +++++++++++++++++++
>  arch/arm/boot/dts/exynos4212.dtsi               |   18 ++++++++++
>  arch/arm/boot/dts/exynos4412-odroidx.dts        |    6 +++
>  arch/arm/boot/dts/exynos4412-origen.dts         |    6 +++
>  arch/arm/boot/dts/exynos4412-trats2.dts         |    6 +++
>  arch/arm/boot/dts/exynos4412.dtsi               |   31 +++++++++++++++++
>  arch/arm/boot/dts/exynos4x12.dtsi               |   36 ++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250-arndale.dts        |    6 +++
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi   |    6 +++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts       |    6 +++
>  arch/arm/boot/dts/exynos5250.dtsi               |   41 +++++++++++++++++++++++
>  14 files changed, 215 insertions(+), 0 deletions(-)

[snip]

> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index cacf614..22b967d 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -36,6 +36,33 @@
>  		reg = <0x10023CA0 0x20>;
>  	};
>  
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu at 0 {

style: Please add blank line between last property and first node.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;

This is not the right value. The bottom 24-bits of MPIDR register on
Exynos4210 are 0x900 and 0x901 for CPU0 and CPU1 respectively.

Of course this won't work before fixing the GIC driver to not rely on
wrong assumptions, but I have already posted patches [1] and need to
address comments.

[1] http://thread.gmane.org/gmane.linux.kernel.samsung-soc/29573

> +			clocks = <&clock CLK_ARM_CLK>;
> +			clock-names = "cpu";

[snip]

> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 15d3c0a..85005d1 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -22,6 +22,37 @@
>  / {
>  	compatible = "samsung,exynos4412", "samsung,exynos4";
>  
> +	cpus {
> +		cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <2>;

Same here. On Exynos4x12, the MPIDR values for CPUs are 0xa00, 0xa01,
0xa02 and 0xa03 for CPU0, CPU1, CPU2 and CPU3 respectively.

> +		};
> +		cpu at 3 {

style: Please keep a single blank line of spacing between nodes.

Otherwise looks good.

Best regards,
Tomasz
