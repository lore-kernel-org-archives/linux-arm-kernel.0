From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 2 Nov 2015 12:30:37 +0100
Subject: [PATCH 1/2] arm64: dts: exynos7: Add pmic s2mps15 device tree node
In-Reply-To: <1446458641-4447-1-git-send-email-alim.akhtar@samsung.com>
References: <1446458641-4447-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <5637495D.1080701@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

This patch looks mostly good to me, I just have two comments below:

On 11/02/2015 11:04 AM, Alim Akhtar wrote:
> This patch add pmic (s2mps15) node of espresso board,
> which includes addition of regulators and pmic-clk sub-nodes.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
> This patch should go in after driver side changes [1] lands.
> [1]-> https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg47736.html
> 
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts |  349 +++++++++++++++++++++++
>  1 file changed, 349 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index 838a3626dac1..8ce04a0ec928 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -53,6 +53,355 @@
>  	status = "okay";
>  };
>  
> +&hsi2c_4 {
> +	samsung,i2c-sda-delay = <100>;
> +	samsung,i2c-max-bus-freq = <200000>;
> +	status = "okay";
> +
> +	s2mps15_pmic at 66 {
> +		compatible = "samsung,s2mps15-pmic";
> +		reg = <0x66>;
> +		interrupts = <2 0>;

Maybe using IRQ_TYPE_NONE instead of 0?

> +		interrupt-parent = <&gpa0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq>;
> +		wakeup-source;
> +
> +		s2mps15_osc: clocks {
> +			compatible = "samsung,s2mps13-clk";
> +			#clock-cells = <1>;
> +			clock-output-names = "s2mps13_ap", "s2mps13_cp",
> +				"s2mps13_bt";
> +		};
> +
> +		regulators {
> +			ldo1_reg: LDO1 {
> +				regulator-name = "vdd_ldo1";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-always-on;

I see that all regulators are marked as regulator-always-on but that will
prevent the regulator subsystem to disable unused regulators. Can you please
double check which regulators should really be always on and which ones can
be disabled if are not used?

After those two changes:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
