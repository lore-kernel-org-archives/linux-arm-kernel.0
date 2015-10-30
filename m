From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Fri, 30 Oct 2015 18:22:58 +0000
Subject: [PATCH v3] arm64: dts: Added syscon-reboot node for FSL's LS2085A
 SoC
In-Reply-To: <1446224892-29407-1-git-send-email-German.Rivera@freescale.com>
References: <1446224892-29407-1-git-send-email-German.Rivera@freescale.com>
Message-ID: <CY1PR0301MB0748FFB9490DB247C389330C872F0@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: J. German Rivera [mailto:German.Rivera at freescale.com]
> Sent: Friday, October 30, 2015 12:08 PM
> To: robh+dt at kernel.org; mark.rutland at arm.com; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Cc: Sharma Bhupesh-B45370; Yoder Stuart-B08248; Li Yang-Leo-R58472; Rivera Jose-B46482
> Subject: [PATCH v3] arm64: dts: Added syscon-reboot node for FSL's LS2085A SoC
> 
> Added sys-reboot node to the FSL's LS2085A SoC DT to leverage
> the ARM-generic reboot mechanism for this SoC. This mechanism
> is enabled through CONFIG_POWER_RESET_SYSCON.
> 
> Signed-off-by: J. German Rivera <German.Rivera@freescale.com>
> ---
> CHANGE HISTORY:
> 
> Changes in v2:
> - Addressed comment form Stuart Yoder:
>   * Removed "@<address>" from reboot node
> 
> Changes in v3:
> - Addressed comment form Stuart Yoder:
>   * Expose only the reset register
> 
>  arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> index e281ceb..5e3d894 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> @@ -131,6 +131,18 @@
>  		interrupts = <1 9 0x4>;
>  	};
> 
> +	rstcr: rstcr at 1E60000 {
> +		compatible = "syscon";
> +		reg = <0x0 0x1E60000 0x0 0x4>;
> +	};
> +
> +	reboot {
> +		compatible ="syscon-reboot";
> +		regmap = <&rstcr>;
> +		offset = <0x0>;
> +		mask = <0x2>;
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <1 13 0x8>, /* Physical Secure PPI, active-low */

German, the other thing I just noticed that I had mentioned on 
v1 of the patch was that the device tree has been renamed, so
fsl-ls2085a.dtsi no longer exists.

You need to rebase this on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git

branch: for-next

Thanks,
Stuart
