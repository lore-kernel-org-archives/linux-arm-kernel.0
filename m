From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Tue, 15 May 2018 10:29:39 +0800
Subject: [PATCH] ARM: dts: chromecast: override bad bootloader memory info
In-Reply-To: <20180514215645.17592-2-tommyhebb@gmail.com>
References: <20180514215645.17592-2-tommyhebb@gmail.com>
Message-ID: <20180515102939.3ab8797c@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 14 May 2018 17:56:45 -0400 Thomas Hebb  wrote:

> On the Chromecast, the bootloader provides us with an ATAG_MEM of
> start=0x01000000 and size=0x3eff8000. This is clearly incorrect, as the
> range given encompasses nearly a GiB but the Chromecast only has 512MiB
> of RAM! Additionally, this causes the kernel to be decompressed at
> 0x00008000, below the claimed beginning of RAM, and so the boot fails.
> 
> Since the existing ATAG parsing code runs before the kernel is even
> decompressed and irrevocably patches the device tree, don't even try

This means you enabled ARM_ATAG_DTB_COMPAT. could we disable it instead?
The ATAG is useless when we provide dtb. And IIRC, the ATAG is provided due
to legacy history code.

Thanks

> to bypass it. Instead, use the "linux,usable-memory" property instead
> of the "reg" property to define the real range. The ATAG code only
> overwrites reg, but linux,usable-memory is checked first in the OF
> driver, so the fact that reg gets changed makes no difference.
> 
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> ---
>  arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> index 20f31cdeaf38..54221f55bfa2 100644
> --- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> +++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> @@ -52,7 +52,17 @@
>  
>  	memory at 0 {
>  		device_type = "memory";
> -		reg = <0x00000000 0x20000000>; /* 512 MB */
> +
> +		/*
> +		 * We're using "linux,usable-memory" instead of "reg" here
> +		 * because the (signed and encrypted) bootloader that shipped
> +		 * with this device provides an incorrect memory range in
> +		 * ATAG_MEM. Linux helpfully overrides the "reg" property with
> +		 * data from the ATAG, so we can't specify the proper range
> +		 * normally. Fortunately, this alternate property is checked
> +		 * first by the OF driver, so we can (ab)use it instead.
> +		 */
> +		linux,usable-memory = <0x00000000 0x20000000>; /* 512 MB */
>  	};
>  
>  	leds {
