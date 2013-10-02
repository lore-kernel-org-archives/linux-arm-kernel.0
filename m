From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 21:05:30 -0600
Subject: [RFC PATCH 2/3] Enable BCM2835 mailbox support
In-Reply-To: <5232F7C2.3070408@yahoo.com.au>
References: <5232F7C2.3070408@yahoo.com.au>
Message-ID: <524B8D7A.6080204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 05:32 AM, Craig McGeachie wrote:
> Reimplement BCM2835 mailbox support as a device registered with the
> general purpose mailbox framework.
> 
> Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
> ---
> 
> One specific area that I am looking for comment on is the device tree
> design.  I'm not happy with the two attributes for channel numbers
> and names that have to be matched up in terms of number of elements.

That style is very common.

However, I don't think there's any need for channel names at all;
devices that exist on the VideoCore side of the mailbox protocol can be
represented as child nodes of the main mailbox node, and then their reg
property can be used to identify the communication channel; just numbers
with no need for names, just like the actual HW (firmware) protocol.

> I would prefer something like
> 
>  mailbox {
>  	compatible = "brcm,bcm2835-mbox";
>   	reg = <0x7e00b800 0x400>;
>  	reg = <0x7e00b880 0x40>;

You can only have one reg property. It could have two separate entries
if required, but I don't see a need for that.

>  	interrupts = <0 1>;
> 	#address-cells = <1>;

You'll need #size-cells too, probably with value 0 since the concept of
size doesn't really apply here.

I wonder if #address-cells might not need to be more than 1 in order to
generate unique addresses for the multiple devices that hang off the
property channel?

And a blank line before the nodes.

> 	brcm,channel at 0 = {

Node names don't have a vendor prefix.

> 		reg = <0>;
> 		brcm,channel-name = "power";

I don't see a need for a channel name.

> 	};
> 	[...etc...]
>  };
> 
> But I thought that might be too fussy, or too hard for a boot loader to
> populate.

Why would the bootloader populate this? Presumably the entire mailbox
node (and its children) would be statically part of the DT that the
bootloader reads from disk.

> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
> index 75dbb89..1779ad4 100644
> --- a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
> +++ b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
> @@ -4,12 +4,19 @@ Required properties:
>  
>  - compatible : should be "brcm,bcm2835-mbox"
>  - reg : Specifies base physical address and size of the registers.
> -- interrupts : the interrupt number
> +- interrupts : the interrupt number. Must be <0 1>, the mailbox interrupt.

The binding should specify the schema, not the data. <0 1> is only true
in the case where the mailbox IP is hooked into a particular SoC. The
binding could theoretically be used on other SoCs with different
interrupt assignments.

> +- brcm,channel-nums : The mailbox channels in use.
> +- brcm,channel-names : list of symbolic channel names for mailbox clients to
> +  use.
> +
> +The number of channel numbers must match the number of channel names.

As mentioned above, I see no reason to name/number the channels in this
way. I prefer using the reg address in child nodes to represent this
information.

>  Example:
>  
>  mailbox {
>  	compatible = "brcm,bcm2835-mbox";
> -	reg = <0x7e00b800 0x400>;
> +	reg = <0x7e00b880 0x40>;
>  	interrupts = <0 1>;
> +	brcm,channel-nums = <0 1 3 8>;
> +	brcm,channel-names = "power", "fb", "vchiq", "property";
>  };

I would expect to see something like:

mailbox {
	compatible = "brcm,bcm2835-mbox";
	reg = <0x7e00b800 0x400>;
	interrupts = <0 1>;
	#address-cells = <1>;
	#size-cells = <1>;

	regulator at 0 {
		compatible = "brcm,bcm2835-mbox-power";
		reg = <0>;
		... /* various regulator nodes */
	};

	/* or perhaps use @8 for the property FB interface */
	framebuffer at 1 {
		compatible = "brcm,bcm2835-mbox-fb";
		reg = <1>;
		...
	};

	serial at 2 {
		compatible = "brcm,bcm2835-mbox-uart";
		reg = <2>;
		...
	};

	clock at 8 {
		compatible = "brcm,bcm2835-mbox-clock";
		reg = <1>;
		#clock-cells = <1>;
		...
	};

	...
};
