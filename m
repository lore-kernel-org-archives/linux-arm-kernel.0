From: arend@broadcom.com (Arend van Spriel)
Date: Mon, 30 Jun 2014 10:31:21 +0200
Subject: [PATCH v3 1/4] dt: bindings: add bindings for Broadcom bcm43xx
 sdio devices
In-Reply-To: <1404051421-24377-2-git-send-email-hdegoede@redhat.com>
References: <1404051421-24377-1-git-send-email-hdegoede@redhat.com>
 <1404051421-24377-2-git-send-email-hdegoede@redhat.com>
Message-ID: <53B12059.50808@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-06-14 16:16, Hans de Goede wrote:
> From: Arend van Spriel <arend@broadcom.com>
> 
> The Broadcom bcm43xx sdio devices are fullmac devices that may be
> integrated in ARM platforms. Currently, the brcmfmac driver for
> these devices support use of platform data. This patch specifies
> the bindings that allow this platform data to be expressed in the
> devicetree.
> 
> Reviewed-by: Hante Meuleman <meuleman@broadcom.com>
> Reviewed-by: Franky (Zhenhui) Lin <frankyl@broadcom.com>
> Reviewed-by: Daniel (Deognyoun) Kim <dekim@broadcom.com>
> Reviewed-by: Pieter-Paul Giesberts <pieterpg@broadcom.com>
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> [hdegoede at redhat.com: drop clk / reg_on gpio handling, as there is no consensus
>  on how to handle this yet]
> [hdegoede at redhat.com: move from bindings/staging to bindings]
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../bindings/net/wireless/brcm,bcm43xx-fmac.txt    | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> new file mode 100644
> index 0000000..5dbf169
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> @@ -0,0 +1,41 @@
> +Broadcom BCM43xx Fullmac wireless SDIO devices
> +
> +This node provides properties for controlling the Broadcom wireless device. The
> +node is expected to be specified as a child node to the SDIO controller that
> +connects the device to the system.
> +
> +Required properties:
> +
> + - compatible : Should be "brcm,bcm4329-fmac".
> +
> +Optional properties:
> + - brcm,drive-strength : drive strength used for SDIO pins on device in mA
> +	(default = 6).
> + - interrupt-parent : the phandle for the interrupt controller to which the
> +	device interrupts are connected.
> + - interrupts : specifies attributes for the out-of-band interrupt (host-wake).
> +	When not specified the device will use in-band SDIO interrupts.
> + - interrupt-names : name of the out-of-band interrupt, which must be set
> +	to "host-wake".
> +
> +Example:
> +
> +mmc3: mmc at 01c12000 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc3_pins_a>;
> +	vmmc-supply = <&reg_vmmc3>;
> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";
> +
> +	brcmf: bcrmf at 1 {
> +		reg = <1>;

I guess the reg property is needed to have this node linked to sdio func
1 dev, right? I would add it to the list of required properties above
even if this behaviour is already described in a more generic binding.

Regards,
Arend

> +		compatible = "brcm,bcm4329-fmac";
> +		interrupt-parent = <&pio>;
> +		interrupts = <10 8>; /* PH10 / EINT10 */
> +		interrupt-names = "host-wake";
> +	};
> +};
> 
