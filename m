From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 12 Apr 2017 19:21:58 +0200
Subject: [PATCH v5 1/4] gpio: mvebu: Add limited PWM support
In-Reply-To: <20170409180931.4884-2-ralph.sennhauser@gmail.com>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
 <20170409180931.4884-2-ralph.sennhauser@gmail.com>
Message-ID: <20170412172158.GF11964@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 09, 2017 at 08:09:27PM +0200, Ralph Sennhauser wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Armada 370/XP devices can 'blink' GPIO lines with a configurable on
> and off period. This can be modelled as a PWM.
> 
> However, there are only two sets of PWM configuration registers for
> all the GPIO lines. This driver simply allows a single GPIO line per
> GPIO chip of 32 lines to be used as a PWM. Attempts to use more return
> EBUSY.
> 
> Due to the interleaving of registers it is not simple to separate the
> PWM driver from the GPIO driver. Thus the GPIO driver has been
> extended with a PWM driver.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427287/
> URL: https://patchwork.ozlabs.org/patch/427295/
> [Ralph Sennhauser:
>   * Port forward
>   * Merge PWM portion into gpio-mvebu.c
>   * Switch to atomic PWM API
>   * Add new compatible string marvell,armada-370-xp-gpio
>   * Update and merge documentation patch
>   * Update MAINTAINERS]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/gpio/gpio-mvebu.txt        |  32 ++
>  MAINTAINERS                                        |   2 +
>  drivers/gpio/gpio-mvebu.c                          | 324 ++++++++++++++++++++-
>  3 files changed, 346 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> index a6f3bec..fe49e9d 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> @@ -38,6 +38,24 @@ Required properties:
>  - #gpio-cells: Should be two. The first cell is the pin number. The
>    second cell is reserved for flags, unused at the moment.
>  
> +Optional properties:
> +
> +In order to use the gpio lines in PWM mode, some additional optional
> +properties are required. Only Armada 370 and XP support these properties.
> +
> +- compatible: Must contain "marvell,armada-370-xp-gpio"
> +
> +- reg: an additional register set is needed, for the GPIO Blink
> +  Counter on/off registers.
> +
> +- reg-names: Must contain an entry "pwm" corresponding to the
> +  additional register range needed for pwm operation.
> +
> +- #pwm-cells: Should be two. The first cell is the GPIO line number. The
> +  second cell is the period in nanoseconds.
> +
> +- clocks: Must be a phandle to the clock for the gpio controller.

One other thing: there's a mix of pwm/PWM and gpio/GPIO in this hunk. In
prose, always use the all-uppercase variants because they are
abbreviations.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/d8af46fc/attachment.sig>
