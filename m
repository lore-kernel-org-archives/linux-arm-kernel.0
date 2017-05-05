From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 5 May 2017 11:24:26 +0800
Subject: [linux-sunxi] [PATCH v6 03/13] dt-bindings: add bindings for DE2
 on V3s SoC
In-Reply-To: <20170504114858.9008-4-icenowy@aosc.io>
References: <20170504114858.9008-1-icenowy@aosc.io>
 <20170504114858.9008-4-icenowy@aosc.io>
Message-ID: <CAGb2v660QfMGrP=HuJQ4oVbCaU_gtNzogo-pbK7WQ2UNiQ7BYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 7:48 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner V3s SoC have a display engine which have a different pipeline
> with older SoCs.
>
> Add document for it (new compatibles and the new "mixer" part).
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v4:
> - Removed the refactor at TCON chapter.
> Changes in v3:
> - Remove the description of having a BE directly as allwinner,pipeline.
>
>  .../bindings/display/sunxi/sun4i-drm.txt           | 29 ++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 7acdbf14ae1c..33452884b96e 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -41,6 +41,7 @@ Required properties:
>     * allwinner,sun6i-a31-tcon
>     * allwinner,sun6i-a31s-tcon
>     * allwinner,sun8i-a33-tcon
> +   * allwinner,sun8i-v3s-tcon
>   - reg: base address and size of memory-mapped region
>   - interrupts: interrupt associated to this IP
>   - clocks: phandles to the clocks feeding the TCON. Three are needed:
> @@ -62,7 +63,7 @@ Required properties:
>    second the block connected to the TCON channel 1 (usually the TV
>    encoder)
>
> -On SoCs other than the A33, there is one more clock required:
> +On SoCs other than the A33 and V3s, there is one more clock required:
>     - 'tcon-ch1': The clock driving the TCON channel 1
>
>  DRC
> @@ -148,6 +149,26 @@ Required properties:
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

You probably mean "mixer" here.

> +  - clock-names: the clock names mentioned above
> +  - resets: phandles to the reset controllers driving the backend

And here.

> +
> +- ports: A ports node with endpoint definitions as defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
> +  first port should be the input endpoints, the second one the output
> +
>
>  Display Engine Pipeline
>  -----------------------
> @@ -162,9 +183,13 @@ Required properties:
>      * allwinner,sun6i-a31-display-engine
>      * allwinner,sun6i-a31s-display-engine
>      * allwinner,sun8i-a33-display-engine
> +    * allwinner,sun8i-v3s-display-engine
>
>    - allwinner,pipelines: list of phandle to the display engine
> -    frontends available.
> +    pipeline entry point. For SoCs with original DE (currently
> +    all SoCs supported by display engine except V3s), this
> +    phandle should be a display frontend; for SoCs with DE2,
> +    this phandle should be a mixer.

You could simplify this to "list of phandles to the display
engine frontends (DE 1.0) or mixers (DE 2.0) available".

Regards
ChenYu

>
>  Example:
>
> --
> 2.12.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
