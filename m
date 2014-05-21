From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 May 2014 16:50:54 +0200
Subject: [Patch v4 2/5] Power: reset: add bindings for keystone reset
 driver
In-Reply-To: <1400682454-24535-3-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400682454-24535-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1400682454-24535-3-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <5023955.Vhmhn25HgF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 May 2014 17:27:31 Ivan Khoronzhuk wrote:
> This node is intended to allow SoC reset in case of software reset
> or appropriate watchdogs.
> 
> The Keystone SoCs can contain up to 4 watchdog timers to reset
> SoC. Each watchdog timer event input is connected to the Reset Mux
> block. The Reset Mux block can be configured to cause reset or not.
> 
> Additionally soft or hard reset can be configured.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>  .../bindings/power/reset/keystone-reset.txt        | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/keystone-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/keystone-reset.txt b/Documentation/devicetree/bindings/power/reset/keystone-reset.txt
> new file mode 100644
> index 0000000..64cb7b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/keystone-reset.txt
> @@ -0,0 +1,66 @@
> +* Device tree bindings for Texas Instruments keystone reset
> +
> +This node is intended to allow SoC reset in case of software reset
> +of selected watchdogs.
> +
> +The Keystone SoCs can contain up to 4 watchdog timers to reset
> +SoC. Each watchdog timer event input is connected to the Reset Mux
> +block. The Reset Mux block can be configured to cause reset or not.
> +
> +Additionally soft or hard reset can be configured.
> +
> +Required properties:
> +
> +- compatible:		ti,keystone-reset
> +
> +- ti,syscon-pll:	syscon register range used to access pll controller
> +			registers in order to use reset control registers.
> +
> +- ti,syscon-dev:	syscon register range used to access device state
> +			control registers in order to use mux block registers
> +			for all watchdogs.

This should be updated to call these phandles rather than register ranges.

> +Optional properties:
> +
> +- ti,soft-reset:	Boolean option indicating soft reset.
> +			By default hard reset is used.
> +
> +- ti,wdt_list:		WDT list that can cause SoC reset. It's not related
> +			to WDT driver, it's just needed to enable a SoC related
> +			reset that's triggered by one of WDTs. The list is
> +			in format: <0>, <2>; It can be in random order and
> +			begins from 0 to 3, as keystone can contain up to 4 SoC
> +			reset watchdogs and can be in random order.
> +
> +Example 1:
> +Setup keystone reset so that in case software reset or
> +WDT0 is triggered it issues hard reset for SoC.
> +
> +pllctrl: pll_controller {
> +	compatible = "syscon";
> +	reg = <0x2310000 0x200>;
> +};
> +
> +devctrl: device_state_control {
> +	compatible = "syscon";
> +	reg = <0x2620000 0x1000>;
> +};

It's ok to have these in the example, but please also add a binding file
for each one describing what they are, and add a proper "compatible" string
so they can be matched by a high-level device driver if needed.

This could for instance be

	compatible = "ti,keystone-1.0-pll-controller", "syscon";


	Arnd
