From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 21 Oct 2013 14:57:26 +0530
Subject: [RFC] Does PHY UTMI data width belong to DWC2 or PHY binding?
In-Reply-To: <20131018141221.GH2721@beef>
References: <20131018141221.GH2721@beef>
Message-ID: <5264F37E.9060307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 October 2013 07:42 PM, Matt Porter wrote:
> This is a summary of an unresolved issue resulting from this thread:
> http://www.spinics.net/lists/arm-kernel/msg277700.html
> 
> The BCM281xx family of SoCs contain an OTG subsystem consisting of a
> DWC2 HSOTG controller and an internal UTMI PHY. This is appears as
> follows (monospace font requirement ahead):
> 
> +----------------+              +-----------------+
> |                |              |                 |
> |                |       8      |                 |
> |      DWC2      |<------/----->|     BCM Kona    |
> |                |     UTMI     |     UTMI PHY    |
> |                |              |                 |
> +----------------+              +-----------------+
> 
> The internal UTMI phy is connected via an 8-bit data path. There is
> no way to autodetect whether the data path is 8-bit or 16-bit. As such,
> it was determined that a DT property is necessary to reflect this.
> 
> In the original patch submitted this property was offered as an
> additional optional dwc2 property:
> 
> --- a/Documentation/devicetree/bindings/staging/dwc2.txt
> +++ b/Documentation/devicetree/bindings/staging/dwc2.txt
> @@ -6,10 +6,14 @@ Required properties:
>  - reg : Should contain 1 register range (address and length)
>  - interrupts : Should contain 1 interrupt
> 
> +Optional properties:
> +- snps,phy-utmi-width: Must contain the UTMI data width (either 8 or 16)
> +
>  Example:
> 
>          usb at 101c0000 {
>                  compatible = "ralink,rt3050-usb, snps,dwc2";
>                  reg = <0x101c0000 40000>;
>                  interrupts = <18>;
> +		snps,phy-utmi-width = <8>;
>          };
> 
> The open question is whether this required hardware property belongs to
> the DWC2 controller or the PHY itself.

I think it makes sense to keep the data width property in the dwc2 node itself.
I mean it describes how the dwc2 IP is configured in that particular SoC (given
that it can be either <8> or <16>).

Thanks
Kishon

> 
> If the UTMI data path width is considered to be a property of the PHY
> then this will impact both the generic PHY framework and the PHY device
> node (producer) binding. The binding would need to be extended to carry
> the data path width property. In addition, the generic PHY framework
> would need to allow for this information to be gathered in some manner
> for use by the controller driver (PHY consumer). In the case of DWC2,
> the driver needs to know whether to program the phy interface for 8 or
> 16 bit UTMI communication.
> 
> Thanks,
> Matt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
