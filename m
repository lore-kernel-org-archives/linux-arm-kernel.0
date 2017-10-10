From: robh@kernel.org (Rob Herring)
Date: Tue, 10 Oct 2017 10:46:14 -0500
Subject: [PATCH 1/7] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
In-Reply-To: <20170929223411.9691-2-tony@atomide.com>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-2-tony@atomide.com>
Message-ID: <20171010154614.gby64lglieag2lpn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 03:34:05PM -0700, Tony Lindgren wrote:
> With the recently introduced omap clkctrl module binding, we can start
> moving omap hwmod data to device tree and drivers from arch/arm/mach-omap2.
> 
> To start doing this, let's introduce a device tree binding for TI
> sysc interconnect target module hardware. The sysc manages module clocks,
> idlemodes and interconnect level resets. Each interconnect target module
> can have one or more child devices connected to it.
> 
> TI sysc interconnect target module hardware is independent of the
> interconnect. It is used at least with TI L3 interconnect (Arteris NoC)
> and TI L4 interconnect (Sonics s3220). The sysc is mostly used for
> interaction between module and PRCM. It participates in the OCP Disconnect
> Protocol but other than that is mostly indepenent of the interconnect.
> 
> As all the features may not be supported for a given sysc module, we
> need to use device tree configuration for the revision of the interconnect
> target module.
> 
> Note that the interconnect target module control registers are always
> sprinked at varying locations in the unused address space of the first
> child device IP block. To avoid device tree reg conflicts, the sysc device
> provides ranges for it's children.
> 
> For a non-intrusive transition from static hwmod data to using device
> tree defined TI interconnect target module binding, we can keep things
> working with static hwmod data if device tree property "ti,hwmods" is
> specified for the the interconnect target module.
> 
> Note that additional properties for sysc capabilities will be added
> later on. For now, we can already use this binding for interconnect
> target modules that do not have any child device drivers available.
> This allows us to idle the unused interconnect target modules during
> init without the need for legacy hwmod platform data for doing it.
> 
> Cc: Beno?t Cousson <bcousson@baylibre.com>
> Cc: Dave Gerlach <d-gerlach@ti.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@iki.fi>
> Cc: Suman Anna <s-anna@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/bus/ti-sysc.txt | 93 +++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.txt

One typo below, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> @@ -0,0 +1,93 @@
> +Texas Instruments sysc interconnect target module wrapper binding
> +
> +Texas Instruments SoCs can have a generic interconnect target module
> +hardware for devices connected to various interconnects such as L3
> +interconnect (Arteris NoC) and L4 interconnect (Sonics s3220). The sysc
> +is mostly used for interaction between module and PRCM. It participates
> +in the OCP Disconnect Protocol but other than that is mostly indepenent

s/indepenent/independent/

> +of the interconnect.
