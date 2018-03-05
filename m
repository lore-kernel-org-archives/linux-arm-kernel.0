From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 17:53:00 -0600
Subject: [PATCH] dt-bindings: pwm: Add generic "pwm-channels" property
In-Reply-To: <20180228013732.8506-1-andre.przywara@arm.com>
References: <20180228013732.8506-1-andre.przywara@arm.com>
Message-ID: <20180305235300.fvelyl7vqcjc4u5f@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 01:37:32AM +0000, Andre Przywara wrote:
> Many PWM drivers seem to hardcode the number of PWM channels
> (brcm,iproc-pwm, brcm,kona-pwm.txt). If this is only one device
> supported by the binding, that's probably OK, but for instance for
> sun4i-pwm I see one or two channels, depending on the particular SoC.
> amlogic,meson-gxbb-pwm seems to deduce the number of channels from the
> number of input clocks, and pwm-st has a vendor-specific property for
> that (st,pwm-num-chan).
> To cover all those cases more elegantly in (future) bindings, add a new
> generic property to specify the number of PWM channels a particular
> controller implements.
> For instance the sun4i-pwm driver could be extended to support this for
> future SoCs as well.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> ---
> Hi,
> 
> while looking at the bindings for PWM drivers, I was wondering if we
> should have a generic property to note the number of implemented
> channels? We have something for instance for DMA controllers
> (dma-channels), so adding this to PWM controller bindings sounds
> natural.
> In particular the new sun8i-pwm IP seems to be scalable to a number of
> channels, judging from the register and bit layout and from the bit
> assignment in the manual. I have the gut feeling we will meet this fella
> again in another Allwinner SoC with a different number of channels.

Often this should be implied by the compatible string. However, there 
are no doubt some cases that may need this. One I could think of is the 
PWM controller has more channels than are pinned out.

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> Thanks!
> Andre.
> 
>  Documentation/devicetree/bindings/pwm/pwm.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
> index 8556263b8502..770f3aee17af 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> @@ -60,10 +60,16 @@ Example with optional PWM specifier for inverse polarity
>  PWM controller nodes must specify the number of cells used for the
>  specifier using the '#pwm-cells' property.
>  
> +A specific controller binding might specify the implemented number of
> +PWM channels using this generic property:
> +	pwm-channels = <8>;
> +This property holds a single 32 bit integer.
> +
>  An example PWM controller might look like this:
>  
>  	pwm: pwm at 7000a000 {
>  		compatible = "nvidia,tegra20-pwm";
>  		reg = <0x7000a000 0x100>;
>  		#pwm-cells = <2>;
> +		pwm-channels = <4>;
>  	};
> -- 
> 2.14.1
> 
