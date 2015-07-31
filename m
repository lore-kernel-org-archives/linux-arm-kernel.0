From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 31 Jul 2015 14:45:56 +0100
Subject: [PATCH v4 2/5] dt-bindings: Add a binding for Mediatek xHCI host
 controller
In-Reply-To: <1438347836-29060-3-git-send-email-chunfeng.yun@mediatek.com>
References: <1438347836-29060-1-git-send-email-chunfeng.yun@mediatek.com>
 <1438347836-29060-3-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20150731134556.GC25118@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for my late reply to a prior version of this series, but I still
have concerns with some of the properties.

I'll repeat those below.

On Fri, Jul 31, 2015 at 02:03:53PM +0100, Chunfeng Yun wrote:
> add a DT binding documentation of xHCI host controller for the
> MT8173 SoC from Mediatek.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mt8173-xhci.txt        | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/mt8173-xhci.txt b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> new file mode 100644
> index 0000000..364be5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mt8173-xhci.txt
> @@ -0,0 +1,51 @@
> +MT65XX xhci
> +
> +The device node for Mediatek SOC usb3.0 host controller
> +
> +Required properties:
> + - compatible : Supports "mediatek,mt8173-xhci"

s/Supports/should contain/

> + - reg : Specifies physical base address and size of the registers,
> +	the first one for MAC, the second for IPPC
> + - interrupts : Interrupt mode, number and trigger mode

Just specify what this logically corresponds to; the format of the
interrupts proeprty depends on the interrupt controller.

> + - power-domains : To enable usb's mtcmos

Please describe what this contains. I assume you exped a single power
domain to be described, covering the whole xHCI controller?

> + - vusb33-supply : Regulator of usb avdd3.3v
> + - clocks : Must support all clocks that xhci needs

- clocks: a list of phandle + clock-specifier pairs, one for each entry
  in clock-names.

> + - clock-names : Should be "sys_mac" for sys and mac clocks, and
> +	"wakeup_deb_p0", "wakeup_deb_p1" for wakeup debounce control
> +	clocks

This would be better as a list, e.g.

- clock-names: should contain:
  * "sys_mac" <description here if necessary>
  * "wakeup_deb_p0" <description here if necessary>
  * "wakeup_deb_p1" <description here if necessary>

Is sys_mac a single clock input line? Or is it jsut the case that a
single line feeds two inputs currently? if the latter they should be
separate entries.

> + - phys : List of PHY specifiers (used by generic PHY framework).

The bracketed part should go. The bidnigns should know nothing of Linux
internals.

> + - phy-names : Must be "usb-phy0", "usb-phy1",.., "usb-phyN", based on
> +	the number of PHYs as specified in @phys property.

This is useless.

You either don't need names, and can acquire the phys by index, or you
need names which correspond to those on the data sheet for the xHCI
controller.

> + - mediatek,usb-wakeup : To access usb wakeup control register

Please describe what this points to (I guess it's a syscon)/

> + - mediatek,wakeup-src : 1: Ip sleep wakeup mode; 2: line state wakeup
> +	mode; others means don't enable wakeup source of usb

This sounds like a runtime decision.

_why_ do you think this needs to be in the DT?

> + - mediatek,u2port-num : The number should not greater than the number
> +	of phys

This is useless. Either this is implied by the entries in the phys
property, or it should be a runtime decision.

Thanks,
Mark.

> +
> +Optional properties:
> + - vbus-supply : Reference to the VBUS regulator;
> +
> +Example:
> +usb: usb at 11270000 {
> +	compatible = "mediatek,mt8173-xhci";
> +	reg = <0 0x11270000 0 0x4000>,
> +	      <0 0x11280000 0 0x0800>;
> +	interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
> +	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
> +	clocks = <&topckgen CLK_TOP_USB30_SEL>,
> +		 <&pericfg CLK_PERI_USB0>,
> +		 <&pericfg CLK_PERI_USB1>;
> +	clock-names = "sys_mac",
> +		      "wakeup_deb_p0",
> +		      "wakeup_deb_p1";
> +	phys = <&u3phy 0>, <&u3phy 1>;
> +	phy-names = "usb-phy0", "usb-phy1";
> +	vusb33-supply = <&mt6397_vusb_reg>;
> +	vbus-supply = <&usb_p1_vbus>;
> +	usb3-lpm-capable;
> +	mediatek,usb-wakeup = <&pericfg>;
> +	mediatek,wakeup-src = <1>;
> +	mediatek,u2port-num = <2>;
> +	status = "okay";
> +};
> -- 
> 1.8.1.1.dirty
> 
