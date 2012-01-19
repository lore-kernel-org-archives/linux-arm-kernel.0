From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Jan 2012 08:56:07 -0800
Subject: Pinmux bindings proposal
In-Reply-To: <CAJuYYwQoh4_SnA9wmy4x+cG0w0hGukxTkODWtcSw_2QHYuDsrg@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
 <CAJuYYwQoh4_SnA9wmy4x+cG0w0hGukxTkODWtcSw_2QHYuDsrg@mail.gmail.com>
Message-ID: <20120119165607.GG22818@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Abraham <thomas.abraham@linaro.org> [120119 04:37]:
> 
> The io-pad controller (gpio/pinmux/pinconfig) can be represented in a
> dtsi file as below. There could be multiple io-pad controllers
> supported in the system.

FYI we too have too mux controller instances on omap4. That seems to
work just fine thanks to the "pinctrl: make it possible to add multiple maps"
patch by Linus W.
 
> pctrl0: pinctrl at 11400000 {
>        compatible = "samsung,exynos4210-pinctrl";
>        reg = <0x11400000 0x1000>;
>        interrupts = <.......>;
>        pin-banks = <....>;
>        [... other properties TBD ...]
>        #pinctrl-cells = <5>;
> };
> 
> Each such node instantiates one instance of the pin-controller device.
> The 'struct pinctrl_dev' should include a new member 'struct of_node'
> to point to the corresponding pin-controller node in dt which
> instantiated the controller. The pinctrl_register() function called
> from drivers/pinctrl/pinctrl-xyz.c then registers the pin-controller
> instance.

Looks similar to what I have too. 
 
> * Specifying the pinmux/pinconfig settings in dts files:
> 
> Device nodes which require specific pinmux/pinconfig settings should
> include information about the required settings. For example, a i2c
> controller node in dts file is listed below.
> 
> i2c0: i2c at 18000000 {
>         [... other properties ...]
>         pinctrl-active = <&pctrl0 5 0 2 3 0>,
>                              <&pctrl0 5 1 2 3 0>;
>         pinctrl-suspend = <&pctrl0 5 0 2 0 0>,
>                                 <&pctrl0 5 1 2 0 0>;
> };

Maybe we should have just the active/suspend/off flags in the
same array? Otherwise we'll end up unnecessarily repeating the
the pin information. See the pins + #pin-args example I posted,
which is otherwise similar.
 
> In the example above, the specifier of pinctrl-* is specific for
> Samsung io-pad controllers. Its format/syntax would be mainly
> dependent on the io-pad controller used, the above is only an example
> for Samsung io-pad controller. In the above node, the format of the
> pinctrl-* specifier is
> 
> property-name = <phandle of the pin-controller
>                            pin bank within the pin-controller
>                            pin number within the pin-bank
>                            pin-mux function number
>                            pull up/down config
>                            drive strength config>;

Are these all just bits in one register? If so, let's say you
have 16-bits per pin, we might be able to share the generic
pinmux-simple.c driver I have almost ready.. 

The format would then be

	#pin-args <4>;
	...

	/*    controller  offset on   idle off */
	pins = <&pinctrl0 0x0030 0x15 0x15 0x7>;
 
> * Using the pinmux/pinconfig specifier in device nodes to configure hardware.
> 
> A driver (for a device instantiated from device tree) would require
> code to be made aware of the pinmux/pinconfig options available. The
> typical sequence in a probe function would be as below.
> 
> (a) call of_get_named_gpio() to get the gpio number. In case of
> Samsung pinctrl driver, the pinctrl driver itself provides the gpiolib
> functionality and it attaches a gpio specifier translator with the
> gpio_chip. This translator is capable of translating the pinctrl-* and
> returning a gpio number.
> 
> (b) gpio_request() the gpio number obtained in step (a) above.
> 
> (c) Repeat steps (a) and (b) until all the gpios required by the
> driver are requested. In case a request fails, give up all the
> successfully requested gpio and return failure.

Can't the driver do this to request the gpio pins that you
can get from DT and pinmux? Even if you need to do dynamic pinmuxing
to GPIO pins for wake-up events, you can do that from the driver
as long as you get the GPIO number for the pin from mux code.

Regards,

Tony
