From: robh@kernel.org (Rob Herring)
Date: Fri, 25 Jul 2014 09:07:02 -0500
Subject: [PATCH 2/6] leds: add device tree bindings for syscon LEDs
In-Reply-To: <1406294628-16079-3-git-send-email-linus.walleij@linaro.org>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
 <1406294628-16079-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAL_Jsq+-G68wjBLDbELHRDFcGYRa65-Hx9WoD6HypXNjJKVDvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 8:23 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This adds the device tree bindings used by syscon-based LEDs.
>
> Cc: devicetree at vger.kernel.org
> Cc: Bryan Wu <cooloney@gmail.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/leds/leds-syscon.txt       | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-syscon.txt
>
> diff --git a/Documentation/devicetree/bindings/leds/leds-syscon.txt b/Documentation/devicetree/bindings/leds/leds-syscon.txt
> new file mode 100644
> index 000000000000..460b9c3d1bd3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-syscon.txt
> @@ -0,0 +1,83 @@
> +Device Tree Bindings for Syscon LEDs
> +
> +Required properties:
> +- compatible : must be "syscon-leds".

Not really happy with the name... More below.

> +- regmap : a phandle to a syscon node containing a regmap
> +
> +Each LED is represented as a sub-node of the syscon-leds device. Each
> +node's name represents the name of the corresponding LED.
> +
> +LED sub-node properties:
> +- offset : register offset to the register controlling this LED
> +- mask : bit mask for the bit controlling this LED in the register
> +  typically 0x01, 0x02, 0x04 ...

This would be a single bit, right? What about inverted bits (i.e. 0 is
on or 1 is on)?

> +- label : (optional)

Please group all required and optional properties under those headings.

> +  see Documentation/devicetree/bindings/leds/common.txt
> +- linux,default-trigger : (optional)
> +  see Documentation/devicetree/bindings/leds/common.txt
> +- default-state: (optional) The initial state of the LED. Valid
> +  values are "on", "off", and "keep". If the LED is already on or off
> +  and the default-state property is set the to same value, then no
> +  glitch should be produced where the LED momentarily turns off (or
> +  on). The "keep" setting will keep the LED at whatever its current
> +  state is, without producing a glitch.  The default is off if this
> +  property is not present.
> +
> +Example:
> +
> +leds: leds at 08 {
> +       compatible = "syscon-leds";
> +       regmap = <&syscon>;
> +
> +       led at bit0 {

Perhaps we can define a way to express unit address as offset+bit like
<offset>_<bit> or <offset>.<bit>.

I think we should get rid of the leds node and put this within the
syscon device node and each node here should have a compatible
property. I think the compatible should be something like
"register-bit-led" (perhaps someone has a better name) as syscon is
somewhat linux specific term and you could use this binding for any
LEDs that have a single register bit control.

Rob

> +               offset = <0x08>;
> +               mask = <0x01>;
> +               label = "versatile:0";
> +               linux,default-trigger = "heartbeat";
> +               default-state = "on";
> +       };
