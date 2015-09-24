From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 24 Sep 2015 15:32:01 +0200
Subject: [PATCH v5 1/4] leds: netxbig: add device tree binding
In-Reply-To: <5603EA6C.80801@gmail.com>
References: <1442910248-11380-1-git-send-email-simon.guinot@sequanux.org>
 <1442910248-11380-2-git-send-email-simon.guinot@sequanux.org>
 <5603EA6C.80801@gmail.com>
Message-ID: <20150924133201.GX7306@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 02:19:56PM +0200, Jacek Anaszewski wrote:
> Hi Simon,

Hi Jacek,

Thanks again for the review. Please see my comments below.

> 
> On 09/22/2015 10:24 AM, Simon Guinot wrote:
> >This patch adds device tree support for the netxbig LEDs.
> >
> >This also introduces a additionnal DT binding for the GPIO extension bus
> >(netxbig-gpio-ext) used to configure the LEDs. Since this bus could also
> >be used to control other devices, then it seems more suitable to have it
> >in a separate DT binding.
> >
> >Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> >Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >---
> >  .../devicetree/bindings/gpio/netxbig-gpio-ext.txt  |  22 ++
> >  .../devicetree/bindings/leds/leds-netxbig.txt      |  92 +++++++
> >  drivers/leds/leds-netxbig.c                        | 265 +++++++++++++++++++--
> >  include/dt-bindings/leds/leds-netxbig.h            |  18 ++
> >  .../linux/platform_data/leds-kirkwood-netxbig.h    |   1 +
> >  5 files changed, 376 insertions(+), 22 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
> >  create mode 100644 Documentation/devicetree/bindings/leds/leds-netxbig.txt
> >  create mode 100644 include/dt-bindings/leds/leds-netxbig.h
> >
> >Changes for v2:
> >- Check timer mode value retrieved from DT.
> >- In netxbig_leds_get_of_pdata, don't use unsigned long variables to get
> >   timer delay values from DT with function of_property_read_u32_index.
> >   Instead, use a temporary u32 variable. This allows to silence a static
> >   checker warning.
> >- Make timer property optional in the binding documentation. It is now
> >   aligned with the driver code.
> >
> >Changes for v3:
> >- Fix pointer usage with the temporary u32 variable while calling
> >   of_property_read_u32_index.
> >
> >Changes for v4:
> >- In DT binding document netxbig-gpio-ext.txt, detail byte order for
> >   registers and latch mechanism for "enable-gpio".
> >- In leds-netxbig.c, add some error messages.
> >- In leds-netxbig.c, fix some "sizeof" style issues.
> >- In leds-netxbig.c, in netxbig_leds_get_of_pdata(), move the
> >   of_property_read_string() calls after the error-prone checks.
> >- Add some Acked-by.
> >
> >Changes for v5:
> >- Rename DT property "bright-max" into the more common "max-brightness".
> >- Make use of the "max-brightness" DT property. Instead of counting the
> >   data pins of the GPIO extension bus, use "max-brightness" to get the
> >   maximum brightness level.

...

> >@@ -333,7 +339,7 @@ create_netxbig_led(struct platform_device *pdev,
> >  	led_dat->mode_addr = template->mode_addr;
> >  	led_dat->mode_val = template->mode_val;
> >  	led_dat->bright_addr = template->bright_addr;
> >-	led_dat->bright_max = (1 << pdata->gpio_ext->num_data) - 1;
> >+	led_dat->bright_max = template->bright_max;
> 
> Could you explain please, why in netxbig_led_set() led_dat->bright_max
> is multiplied by the brightness value to be set as shown below?
> 
> 
> void netxbig_led_set(struct led_classdev *led_cdev,
>                      enum led_brightness value)
> {
> ...
>         if (set_brightness) {
>                 bright_val = DIV_ROUND_UP(value * led_dat->bright_max,
>                                           LED_FULL);
>                 gpio_ext_set_value(led_dat->gpio_ext,
>                                    led_dat->bright_addr, bright_val);
>         }
> ...
> }

Hardware values for brightness levels are in a range 0 to bright_max
(with bright_max = 7).
Software values for brightness levels are in a range 0 to 255.

Here, we are simply converting a software brightness value into an
hardware one. And the resulting value can be written directly into the
CPLD hardware bright register via the gpio-ext bus.

> >+	led = leds;
> >+	for_each_child_of_node(np, child) {
> >+		const char *string;
> >+		int *mode_val;
> >+		int num_modes;
> >+
> >+		if (of_property_read_u32(child, "mode-addr",
> >+					 &led->mode_addr))
> >+			return -EINVAL;
> 
> Since for_each_child_of_node uses of_get_next_child underneath,
> the user is responsible for releasing current child in case
> they are going to break the iteration. In other words you
> need to execute of_node_put(child) then. Assigning error codes
> to ret and following it with "goto exit_for_each" would do here,
> where exit_for_each is defined as follows:
> 
> exit_for_each:
> 	of_node_put(child);
> 	return ret;

OK, good caught. I'll do that for the next version. Note that a bunch of
other LED drivers are needing a such fix too.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150924/7cbfa4d9/attachment.sig>
