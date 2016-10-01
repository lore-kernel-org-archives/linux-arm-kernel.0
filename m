From: mark.rutland@arm.com (Mark Rutland)
Date: Sat, 1 Oct 2016 19:17:11 +0100
Subject: [PATCH] ARM: dts: rockchip: Reserve unusable memory region on
 rk3066
In-Reply-To: <20161001140939.GA31220@vaio-ubuntu>
References: <20161001140939.GA31220@vaio-ubuntu>
Message-ID: <20161001181711.GB17554@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 01, 2016 at 04:09:39PM +0200, =?UTF-8?q?Pawe=C5=82=20Jarosz?= wrote:
> For some reason accessing memory region above 0xfe000000 freezes
> system on rk3066. There is similiar bug on later rockchip soc (rk3288)
> solved same way.
> 
> Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
> ---
>  arch/arm/boot/dts/rk3066a.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
> index 0d0dae3..44c8956 100644
> --- a/arch/arm/boot/dts/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rk3066a.dtsi
> @@ -93,6 +93,19 @@
>  		};
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		/*
> +		 * The rk3066 cannot use the memory area above 0x9F000000
> +		 * for some unknown reason.
> +		 */
> +		unusable at 9F000000 {
> +			reg = <0x9F000000 0x1000000>;
> +		};

I don't think this is a sane workaround, but it is at best difficult to tell,
given there's no reason given for why this memory is unusable.

For instance, if bus accesses to this address hang, then this patch only makes
the hand less likely, since the kernel will still map the region (and therefore
the CPU can perform speculative accesses).

Are issues with this memory consistently seen in practice?

Can you enable CONFIG_MEMTEST and pass 'memtest' to the kernel, to determine if
the memory is returning erroneous values?

Thanks,
Mark.
