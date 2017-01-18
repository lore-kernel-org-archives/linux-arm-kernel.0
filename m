From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 15:04:16 -0800
Subject: [PATCH v5] ARM64: dts: meson-gx: Add firmware reserved memory
 zones
In-Reply-To: <1484758245-9354-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Wed, 18 Jan 2017 17:50:45 +0100")
References: <1484758245-9354-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2fukgx95b.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic Meson GXBB/GXL/GXM secure monitor uses part of the memory space,
> this patch adds these reserved zones.

Applying to v4.10/fixes for broader testing.

Will wait for ack from Andreas befores submitting to arm-soc fixes.

Kevin

> Without such reserved memory zones, running the following stress command :
> $ stress-ng --vm 16 --vm-bytes 128M --timeout 10s
> multiple times:
>
> Could lead to the following kernel crashes :
> [   46.937975] Bad mode in Error handler detected on CPU1, code 0xbf000000 -- SError
> ...
> [   47.058536] Internal error: Attempting to execute userspace memory: 8600000f [#3] PREEMPT SMP
> ...
> Instead of the OOM killer.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> Changes since v4 at [5]:
> - Move start of ddr memory to reserved-memory node
> - Drop memory node move
> - Fix typo in sizes
>
> Changes since resent v2 at [4]:
> - Fix invalid comment of useable memory attributes
>
> Changes since original v2 at [3]:
> - Typo in commit 2GiB -> 1GiB, 4GiB -> 2GiB
>
> Changes since v2 at [2]:
> - Moved all memory node out of dtsi
> - Added comment about useable memory
> - Fixed comment about secmon reserved zone
>
> Changes since v1 at [1] :
> - Renamed reg into linux,usable-memory to ovveride u-boot memory
> - only kept secmon memory zone
>
> [1] http://lkml.kernel.org/r/20161212101801.28491-1-narmstrong at baylibre.com
> [2] http://lkml.kernel.org/r/1483105232-6242-1-git-send-email-narmstrong at baylibre.com
> [3] http://lkml.kernel.org/r/1484128128-22454-1-git-send-email-narmstrong at baylibre.com
> [4] http://lkml.kernel.org/r/1484128540-22662-1-git-send-email-narmstrong at baylibre.com
> [5] http://lkml.kernel.org/r/1484129414-23325-1-git-send-email-narmstrong at baylibre.com
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index eada0b5..63d52b7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -55,6 +55,24 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 16 MiB reserved for Hardware ROM Firmware */
> +		hwrom: hwrom {
> +			reg = <0x0 0x0 0x0 0x1000000>;
> +			no-map;
> +		};
> +
> +		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
> +		secmon: secmon {
> +			reg = <0x0 0x10000000 0x0 0x200000>;
> +			no-map;
> +		};
> +	};
> +
>  	cpus {
>  		#address-cells = <0x2>;
>  		#size-cells = <0x0>;
