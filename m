From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 19 Jan 2012 18:40:12 +0530
Subject: Pinmux bindings proposal
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
Message-ID: <CAJuYYwQoh4_SnA9wmy4x+cG0w0hGukxTkODWtcSw_2QHYuDsrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 January 2012 02:09, Stephen Warren <swarren@nvidia.com> wrote:
> I thought a bit more about pinmux DT bindings. I came up with something
> that I like well enough, and is pretty similar to the binding that Dong
> posted recently. I think it'll work for both Tegra's and IMX's needs.
> Please take a look!
>
> Note: I've used named constants below just to make this easier to read.
> We still don't have a solution to actually use named constants in dtc yet.
>

[...]

For Samsung io-pad controllers, I had been considering a dt approach
which has been described below. Kindly review and any comments will be
helpful.


* Main points to be considered:

All Samsung SoC's use a io-pad controller that includes gpio, pinmux
and pinconfig functionality in a single controller, i.e. there is a
single intermixed address space for gpio/pinmux/pinconfig portions in
the controller. Additionally, all the drivers for the Samsung SoC's
setup pinmux/pinconfig in its probe function (and in resume if
required).


* IO Pad controllers in dts file:

The io-pad controller (gpio/pinmux/pinconfig) can be represented in a
dtsi file as below. There could be multiple io-pad controllers
supported in the system.

pctrl0: pinctrl at 11400000 {
       compatible = "samsung,exynos4210-pinctrl";
       reg = <0x11400000 0x1000>;
       interrupts = <.......>;
       pin-banks = <....>;
       [... other properties TBD ...]
       #pinctrl-cells = <5>;
};

Each such node instantiates one instance of the pin-controller device.
The 'struct pinctrl_dev' should include a new member 'struct of_node'
to point to the corresponding pin-controller node in dt which
instantiated the controller. The pinctrl_register() function called
from drivers/pinctrl/pinctrl-xyz.c then registers the pin-controller
instance.


* Specifying the pinmux/pinconfig settings in dts files:

Device nodes which require specific pinmux/pinconfig settings should
include information about the required settings. For example, a i2c
controller node in dts file is listed below.

i2c0: i2c at 18000000 {
        [... other properties ...]
        pinctrl-active = <&pctrl0 5 0 2 3 0>,
                             <&pctrl0 5 1 2 3 0>;
        pinctrl-suspend = <&pctrl0 5 0 2 0 0>,
                                <&pctrl0 5 1 2 0 0>;
};

In the example above, the specifier of pinctrl-* is specific for
Samsung io-pad controllers. Its format/syntax would be mainly
dependent on the io-pad controller used, the above is only an example
for Samsung io-pad controller. In the above node, the format of the
pinctrl-* specifier is

property-name = <phandle of the pin-controller
                           pin bank within the pin-controller
                           pin number within the pin-bank
                           pin-mux function number
                           pull up/down config
                           drive strength config>;


* Using the pinmux/pinconfig specifier in device nodes to configure hardware.

A driver (for a device instantiated from device tree) would require
code to be made aware of the pinmux/pinconfig options available. The
typical sequence in a probe function would be as below.

(a) call of_get_named_gpio() to get the gpio number. In case of
Samsung pinctrl driver, the pinctrl driver itself provides the gpiolib
functionality and it attaches a gpio specifier translator with the
gpio_chip. This translator is capable of translating the pinctrl-* and
returning a gpio number.

(b) gpio_request() the gpio number obtained in step (a) above.

(c) Repeat steps (a) and (b) until all the gpios required by the
driver are requested. In case a request fails, give up all the
successfully requested gpio and return failure.

(d) For all entries in pinctrl-* property, use
of_parse_phandles_with_args() and get the pinctrl node pointer and the
pinctrl specifier. As an example, the i2c driver would do the
following, incrementing pin-index parameter for each call.

ret = of_parse_phandle_with_args(i2c_np, "pinctrl-active",
"#pinctrl-cells", pin-index, &pctrl_np, &pctrl_specifier);

(e) There should be a new api in pinctrl subsystem whose signature
could be something like

int pinctrl_dt_parse_and_set_mux_cfg(struct device_node *, const void *);

For each iteration of step (d) in the driver, this new api will be
called. The value of pctrl_np and pctrl_specifier obtained from step
(d) is passed as a parameters to this new api. This api will do the
following

(e1) Find the pin-controller (struct pinctrl_dev) that has a
device_node pointer which is same as the first parameter. To recap, it
was mentioned above that: "The 'struct pinctrl_dev' should include a
new member 'struct of_node' to point to the corresponding
pin-controller node in dt which instantiated the controller."

(e2) A new callback 'xlate_pinctrl' is required in 'struct
pinctrl_ops' which can translate the second parameter of
'pinctrl_dt_parse_and_set_mux_cfg' function. From the pin controller
found in step (e1), call pinctrl_dev->desc->pctlops->xlate_pinctrl
passing the second parameter of 'pinctrl_dt_parse_and_set_mux_cfg'
function. The pin-controller specific translator function will
translate the parameter and program the hardware registers. The
xlate_pinctrl is specific to each pin-controller is it knows how to
decode the specifier and program the registers.


The above method may have some elements that are specific to Samsung
io-pad controller. But the main requirement for the above procedure
from the pinctrl subsystem is the new API
'pinctrl_dt_parse_and_set_mux_cfg' and related additions to 'struct
pinctrl_dev' and ''struct pinctrl_ops'. These additions are generic
and any io-pad controller could use it.

Thanks for any feedback.

Regards,
Thomas.
