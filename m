From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 Oct 2013 10:56:40 +0100
Subject: [PATCH 5/6] ARM: integrator: move CM base into device tree
In-Reply-To: <1380816228-3209-1-git-send-email-linus.walleij@linaro.org>
References: <1380816228-3209-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131008095639.GE28972@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding devicetree to Cc]

On Thu, Oct 03, 2013 at 05:03:48PM +0100, Linus Walleij wrote:
> This moves the core module (CM) control base into the device
> tree. It is a simple memory range of 0x200 bytes. Move the
> cm header down into the machine directory and unexport the
> cm_control() symbol as no modules are using it.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/arm-boards |  17 +++-
>  arch/arm/boot/dts/integrator.dtsi                |   5 +
>  arch/arm/mach-integrator/cm.h                    |  40 ++++++++
>  arch/arm/mach-integrator/core.c                  | 120 +++++++++++++++--------
>  arch/arm/mach-integrator/include/mach/cm.h       |  38 -------
>  arch/arm/mach-integrator/integrator_ap.c         |   6 +-
>  arch/arm/mach-integrator/integrator_cp.c         |   3 +-
>  arch/arm/mach-integrator/leds.c                  |   3 +-
>  8 files changed, 142 insertions(+), 90 deletions(-)
>  create mode 100644 arch/arm/mach-integrator/cm.h
>  delete mode 100644 arch/arm/mach-integrator/include/mach/cm.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
> index 06e5370..1a2a81d 100644
> --- a/Documentation/devicetree/bindings/arm/arm-boards
> +++ b/Documentation/devicetree/bindings/arm/arm-boards
> @@ -10,11 +10,15 @@ Required properties (in root node):
>  FPGA type interrupt controllers, see the versatile-fpga-irq binding doc.
> 
>  Required nodes:
> +- core-module: the root node to the Integrator platforms must have
> +  a core-module with regs and the compatible-string
> +  "arm,core-module-integrator"

s/compatible-string/compatible string/

What are the regs -- one entry, or several?

What do they correspond to?

How big are they?

> +- cpcon/syscon: the root node the Integrator/CP must have a /cpcon
> +  node pointing to the CP control registers, and the Integrator/AP
> +  must have a /syscon node pointing to the Integrator/AP system
> +  controller. The AP syscon node must include the logical module
> +  interrupts.

It's a shame we can't fix this up to have a compatible string...

Cheers,
Mark.
