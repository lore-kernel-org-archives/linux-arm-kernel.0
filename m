From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 20 May 2015 12:08:31 +0200
Subject: [RFC 7/7] ARM: dts: sun9i: Add secure SRAM node used for MCPM
 SMP hotplug
In-Reply-To: <1431583811-25780-8-git-send-email-wens@csie.org>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
 <1431583811-25780-8-git-send-email-wens@csie.org>
Message-ID: <20150520100831.GE4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 02:10:11PM +0800, Chen-Yu Tsai wrote:
> The A80 stores some magic flags in a portion of the secure SRAM. The
> BROM jumps directly to the software entry point set by the SMP code
> if the flags are set. This is required for CPU0 hotplugging.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun9i-a80.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> index 1507bd2a88f0..0695215634d4 100644
> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> @@ -366,6 +366,26 @@
>  		 */
>  		ranges = <0 0 0 0x20000000>;
>  
> +		sram_b: sram at 00020000 {
> +			/* 256 KiB secure SRAM at 0x20000 */
> +			compatible = "mmio-sram";
> +			reg = <0x00020000 0x40000>;
> +

We should probably add a property to that SRAM to tell the driver not
to access it if we're not booted in secure mode.

Otherwise, bad things might happen.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150520/f4294a49/attachment.sig>
