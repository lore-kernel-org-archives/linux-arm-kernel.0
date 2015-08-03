From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 3 Aug 2015 12:23:53 +0100
Subject: [PATCH v6 6/8] arm64: dts: add SRAM, MHU mailbox and SCPI
 support on Juno
In-Reply-To: <1438364591-1144-7-git-send-email-sudeep.holla@arm.com>
References: <1438364591-1144-1-git-send-email-sudeep.holla@arm.com>
 <1438364591-1144-7-git-send-email-sudeep.holla@arm.com>
Message-ID: <20150803112353.GV20890@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 06:43:09PM +0100, Sudeep Holla wrote:
> This patch adds support for the MHU mailbox peripheral used on Juno by
> application processors to communicate with remote SCP handling most of
> the CPU/system power management. It also adds the SRAM reserving the
> shared memory and SCPI message protocol using that shared memory.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 54 ++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index e3ee96036eca..c624208edef6 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -17,6 +17,18 @@
>  		};
>  	};
>  
> +	mailbox: mhu at 2b1f0000 {
> +		compatible = "arm,mhu", "arm,primecell";
> +		reg = <0x0 0x2b1f0000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "mhu_lpri_rx",
> +				  "mhu_hpri_rx";
> +		#mbox-cells = <1>;
> +		clocks = <&soc_refclk100mhz>;
> +		clock-names = "apb_pclk";
> +	};
> +
>  	gic: interrupt-controller at 2c010000 {
>  		compatible = "arm,gic-400", "arm,cortex-a15-gic";
>  		reg = <0x0 0x2c010000 0 0x1000>,
> @@ -44,6 +56,48 @@
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
>  	};
>  
> +	sram: sram at 2e000000 {
> +		compatible = "arm,juno-sram-ns", "mmio-sram";
> +		reg = <0x0 0x2e000000 0x0 0x8000>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x0 0x2e000000 0x8000>;
> +
> +		cpu_scp_lpri: scp-shmem at 0 {
> +			compatible = "arm,juno-scp-shmem";
> +			reg = <0x0 0x200>;
> +		};
> +
> +		cpu_scp_hpri: scp-shmem at 200 {
> +			compatible = "arm,juno-scp-shmem";
> +			reg = <0x200 0x200>;
> +		};
> +	};
> +
> +	scpi {
> +		compatible = "arm,scpi";
> +		mboxes = <&mailbox 1>;
> +		shmem = <&cpu_scp_hpri>;
> +
> +		clocks {
> +			compatible = "arm,scpi-clocks";
> +
> +			scpi_dvfs: scpi_clocks at 0 {
> +				compatible = "arm,scpi-dvfs-clocks";
> +				#clock-cells = <1>;
> +				clock-indices = <0>, <1>, <2>;
> +				clock-output-names = "atlclk", "aplclk","gpuclk";
> +			};
> +			scpi_clk: scpi_clocks at 3 {
> +				compatible = "arm,scpi-variable-clocks";
> +				#clock-cells = <1>;
> +				clock-indices = <3>, <4>;
> +				clock-output-names = "pxlclk0", "pxlclk1";
> +			};
> +		};
> +	};
> +

Sorry for noticing this after the ACK, is there any reason why the scpi node is not inside
the juno-clocks.dtsi file?

Best regards,
Liviu

>  	/include/ "juno-clocks.dtsi"
>  
>  	dma at 7ff00000 {
> -- 
> 1.9.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
