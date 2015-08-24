From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Aug 2015 11:00:54 +0100
Subject: [PATCH v2 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <1440039239-8772-4-git-send-email-leo.yan@linaro.org>
References: <1440039239-8772-1-git-send-email-leo.yan@linaro.org>
 <1440039239-8772-4-git-send-email-leo.yan@linaro.org>
Message-ID: <20150824100054.GB7139@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 03:53:59AM +0100, Leo Yan wrote:
> On Hi6220, below memory regions in DDR have specific purpose:
> 
>   0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
>   0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
>   0x06df,f000 - 0x06df,ffff: For mailbox message data.
> 
> This patch reserves these memory regions and add device node for
> mailbox in dts.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 20 +++++++++++++++++---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |  8 ++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index e36a539..d5470d3 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -7,9 +7,6 @@
>  
>  /dts-v1/;
>  
> -/*Reserved 1MB memory for MCU*/
> -/memreserve/ 0x05e00000 0x00100000;
> -
>  #include "hi6220.dtsi"
>  
>  / {
> @@ -28,4 +25,21 @@
>  		device_type = "memory";
>  		reg = <0x0 0x0 0x0 0x40000000>;
>  	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		mcu-buf at 05e00000 {
> +			no-map;
> +			reg = <0x0 0x05e00000 0x0 0x00100000>,	/* MCU firmware buffer */
> +			      <0x0 0x0740f000 0x0 0x00001000>;	/* MCU firmware section */
> +		};
> +
> +		mbox-buf at 06dff000 {
> +			no-map;
> +			reg = <0x0 0x06dff000 0x0 0x00001000>;	/* Mailbox message buf */
> +		};
> +	};
>  };

As mentioned in my other reply [1], you should fix your EFI memory map
instead. There is no reason for this at all.

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/365921.html
