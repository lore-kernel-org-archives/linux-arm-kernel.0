From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Jan 2014 18:15:01 +0100
Subject: [PATCH v4 2/4] pinctrl: Add pinctrl binding for Broadcom Capri
 SoCs
In-Reply-To: <1387592016-13740-3-git-send-email-syin@broadcom.com>
References: <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-3-git-send-email-syin@broadcom.com>
Message-ID: <CACRpkdaAq15wKD900SqN1sQFLBATiuA3vNoua+KJGHU+gdCgqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 21, 2013 at 3:13 AM, Sherman Yin <syin@broadcom.com> wrote:

> Adds pinctrl driver devicetree binding for Broadcom Capri (BCM281xx) SoCs.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
> v4: Changed valid values for "bias-pull-up" property for I2C pins.  Expanded
>     pin configuration node example.

Starting to look real good...

> +Optional Properties (for standard pins):
> +
> +- function:                    String. Specifies the pin mux selection. Values
> +                               must be one of: "alt1", "alt2", "alt3", "alt4"
> +- input-schmitt-enable:                No arguments. Enable schmitt-trigger mode.
> +- input-schmitt-disable:       No arguments. Disable schmitt-trigger mode.
> +- bias-pull-up:                        No arguments. Pull up on pin.
> +- bias-pull-down:              No arguments. Pull down on pin.
> +- bias-disable:                        No arguments. Disable pin bias.
> +- slew-rate:                   Integer. Meaning depends on configured pin mux:
> +                               *_SCL or *_SDA:
> +                                       0: Standard(100kbps)& Fast(400kbps) mode
> +                                       1: Highspeed (3.4Mbps) mode
> +                               IC_DM or IC_DP:
> +                                       0: normal slew rate
> +                                       1: fast slew rate
> +                               Otherwise:
> +                                       0: fast slew rate
> +                                       1: normal slew rate
> +- input-enable:                        No arguements. Enable input (does not affect
> +                               output.)
> +- input-disable:               No arguements. Disable input (does not affect
> +                               output.)
> +- drive-strength:              Integer. Drive strength in mA.  Valid values are
> +                               2, 4, 6, 8, 10, 12, 14, 16 mA.

Also patch
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
Since you're adding generic properties.

> +Optional Properties (for I2C pins):
> +
> +- function:                    String. Specifies the pin mux selection. Values
> +                               must be one of: "alt1", "alt2", "alt3", "alt4"
> +- bias-pull-up:                        Integer. Pull up strength in Ohm. There are 3
> +                               pull-up resisitors (1.2k, 1.8k, 2.7k) available
> +                               in parallel for I2C pins, so the valid values
> +                               are: 568, 720, 831, 1080, 1200, 1800, 2700 Ohm.

Also patch
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

> +- bias-disable:                        No arguments. Disable pin bias.
> +- slew-rate:                   Integer. Meaning depends on configured pin mux:
> +                               *_SCL or *_SDA:
> +                                       0: Standard(100kbps)& Fast(400kbps) mode
> +                                       1: Highspeed (3.4Mbps) mode
> +                               IC_DM or IC_DP:
> +                                       0: normal slew rate
> +                                       1: fast slew rate
> +                               Otherwise:
> +                                       0: fast slew rate
> +                                       1: normal slew rate

Hm that does not seem generic though, so let's not add this to the
generic bindings.

> +- input-enable:                        No arguements. Enable input (does not affect
> +                               output.)
> +- input-disable:               No arguements. Disable input (does not affect
> +                               output.)
> +
> +Optional Properties (for HDMI pins):
> +
> +- function:                    String. Specifies the pin mux selection. Values
> +                               must be one of: "alt1", "alt2", "alt3", "alt4"
> +- slew-rate:                   Integer. Controls slew rate.
> +                                       0: Standard(100kbps)& Fast(400kbps) mode
> +                                       1: Highspeed (3.4Mbps) mode

Hmmmm slew rate is not specifiec in "bps" but rather in
something like volts per second. But maybe it's best to keep
this value driver-specific.

Yours,
Linus Walleij
