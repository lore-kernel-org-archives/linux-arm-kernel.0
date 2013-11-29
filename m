From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 12:49:01 +0100
Subject: [PATCH 01/31] ARM: tegra: add missing clock documentation to DT
 bindings
In-Reply-To: <1384548866-13141-2-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129114900.GN22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:53:56PM -0700, Stephen Warren wrote:
[...]
> @@ -60,6 +81,12 @@ of the following host1x client modules:
>    - compatible: "nvidia,tegra<chip>-dc"
>    - reg: Physical base address and length of the controller's registers.
>    - interrupts: The interrupt outputs from the controller.
> +  - clocks : Must contain an entry for each entry in clock-names.
> +    See ../clocks/clock-bindings.txt for details.
> +  - clock-names : Must include the following entries:
> +    - disp1 or disp2 (depending on the controller instance)

I'm not sure if this makes sense. The name could be the same independent
of which controller uses it. If it isn't then the driver would need
additional code to find out which instance it is and construct a dynamic
string.

Any objection to just make this entry "disp", or "dc"?

>  - dsi: display serial interface
>  
>    Required properties:
>    - compatible: "nvidia,tegra<chip>-dsi"
>    - reg: Physical base address and length of the controller's registers.
> +  - clocks : Must contain one entry, for the module clock.
> +    See ../clocks/clock-bindings.txt for details.
> +  - clocks : Must contain an entry for each entry in clock-names.
> +    See ../clocks/clock-bindings.txt for details.

There's another duplicate clocks entry here, although perhaps Marc
already caught that.

> +  - clock-names : Must include the following entries:

One other thing I noticed here is that you use a space between the
property name and the :. None of the other properties have that, so it
looks somewhat out of place. The same is true for other bindings, but
there seem to be inconsistencies in some places anyway, so perhaps we
don't care? Well, I do care, don't know about you. =)

> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> index 91ff771c7e77..d4f2d534934b 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> @@ -6,8 +6,10 @@ Required properties:
>  - interrupts: Should contain SPI interrupts.
>  - nvidia,dma-request-selector : The Tegra DMA controller's phandle and
>    request selector for this SPI controller.
> -- This is also require clock named "spi" as per binding document
> -  Documentation/devicetree/bindings/clock/clock-bindings.txt
> +- clocks : Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names : Must include the following entries:
> +  - spi

This is inconsistent with other bindings that require only a single
clock entry. I suppose that this is required because of the driver
requesting a specifically named clock, in which case that's fine.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/ed66f459/attachment.sig>
