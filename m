From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Jul 2016 16:00:07 +0100
Subject: [PATCH 1/2] ARM: realview: Fix PBX-A9 cache description
In-Reply-To: <dbf8749c4af9aa5ffb85e961b7ae09ffeefa7f2a.1468583959.git.robin.murphy@arm.com>
References: <dbf8749c4af9aa5ffb85e961b7ae09ffeefa7f2a.1468583959.git.robin.murphy@arm.com>
Message-ID: <20160721150006.GE20559@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 01:19:12PM +0100, Robin Murphy wrote:
> Clearly QEMU is very permissive in how its PL310 model may be set up,
> but the real hardware turns out to be far more particular about things
> actually being correct. Fix up the DT description so that the real
> thing actually boots:
> 
> - The arm,data-latency and arm,tag-latency properties need 3 cells to
>   be valid, otherwise we end up retaining the default 8-cycle latencies
>   which leads pretty quickly to lockup.
> - The arm,dirty-latency property is only relevant to L210/L220, so get
>   rid of it.
> - The cache geometry override also leads to lockup and/or general
>   misbehaviour. Irritatingly, the manual doesn't state the actual PL310
>   configuration, but based on the boardfile code and poking registers
>   from the Boot Monitor, it would seem to be 8 sets of 16KB ways.
> 
> With that, we can successfully boot to enjoy the fun of mismatched FPUs...
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Prior to this patch, v4.7-rc6 would lock up immediately after:

[    0.000000] L2C OF: override cache size: 1048576 bytes (1024KB)
[    0.000000] L2C OF: override line size: 32 bytes
[    0.000000] L2C OF: override way size: 131072 bytes (128KB)
[    0.000000] L2C OF: override associativity: 8
[    0.000000] L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02080000
[    0.000000] L2C: DT/platform tries to modify or specify cache size
[    0.000000] L2C-310 errata 588369 769419 enabled
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 cache controller enabled, 8 ways, 1024 kB

With this patch, I make it all the way to userspace. I have a Debian Wheezy
armel image which seems happy on the board so far.

So FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm/boot/dts/arm-realview-pbx-a9.dts | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/arm-realview-pbx-a9.dts b/arch/arm/boot/dts/arm-realview-pbx-a9.dts
> index db808f92dd79..90d00b407f85 100644
> --- a/arch/arm/boot/dts/arm-realview-pbx-a9.dts
> +++ b/arch/arm/boot/dts/arm-realview-pbx-a9.dts
> @@ -70,13 +70,12 @@
>  		 * associativity as these may be erroneously set
>  		 * up by boot loader(s).
>  		 */
> -		cache-size = <1048576>; // 1MB
> -		cache-sets = <4096>;
> +		cache-size = <131072>; // 128KB
> +		cache-sets = <512>;
>  		cache-line-size = <32>;
>  		arm,parity-disable;
> -		arm,tag-latency = <1>;
> -		arm,data-latency = <1 1>;
> -		arm,dirty-latency = <1>;
> +		arm,tag-latency = <1 1 1>;
> +		arm,data-latency = <1 1 1>;
>  	};
>  
>  	scu: scu at 1f000000 {
> -- 
> 2.8.1.dirty
> 
