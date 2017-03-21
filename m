From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Mar 2017 08:41:17 +0100
Subject: [PATCH v2 1/5] dt-bindings: update device tree binding for
 Allwinner PRCM CCUs
In-Reply-To: <20170315172808.64011-2-icenowy@aosc.xyz>
References: <20170315172808.64011-1-icenowy@aosc.xyz>
 <20170315172808.64011-2-icenowy@aosc.xyz>
Message-ID: <20170321074117.vdfjynauuuv6fivp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 01:28:04AM +0800, Icenowy Zheng wrote:
> Many Allwinner SoCs after A31 have a CCU in PRCM block.
> 
> Give the ones on H3 and A64 compatible strings.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v2:
> - Add iosc for R_CCU's on H3/A64. (A31, A23 and A33 seem to have different
>   clock for mux 3 of ar100 clk. Investgations are needed for them.)
> 
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> index 68512aa398a9..4a4addff595d 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> @@ -7,9 +7,11 @@ Required properties :
>  		- "allwinner,sun8i-a23-ccu"
>  		- "allwinner,sun8i-a33-ccu"
>  		- "allwinner,sun8i-h3-ccu"
> +		- "allwinner,sun8i-h3-r-ccu"
>  		- "allwinner,sun8i-v3s-ccu"
>  		- "allwinner,sun9i-a80-ccu"
>  		- "allwinner,sun50i-a64-ccu"
> +		- "allwinner,sun50i-a64-r-ccu"
>  		- "allwinner,sun50i-h5-ccu"
>  
>  - reg: Must contain the registers base address and length
> @@ -20,7 +22,11 @@ Required properties :
>  - #clock-cells : must contain 1
>  - #reset-cells : must contain 1
>  
> -Example:
> +For the PRCM CCUs on H3/A64, one more clock is needed:
> +- "iosc": another frequency oscillator used for CPUS (usually at 32000Hz,
> +          not the same with losc)

This is called the internal oscillator in the datasheet, it would
probably make more sense to call it that way in the documentation too.

This oscillator seems to be clocked at 16MHz, so we should represent
it as such.

And I'm wondering, are you *sure* that it's fed directly from the
internal oscillator, or goes through the registers in the RTC, with
the 32 divider and 16 prescaler by default that makes it at roughly
the same rate (31.25kHz).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170321/7a3cdd48/attachment.sig>
