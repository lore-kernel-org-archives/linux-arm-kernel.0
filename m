From: peda@axentia.se (Peter Rosin)
Date: Wed, 12 Jul 2017 07:04:46 +0200
Subject: [PATCH 0/3] USB Mux support for Chipidea
In-Reply-To: <20170712010255.26855-1-stephen.boyd@linaro.org>
References: <20170712010255.26855-1-stephen.boyd@linaro.org>
Message-ID: <fc1f2836-cd9b-0905-21fc-d2d3029d1f52@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-07-12 03:02, Stephen Boyd wrote:
> This patchset adds support for the TC7USB40MU usb mux found on 
> db410c 96boards platforms via the new multiplexer framework and
> hooks that into the chipidea driver. This allows us to properly
> control host or device mode on this board via the sysfs knob.
> 
> So far I've only tested this on db410c, and there are some rough
> edges to finish off before it can merge. Also I'm experiencing
> odd behavior with switching the role while gadget is enabled and
> the micro-usb cable is kept connected. Not sure what's wrong but
> it seems like the gadget never gets disconnected? I'll investigate
> more.
> 
> TODO:
> 
>  1. The mux framework has to be selected for consumers to use it. We'll
>     need some stubs in the consumer header file to allow compilation to
>     continue without mux always enabled by consumers.

Instead of "depends on MULTIPLEXER", just add "select MULTIPLEXER"
to the Kconfig. Otherwise, you'll have to convince Linus that we
really do need a Kconfig question for the subsystem :-)

https://lkml.org/lkml/2017/7/4/118

>  2. We probably need some sort of mux_control_get_optional() API so that
>     we know if there was an error getting the mux control, instead of just
>     ignoring errors. For now I can pass up EPROBE_DEFER errors and ignore
>     other errors and consider it "missing from DT".

Yes, mux_control_get_optional should be easy to add.

>  3. Maybe we can get rid of the mux driver and just use mux-gpio.c with
>     a compatible string update? I split it off because we may want to
>     support the "S" pin on the TC7USB40MU one day that shuts off both
>     mux outputs.

Maybe no need for a compatible update either, if it works to do something
like this in the DT?

	usb_switch: usb-switch {
		compatible = "gpio-mux";
		mux-gpios = <&pm8916_gpios 4 GPIO_ACTIVE_HIGH>,
			    <&pm8916_gpios XXX GPIO_ACTIVE_XXX>;
		idle-state = <2>;
		#mux-control-cells = <0>;
		pinctrl-names = "default";
		pinctrl-0 = <&usb_sw_sel_pm>;
	};

But I obviously know little about how things are wired and really works,
so that might be totally off...

Otherwise, maybe a generic mux-pinctrl driver would do the trick?
(compare with drivers/i2c/muxes/i2c-mux-pinctrl.c)

Cheers,
peda

>  4. The userspace side of things is murky. What is expected to go and toggle
>     the host/gadget side of things in userspace at this very specific location
>     for chipidea devices?
> 
> Stephen Boyd (3):
>   usb: misc: Add a driver for TC7USB40MU
>   usb: chipidea: Hook into mux framework to toggle usb switch
>   arm64: dts: qcom: Collapse usb support into one node
> 
>  .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |  8 +++
>  .../devicetree/bindings/usb/toshiba,tc7usb40mu.txt | 31 +++++++++
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          | 39 +++++++-----
>  arch/arm64/boot/dts/qcom/msm8916.dtsi              | 62 +++++++++---------
>  drivers/usb/chipidea/core.c                        | 17 +++++
>  drivers/usb/chipidea/host.c                        | 10 +++
>  drivers/usb/chipidea/udc.c                         | 11 ++++
>  drivers/usb/misc/Kconfig                           | 11 ++++
>  drivers/usb/misc/Makefile                          |  1 +
>  drivers/usb/misc/tc7usb40mu.c                      | 74 ++++++++++++++++++++++
>  include/linux/usb/chipidea.h                       | 14 ++++
>  11 files changed, 228 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/toshiba,tc7usb40mu.txt
>  create mode 100644 drivers/usb/misc/tc7usb40mu.c
> 
