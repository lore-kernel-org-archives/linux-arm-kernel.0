From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Oct 2015 10:58:37 -0500
Subject: [RFC PATCH 2/3] pwm: Add PWM driver for OMAP using dual-mode
 timers
In-Reply-To: <5620ED34.6000906@baylibre.com>
References: <5620ED34.6000906@baylibre.com>
Message-ID: <87h9lqls9e.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Neil Armstrong <narmstrong@baylibre.com> writes:
> Adds support for using a OMAP dual-mode timer with PWM capability
> as a Linux PWM device. The driver controls the timer by using the
> dmtimer API.
>
> Add a platform_data structure for each pwm-omap-dmtimer nodes containing
> the dmtimers functions in order to get driver not rely on platform
> specific functions.
>
> Cc: Grant Erickson <marathon96@gmail.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |  18 ++
>  drivers/pwm/Kconfig                                |   9 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-omap-dmtimer.c                     | 322 +++++++++++++++++++++
>  include/linux/platform_data/pwm_omap_dmtimer.h     |  69 +++++
>  5 files changed, 419 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
>  create mode 100644 drivers/pwm/pwm-omap-dmtimer.c
>  create mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt b/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
> new file mode 100644
> index 0000000..7f27606
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
> @@ -0,0 +1,18 @@
> +* OMAP PWM for dual-mode timers
> +
> +Required properties:
> +- compatible: Shall contain "ti,omap-dmtimer-pwm".
> +- ti,timers: phandle to PWM capable OMAP timer. See arm/omap/timer.txt for info
> +  about these timers.
> +- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
> +  the cells format.
> +
> +Optiomal properties:
> +- ti,prescaler: Should be a value between 0 and 7, see the timers datasheet
> +
> +Example:
> +	pwm: omap-pwm {
> +		compatible = "ti,omap-pwm";
> +		ti,timers = <&timer9>;
> +		#pwm-cells = <3>;
> +	};

I wonder how far are you from a generic pwm-of-timer.c. This looks
pretty close to that. You already have a pdata function pointers for
pretty much everything, all you need to do is pass a timer phandle and,
as long as the functions pointers are implemented, it should work.

You might want to get rid of pdata altogether at some point, this should
work as migration path.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151016/bdb700b1/attachment-0001.sig>
