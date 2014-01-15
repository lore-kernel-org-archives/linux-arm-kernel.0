From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Jan 2014 17:11:55 +0000
Subject: [PATCH v3 5/7] ARM: brcmstb: add misc. DT bindings for
 brcm,brcmstb-*
In-Reply-To: <1389743333-16741-6-git-send-email-marc.ceeeee@gmail.com>
References: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
 <1389743333-16741-6-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <20140115171155.GK25824@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 11:48:51PM +0000, Marc Carino wrote:
> Document the bindings that the Broadcom STB platform needs
> for proper bootup.
> 
> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/arm/brcm-brcmstb.txt       |   43 ++++++++++++++++++++
>  1 files changed, 43 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
> new file mode 100644
> index 0000000..5f1aba7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
> @@ -0,0 +1,43 @@
> +Broadcom STB platforms Device Tree Bindings
> +-------------------------------------------
> +Boards with Broadcom Brahma15 ARM-based BCM7xxx SoC shall have the following
> +properties.
> +
> +Required root node properties:
> +
> +    - compatible = "brcm,brcmstb-<chip_id>";

I'd prefer it if variants were listed explicitly (as it makes it far
easier to grep for). Something like:

- compatible: should contain one of:
  * "brcm,brcmsrb-7445"
  * "brcm,brcmsrb-7446"

> +
> +Further, a node with the following compatible string shall be defined:
> +
> +    - compatible: "brcm,brcmstb-gen-ctrl-v1"

It's probably better to say a brcmstb-gen-ctrl node (described below)
should be present, or you'll have two places to update the compatible
strings for each new variant...

> +
> +brcmstb-gen-ctrl
> +----------------
> +This node describes the registers needed for reset and CPU power control.
> +
> +    - compatible: "brcm,brcmstb-gen-ctrl-v1"
> +    - properties:

This looks odd, compatible is itself a property.

> +        o reg = <rst-src-en-reg-base len
> +                 sw-mstr-rst-reg-base len
> +                 cpu-rst-cfg-reg-base len
> +                 cpu-pwr-zone-ctrl-reg-base len
> +                 stb-boot-hi-addr0-reg len>;

This would be nicer as something like follows, but with less
abberviation (unless these names are from a datasheet for the hardware).

- reg: a list of base-address size pairs:
  * The first entry should cover the sw-mstr-rst registers
  * The second entry should cover the cpu-rst-cfg registers
  * The third entry should cover the cpu-pwr-zone registers
  * The fourth entry should cover the stb-boot-hi-addr0 registers

It may make sense to use reg-names, future revisions might change
things.

> +
> +example:
> +/ {
> +    model = "Broadcom STB";
> +    compatible =  "brcm,brcmstb-7445";
> +
> +    /* snip */
> +
> +    gen-ctrl {
> +        compatible = "brcm,brcmstb-gen-ctrl-v1";
> +        reg = <0xf0404304 0x4
> +               0xf0404308 0x4
> +               0xf03e2578 0x4
> +               0xf03e2488 0x10
> +               0xf0452000 0x20>;

Nit: please bracket each entry individually:

reg = <0xf0404304 0x4>,
      <0xf0404308 0x4>,
      <0xf03e2578 0x4>,
      <0xf03e2488 0x10>,
      <0xf0452000 0x20>;

Also, these look to be single registers in a larger register bank. Is
there any reason you can't describe the bank(s) they are in? That'll
give you more flexibility in the driver...

Thanks,
Mark
