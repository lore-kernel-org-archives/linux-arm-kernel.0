From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 25 Oct 2013 14:17:14 +0300
Subject: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
In-Reply-To: <526A528C.2020204@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
 <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com>
 <526A4585.30403@ti.com> <526A4708.7010309@ti.com> <526A4DEA.3050505@ti.com>
 <526A528C.2020204@ti.com>
Message-ID: <526A533A.6080903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/13 14:14, Nishanth Menon wrote:

> one additional angle before I forget - this is something we do as part
> of power optimization - to identify pins which are programmed for a
> pull in non-functional scenario as it has direct impact on idle power
> numbers.
> 
> For example patch #3 in this series
> &omap4_pmx_core {
> pinctrl-0
> ...
> 	&lcd2_pins
> ..
> }
> &lcd2_pins
> 
> lcd2_pins: pinmux_lcd2_pins {
> +		pinctrl-single,pins = <
> +			0x20 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_40 */
> +			0x46 (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpio_59 */
> +			0x56 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_104 */
> +		>;
> 
> 3 pins are driven around 300uA at boot, even with display OFF -> which
> means wasted current that could have been optimized by hooking the pin
> to the dts node corresponding to the device and used by the driver
> appropriately.
> 
> Unfortunately, folks feel simplifying the driver is traditionally a
> better alternative but with a 400 odd pins on a typical SoC of today,
> these defaults add up and end user tends to suffer with bad overall
> power numbers :(..

Good point. I guess that also makes my point of having default values
for GPIOs a bit silly. Driving the GPIO high by default would be ever
worse than the mux pull-up, I believe.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131025/f57a8993/attachment-0001.sig>
