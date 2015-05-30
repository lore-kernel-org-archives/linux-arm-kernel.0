From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 29 May 2015 17:36:13 -0700
Subject: [PATCH v2 3/6] dt-bindings: brcmstb-gpio: document properties
 for wakeup
In-Reply-To: <1432865650-4062-4-git-send-email-gregory.0xf0@gmail.com>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
 <1432865650-4062-4-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <20150530003613.GW27753@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 07:14:07PM -0700, Gregory Fong wrote:
> Some brcmstb GPIO controllers can be used to wake from suspend, so use the
> de facto standard property 'wakeup-source' to mark the nodes of controllers
> with that capability.
> 
> Also document interrupts-extended, which will be used for wakeup handling
> because the interrupt parent for the wake IRQ is different from the regular
> IRQ.
> 
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
> ---
> New in v2.
> 
>  .../devicetree/bindings/gpio/brcm,brcmstb-gpio.txt | 26 +++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
> index 435f1bc..568814f 100644
> --- a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
> @@ -33,6 +33,12 @@ Optional properties:
>  - interrupt-parent:
>      phandle of the parent interrupt controller
>  
> +- interrupts-extended:
> +    Alternate form of specifying interrupts and parents that allows for
> +    multiple parents.  This takes precedence over 'interrupts' and
> +    'interrupt-parent'.  This probably must be used if the wakeup-source
> +    property is provided because that may have a different interrupt parent.
> +

"This probably must be used" seems a little awkward, especially when
you're just explaining an implementation detail of our SoCs, rather than
something unique about this binding. Maybe:

  "Wakeup-capable GPIO controllers often route their wakeup interrupt
  lines through a different interrupt controller than the primary
  interrupt line, making this property necessary."

>  - #interrupt-cells:
>      Should be <2>.  The first cell is the GPIO number, the second should specify
>      flags.  The following subset of flags is supported:
> @@ -48,7 +54,10 @@ Optional properties:
>      Marks the device node as an interrupt controller
>  
>  - interrupt-names:
> -    The name of the IRQ resource used by this controller
> +    The names of the IRQ resources used by this controller

If you're specifying names, you should list them here.

> +
> +- wakeup-source:
> +    GPIOs for this controller can be used as a wakeup source
>  
>  Example:
>  	upg_gio: gpio at f040a700 {
> @@ -63,3 +72,18 @@ Example:
>  		interrupt-names = "upg_gio";
>  		brcm,gpio-bank-widths = <0x20 0x20 0x20 0x18>;
>  	};
> +
> +	upg_gio_aon: gpio at f04172c0 {
> +		#gpio-cells = <0x2>;
> +		#interrupt-cells = <0x2>;

Might use decimal instead of hex for the above 2 lines?

> +		compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
> +		gpio-controller;
> +		interrupt-controller;
> +		reg = <0xf04172c0 0x40>;
> +		interrupt-parent = <0xc>;

That should be a phandle, not an int (I realize phandles resolve down to
an integer, but we're speaking DTS, not DTB).

> +		interrupts = <0x6>;
> +		interrupts-extended = <0xc 0x6 0xa 0x5>;

Same here (phandles).

Also, even though the interrupt binding semantics specify precedence
between interrupts and interrupts-extended, I'd think an example should
stick to one or the other, no?

> +		interrupt-names = "upg_gio_aon", "upg_gio_aon_wakeup";
> +		wakeup-source;
> +		brcm,gpio-bank-widths = <0x12 0x4>;
> +	};

Reviewed-by: Brian Norris <computersforpeace@gmail.com>
