From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 10:56:49 +0100
Subject: [PATCH v2 3/8] dt-bindings: add bindings for DE2 on V3s SoC
In-Reply-To: <20170316204748.8596-4-icenowy@aosc.xyz>
References: <20170316204748.8596-1-icenowy@aosc.xyz>
 <20170316204748.8596-4-icenowy@aosc.xyz>
Message-ID: <20170320095649.pnokqzv3akubkklm@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 04:47:43AM +0800, Icenowy Zheng wrote:
> Allwinner V3s SoC have a display engine which have a different pipeline
> with older SoCs.
> 
> Add document for it (new compatibles and the new "mixer" part).
> 
> The paragraph of TCON is also refactored, for furtherly add TCONs in
> A83T/H3/A64/H5 that have only a channel 1 (used for HDMI or TV Encoder).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt           | 37 +++++++++++++++++++---
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index b82c00449468..2c293247c41d 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -31,11 +31,11 @@ Required properties:
>     * allwinner,sun6i-a31-tcon
>     * allwinner,sun6i-a31s-tcon
>     * allwinner,sun8i-a33-tcon
> +   * allwinner,sun8i-v3s-tcon
>   - reg: base address and size of memory-mapped region
>   - interrupts: interrupt associated to this IP
> - - clocks: phandles to the clocks feeding the TCON. Three are needed:
> + - clocks: phandles to the clocks feeding the TCON
>     - 'ahb': the interface clocks
> -   - 'tcon-ch0': The clock driving the TCON channel 0
>   - resets: phandles to the reset controllers driving the encoder
>     - "lcd": the reset line for the TCON channel 0
>  
> @@ -52,7 +52,12 @@ Required properties:
>    second the block connected to the TCON channel 1 (usually the TV
>    encoder)
>  
> -On SoCs other than the A33, there is one more clock required:
> +On TCONs that have a channel 0 (currently all TCONs supported), there
> +is one more clock required:
> +   - 'tcon-ch0': The clock driving the TCON channel 0
> +
> +On TCONs that have a channel 1 (currently all TCONs except the ones in
> +A33 and V3s), there is one more clock required:
>     - 'tcon-ch1': The clock driving the TCON channel 1
>  
>  DRC
> @@ -137,6 +142,26 @@ Required properties:
>    Documentation/devicetree/bindings/media/video-interfaces.txt. The
>    first port should be the input endpoints, the second one the outputs
>  
> +Display Engine 2.0 Mixer
> +------------------------
> +
> +The DE2 mixer have many functionalities, currently only layer blending is
> +supported.
> +
> +Required properties:
> +  - compatible: value must be one of:
> +    * allwinner,sun8i-v3s-de2-mixer
> +  - reg: base address and size of the memory-mapped region.
> +  - clocks: phandles to the clocks feeding the frontend and backend
> +    * bus: the backend interface clock
> +    * ram: the backend DRAM clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandles to the reset controllers driving the backend
> +
> +- ports: A ports node with endpoint definitions as defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
> +  first port should be the input endpoints, the second one the output
> +
>  
>  Display Engine Pipeline
>  -----------------------
> @@ -151,9 +176,13 @@ Required properties:
>      * allwinner,sun6i-a31-display-engine
>      * allwinner,sun6i-a31s-display-engine
>      * allwinner,sun8i-a33-display-engine
> +    * allwinner,sun8i-v3s-display-engine
>  
>    - allwinner,pipelines: list of phandle to the display engine
> -    frontends available.
> +    pipeline entry point. For SoCs with original DE (currently
> +    all SoCs supported by display engine except V3s), this
> +    phandle should be a display frontend or backend; for SoCs
> +    with DE2, this phandle should be a mixer.

In the old ones, this should never be the backend.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/c30234a5/attachment-0001.sig>
