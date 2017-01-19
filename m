From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 19 Jan 2017 01:20:06 +0100
Subject: [PATCH v5] ARM64: dts: meson-gx: Add firmware reserved memory
 zones
In-Reply-To: <1484758245-9354-1-git-send-email-narmstrong@baylibre.com>
References: <1484758245-9354-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <2bdb6818-4620-53b1-112d-2d6a29e484d9@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 18.01.2017 um 17:50 schrieb Neil Armstrong:
> The Amlogic Meson GXBB/GXL/GXM secure monitor uses part of the memory space,
> this patch adds these reserved zones.
> 
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

I miss a Fixes: or Cc: here for the backport you desired. To have it
fixed back to my very introduction:

Fixes: 4f24eda8401f ("ARM64: dts: Prepare configs for Amlogic Meson GXBaby")

People backporting it would need to handle the meson-{gx => gxbb}.dtsi
transition for 4.9 down to 4.6, which seems fairly straightforward.

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

Both sub-nodes get a label that is unused, but reserved-memory itself
does not (my v4 remark). Intentional?

> +			reg = <0x0 0x0 0x0 0x1000000>;
> +			no-map;
> +		};
> +
> +		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
> +		secmon: secmon {

I note that this .dtsi further down has a node /firmware/secure-monitor
with label sm.
a) Is there any naming convention such as secmon_mem to adopt here to
avoid mixups with sm?
b) Should this secmon node be referenced in the secure-monitor node via
memory-node = <&secmon>; to model their connection, thereby giving the
label a use? Or should we maybe merge the two nodes by moving the
compatible string here?

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

> +			reg = <0x0 0x10000000 0x0 0x200000>;
> +			no-map;
> +		};
> +	};
> +
>  	cpus {
>  		#address-cells = <0x2>;
>  		#size-cells = <0x0>;

Anyway, objection resolved,

Reviewed-by: Andreas F?rber <afaerber@suse.de>

I don't expect breakage from these more confined additions, but I can
try to test tomorrow.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
