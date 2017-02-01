From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 09:57:19 -0600
Subject: [PATCH 1/4] Documentation/devicetree/bindings/video/bridge:
 megachips-stdpxxxx-ge-b850v3-fw
In-Reply-To: <0d72b822a603b729fa9fa1103daa336430cd2d1a.1485611969.git.peter.senna@collabora.com>
References: <cover.1485611969.git.peter.senna@collabora.com>
 <0d72b822a603b729fa9fa1103daa336430cd2d1a.1485611969.git.peter.senna@collabora.com>
Message-ID: <20170201155719.ng7otnioec7k6nvk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2017 at 03:21:30PM +0100, Peter Senna Tschudin wrote:
> Devicetree binding documentation for the second video output
> of the GE B850v3:
>    STDP4028-ge-b850v3-fw bridges (LVDS-DP)
>    STDP2690-ge-b850v3-fw bridges (DP-DP++)
> 
> Added entry for MegaChips at:
>  Documentation/devicetree/bindings/vendor-prefixes.txt

Your subject is so long I can't see anything useful. Begin with:

dt-bindings: display: ...

> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Martyn Welch <martyn.welch@collabora.co.uk>
> Cc: Martin Donnelly <martin.donnelly@ge.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  .../bridge/megachips-stdpxxxx-ge-b850v3-fw.txt     | 92 ++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 1ef148d..b4c2f5c 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -175,6 +175,7 @@ maxim	Maxim Integrated Products
>  mcube	mCube
>  meas	Measurement Specialties
>  mediatek	MediaTek Inc.
> +megachips	MegaChips
>  melexis	Melexis N.V.
>  melfas	MELFAS Inc.
>  memsic	MEMSIC Inc.
> diff --git a/Documentation/devicetree/bindings/video/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt b/Documentation/devicetree/bindings/video/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
> new file mode 100644
> index 0000000..471db27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt

bindings/video/ is gone (though a few things snuck in). This goes in 
bindings/display/bridge/.

> @@ -0,0 +1,92 @@
> +Drivers for the second video output of the GE B850v3:
> +   STDP4028-ge-b850v3-fw bridges (LVDS-DP)
> +   STDP2690-ge-b850v3-fw bridges (DP-DP++)
> +
> +The video processing pipeline on the second output on the GE B850v3:
> +
> +   Host -> LVDS|--(STDP4028)--|DP -> DP|--(STDP2690)--|DP++ -> Video output
> +
> +Each bridge has a dedicated flash containing firmware for supporting the custom
> +design. The result is that, in this design, neither the STDP4028 nor the
> +STDP2690 behave as the stock bridges would. The compatible strings include the
> +suffix "-ge-b850v3-fw" to make it clear that the driver is for the bridges with
> +the firmware specific for the GE B850v3.
> +
> +The driver is powerless to control the video processing pipeline, as the two
> +bridges behaves as a single one. The driver is only needed for telling the host
> +about EDID / HPD, and for giving the host powers to ack interrupts.

Bindings describe h/w not drivers. Rephrase in terms of what control the 
h/w provides.

> +
> +Required properties:
> +  - compatible : should be "megachips,stdp4028-ge-b850v3-fw" or
> +    "megachips,stdp2690-ge-b850v3-fw".

Reformat with one per line.

> +  - reg : should contain the main address which is used to communicate with
> +    the bridge over i2c.

Just "reg : I2C bus address" is sufficient.

> +  - interrupt-parent : phandle of the interrupt controller that services
> +    interrupts to the device (stdp4028-ge-b850v3-fw)
> +  - interrupts : one interrupt should be described here, as in
> +    <0 IRQ_TYPE_LEVEL_HIGH> (stdp4028-ge-b850v3-fw)
> +  - ports : should describe the video signal connection between the host
> +    and the bridges.

You need to define how many ports and what each port is.

Rob
