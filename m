From: nm@ti.com (Nishanth Menon)
Date: Fri, 25 Oct 2013 10:24:50 -0500
Subject: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
In-Reply-To: <526A59F9.3010104@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
 <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com>
 <526A4585.30403@ti.com> <526A4708.7010309@ti.com> <526A4DEA.3050505@ti.com>
 <526A528C.2020204@ti.com> <526A59F9.3010104@ti.com>
Message-ID: <526A8D42.5090209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2013 06:46 AM, Tomi Valkeinen wrote:
> On 25/10/13 14:14, Nishanth Menon wrote:
> 
>> lcd2_pins: pinmux_lcd2_pins {
>> +		pinctrl-single,pins = <
>> +			0x20 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_40 */
>> +			0x46 (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpio_59 */
>> +			0x56 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_104 */
>> +		>;
>>
>> 3 pins are driven around 300uA at boot, even with display OFF -> which
>> means wasted current that could have been optimized by hooking the pin
>> to the dts node corresponding to the device and used by the driver
>> appropriately.
> 
> One more clarification question.
> 
> The gpio 40 is used to enable powers for the picodlp. Shouldn't that one
> have a pinctrl pull-down in any case? If it's left floating, and the
> driver is not compiled in or doesn't start, the powers could get enabled
> depending on sunspot, right?
> 
> And I guess the same goes for all gpios used to enable something.
> 
Fair question. The selection of pull up, gpio control needs to be
balanced.
if the peripheral in question has a regulator controlled supply, none
of the pins would matter - driver can adequately sequence this to
ensure there are no weird side-effects. in such a scenario, i'd have a
default MODE3 with no pulls, sequence as follows:
a) control gpio to required default level (disabled)
b) control regulator
c) set GPIO to enable.

if the peripheral in question is always on and controlled with just a
enable pin, it is safer to keep the pin muxed with weak pull.

If the enable has no real functional impact without setting another
pin (say power_on), or if any transient glitches on the line has no
functional impact, I might go with no pull configuration.


It all depends on the schematics and peripherals involved w.r.t how
you'd optimally select the configuration.

-- 
Regards,
Nishanth Menon
