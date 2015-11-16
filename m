From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Nov 2015 14:40:34 +0000
Subject: [PATCH 2/2] dts/ls2080a: Update DTSI to add support of SP805 WDT
In-Reply-To: <1447683883-6600-3-git-send-email-bhupesh.sharma@freescale.com>
References: <1447683883-6600-1-git-send-email-bhupesh.sharma@freescale.com>
 <1447683883-6600-3-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <20151116144034.GL20696@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 07:54:43PM +0530, Bhupesh Sharma wrote:
> This patch updates the LS2080a DTSI (DTS Include) file to add
> support for eight SP805 Watchdog units which can be used to
> reset the eight Cortex-A57 cores available on LS2080A.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   64 ++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index e81cd48..15637ab 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -193,6 +193,70 @@
>  			interrupts = <0 32 0x4>; /* Level high type */
>  		};
>  
> +		cluster1_core0_watchdog: wdt at c000000 {
> +			compatible = "arm,sp805-wdt", "arm,primecell";
> +			reg = <0x0 0xc000000 0x0 0x1000>;
> +			interrupts = <1 12 0x8>; /* PPI, Level low type */
> +			clocks = <&clockgen 4 3>;
> +			clock-names = "apb_pclk";
> +		};
> +
> +		cluster1_core1_watchdog: wdt at c010000 {
> +			compatible = "arm,sp805-wdt", "arm,primecell";
> +			reg = <0x0 0xc010000 0x0 0x1000>;
> +			interrupts = <1 12 0x8>; /* PPI, Level low type */
> +			clocks = <&clockgen 4 3>;
> +			clock-names = "apb_pclk";
> +		};

How does this pseudo-banking work?

For one thing as far as I can see, the SP805 driver can't handle PPIs in
mainline.

Additionally, the kernel has no idea which CPU each of these is
associated with, and we effectively need to deal with shared PPIs in
order to use this appropriately in the kernel (if each WDT's interrupt
is wired to a particular core).

Thanks,
Mark.
