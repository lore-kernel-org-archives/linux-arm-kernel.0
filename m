From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Dec 2015 15:08:27 +0530
Subject: [PATCH 2/6] ARM: DTS: da850: Use the new DT bindings for the eDMA3
In-Reply-To: <1449237210-16381-3-git-send-email-peter.ujfalusi@ti.com>
References: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
 <1449237210-16381-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <566FDF93.7050005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Friday 04 December 2015 07:23 PM, Peter Ujfalusi wrote:
> Switch to use the ti,edma3-tpcc and ti,edma3-tptc binding for the eDMA3.
> With the new bindings boards can customize and tweak the DMA channel
> priority to match their needs. With the new binding the memcpy is safe
> to be used since with the old binding it was not possible for a driver
> to know which channel is allowed to be used as non HW triggered channel.
> Using the new binding will allow us to reserve PaRAM slots to be used by
> the DSP which was not possible before and prevented the da850 boards to be
> moved to DT only.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/boot/dts/da850-enbw-cmc.dts |  5 +++++
>  arch/arm/boot/dts/da850-evm.dts      |  5 +++++
>  arch/arm/boot/dts/da850.dtsi         | 27 ++++++++++++++++++++++-----
>  3 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850-enbw-cmc.dts b/arch/arm/boot/dts/da850-enbw-cmc.dts
> index e750ab9086d5..ca9117624cf9 100644
> --- a/arch/arm/boot/dts/da850-enbw-cmc.dts
> +++ b/arch/arm/boot/dts/da850-enbw-cmc.dts
> @@ -28,3 +28,8 @@
>  		};
>  	};
>  };
> +
> +&edma0 {
> +	ti,edma-reserved-slot-ranges = /bits/ 16 <32 50>;
> +	ti,edma-memcpy-channels = /bits/ 16 <20 21>;
> +};
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index d807285a61cd..33467feb272a 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -243,3 +243,8 @@
>  	tx-num-evt = <32>;
>  	rx-num-evt = <32>;
>  };
> +
> +&edma0 {
> +	ti,edma-reserved-slot-ranges = /bits/ 16 <32 50>;
> +	ti,edma-memcpy-channels = /bits/ 16 <20 21>;

These correspond to PRU events. It is true that most likely they will
never be used for peripheral DMA and can be dedicated as memcpy
channels. However, since this is being encoded in DT, we need to be sure
that they will never be used for peripheral DMA on this board.

So, I would prefer if you do not reserve any channels for memcpy until
there is a real need/usecase for them. I know the board file has these
reserved but board file could be updated as you liked. With DT we need
to maintain backward compatibility. So I would rather do it when there
is an actual need for it.

In future, if/when we gain QDMA support, the QDMA channels could be used
for memcopy.

> +};
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index e73f5efb3aa3..9e46eb51a8da 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -151,11 +151,28 @@
>  
>  		};
>  		edma0: edma at 01c00000 {
> -			compatible = "ti,edma3";
> +			compatible = "ti,edma3-tpcc";
>  			/* eDMA3 CC0: 0x01c0 0000 - 0x01c0 7fff */
>  			reg =	<0x0 0x8000>;
> -			interrupts = <11 13 12>;
> -			#dma-cells = <1>;
> +			reg-names = "edma3_cc";
> +			interrupts = <11 12>;
> +			interrupt-names = "edma3_ccint", "edma3_ccerrint";
> +			#dma-cells = <2>;
> +
> +			ti,tptcs = <&edma0_tptc0 7>, <&edma0_tptc1 0>;
> +			ti,edma-memcpy-channels = /bits/ 16 <20 21>;

Same here. I would drop this.

Thanks,
Sekhar
