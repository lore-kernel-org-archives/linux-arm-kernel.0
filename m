From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 14:00:32 +0100
Subject: [PATCH 04/31] ARM: tegra: update DT files to add reset properties
In-Reply-To: <1384548866-13141-5-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-5-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129130031.GQ22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:53:59PM -0700, Stephen Warren wrote:
[...]
> @@ -135,8 +140,10 @@
>  		reg-shift = <2>;
>  		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>  		nvidia,dma-request-selector = <&apbdma 9>;
> -		status = "disabled";
>  		clocks = <&tegra_car TEGRA114_CLK_UARTB>;
> +		resets = <&tegra_car 7>;

This is confusing. For some reason that escapes me the tegra114-car.h
file defines TEGRA114_CLK_UARTB as 192. Other reset entries match the
numerical value of the TEGRA114_CLK_* define, which makes it easy to
double-check this.

But UARTB is indeed at bit 7, so this looks good.

Oh, I think perhaps it's caused by bit 7 being shared by both the UARTB
and the VFIR controllers for reset, but not for the clocks.

>  			reg = <0x70080300 0x100>;
>  			nvidia,ahub-cif-ids = <4 4>;
>  			clocks = <&tegra_car TEGRA114_CLK_I2S0>;

The clocks for these i2s devices are already listed in the ahub node. Is
that on purpose?

> @@ -110,6 +118,8 @@
>  			reg = <0x54080000 0x00040000>;
>  			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&tegra_car TEGRA30_CLK_VI>;
> +			resets = <&tegra_car 164>;

I think this needs to be 20.

> @@ -139,6 +155,9 @@
>  			clocks = <&tegra_car TEGRA30_CLK_GR3D
>  				  &tegra_car TEGRA30_CLK_GR3D2>;
>  			clock-names = "3d", "3d2";
> +			resets = <&tegra_car 24>,

For some reason bit 24 is missing from the register definition. Given
that this has worked before I suppose either the documentation is stale
or it's not necessary to take this module out of reset.

> +			 <&tegra_car 30>,  /* i2s0 */
> +			 <&tegra_car 11>,  /* i2s1 */
> +			 <&tegra_car 18>,  /* i2s2 */
> +			 <&tegra_car 101>, /* i2s3 */
> +			 <&tegra_car 102>, /* i2s4 */

Some comment for these as for Tegra20.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/b74c4a8e/attachment.sig>
