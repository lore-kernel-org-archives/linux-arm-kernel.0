From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Aug 2015 12:36:12 +0100
Subject: [PATCH v1 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <1439977055-1747-4-git-send-email-leo.yan@linaro.org>
References: <1439977055-1747-1-git-send-email-leo.yan@linaro.org>
 <1439977055-1747-4-git-send-email-leo.yan@linaro.org>
Message-ID: <55DC532C.3020005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/08/15 10:37, Leo Yan wrote:
> On Hi6220, below memory regions in DDR have specific purpose:
>
>    0x05e0,0000 - 0x05ef,ffff: For MCU firmware using at runtime;
>    0x0740,f000 - 0x0740,ffff: For MCU firmware's section;
>    0x06df,f000 - 0x06df,ffff: For mailbox message data.
>

Unless I am reading the DTS file completely wrong, I don't think the 
above memory regions are in DDR as per the memory node.

> This patch reserves these memory regions and add device node for
> mailbox in dts.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 20 +++++++++++++++++---
>   arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |  8 ++++++++
>   2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index e36a539..d5470d3 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -7,9 +7,6 @@
>
>   /dts-v1/;
>
> -/*Reserved 1MB memory for MCU*/
> -/memreserve/ 0x05e00000 0x00100000;
> -
>   #include "hi6220.dtsi"
>
>   / {
> @@ -28,4 +25,21 @@
>   		device_type = "memory";
>   		reg = <0x0 0x0 0x0 0x40000000>;
>   	};

I have no access to the spec, but I read this as 1GB RAM @0x0
Unless this entry is completely wrong, what your commit log claims is
incorrect. If this entry is wrong I wonder how is it booting with this
DT then.

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

So I don't see how can this be part of DDR ? Or at-least part of DDR
that's mapped by kernel ?

Regards,
Sudeep
