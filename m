From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 9 Aug 2012 17:33:34 +0530
Subject: [PATCH V3] ARM: dt: tegra: ventana: add regulators
In-Reply-To: <1344017356-29352-1-git-send-email-swarren@wwwdotorg.org>
References: <1344017356-29352-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5023A716.50807@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 August 2012 11:39 PM, Stephen Warren wrote:
> From: Stephen Warren<swarren@nvidia.com>
>
> Ventana uses a TPS6586x regulator. Instantiate this, and hook up a
> couple of fixed GPIO-controlled regulators too.
>
> The data was chosen to match the PMIC HW defaults, with the following
> exception:
>
> ldo6: The HW default is 2.85v. The schematics are unlabelled. Internal
> research indicates that 1.8v is correct. Our downstream kernel also uses
> 1.8v.
>
> Portions based on work by Laxman Dewangan<ldewangan@nvidia.com>
>
> Signed-off-by: Stephen Warren<swarren@nvidia.com>
> ---
> v3:
> * Switch back to simple-bus compatible value for the /regulators node.
> * Added supply properties for all TPS6586x regulators.
> * Made SM* children of the new SYS regulator.
> * Removed ldo0 configuration, since it isn't used.
> v2:
> * Made all constraints match the HW defaults to avoid behavior changes,
>    with exceptions noted above.
> * Removed vin-supply properties from LDO nodes; the driver and binding
>    need to be updated to support specifying the parent regulators before
>    we can put these into DT.
> * Rename vdd_pnl regulator-name to match schematic.
> * Added vdd_bl regulator.
> * Fix typo in regulator at 3 reg property.
> * Use the enumerated-bus compatible value for the /regulators node.
> * Enhanced all regulator-name properties to list all signal names directly
>    derived from the regulator pins.
> * Added ldo_rtc regulator.
> ---

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
You can addd my ACK for harmony dts file.

>   arch/arm/boot/dts/tegra20-ventana.dts |  204 +++++++++++++++++++++++++++++++++
>   1 files changed, 204 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
> index be90544..4ec6b4c 100644
> --- a/arch/arm/boot/dts/tegra20-ventana.dts
> +++ b/arch/arm/boot/dts/tegra20-ventana.dts
> @@ -289,6 +289,156 @@
>   	i2c at 7000d000 {
>   		status = "okay";
>   		clock-frequency =<400000>;
> +
> +		pmic: tps6586x at 34 {
> +			compatible = "ti,tps6586x";
> +			reg =<0x34>;
> +			interrupts =<0 86 0x4>;

Should we say interrupt-controller also here?
> +
> +			sys-supply =<&vdd_5v0_reg>;
> +			vin-sm0-supply =<&sys_reg>;
> +			vin-sm1-supply =<&sys_reg>;
> +			vin-sm2-supply =<&sys_reg>;

This depends on two changes on tps6586x regulator which are not merged yet.


> +
> +	pmc {

Should say status OK?
