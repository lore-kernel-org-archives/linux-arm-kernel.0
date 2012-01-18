From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Jan 2012 06:13:29 -0800
Subject: Pinmux bindings proposal
In-Reply-To: <20120116182808.GG4223@ponder.secretlab.ca>
References: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
 <20120116182808.GG4223@ponder.secretlab.ca>
Message-ID: <20120118141329.GA22818@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Grant Likely <grant.likely@secretlab.ca> [120116 09:55]:
> On Fri, Jan 13, 2012 at 12:39:42PM -0800, Stephen Warren wrote:
> >                 pinmux =
> >                         <"default" &pmx_sdhci_active>
> >                         <"suspend" &pmx_sdhci_suspend>;
> > 
> >                 /* 1:n example: */
> >                 pinmux =
> >                         <"default" &pmx_sdhci_mux_a>
> >                         <"default" &pmx_sdhci_pincfg_a>
> >                         <"suspend" &pmx_sdhci_mux_a>
> >                         <"suspend" &pmx_sdhci_pincfg_a_suspend>;
> 
> 
> Yeah, don't do this.  Mixing phandle, string and cell values in a
> property gets messy and could become troublesome to parse.  I've
> backed away from it in the clk binding.

Yup, that's because the string is embedded directly into the mixed
mode array and will likely make the following data unaligned. That
means it's extremely flakey to parse, and will lead into horrible
errors if you have typos in the .dts file.. Tried that and gave up
on it.

I think I've found a way to avoid using names at all, assuming we set
each pin as a phandle for the drivers to use :) 

If some drivers need to use pin names, they should be optional
optional for the cases where the phandle is not available.

Here's what I'm currently using:

        pinnmux at 4a100000 {
                compatible = "pinmux-simple";
                reg = <0x4a100000 0x01d4>;
                #address-cells = <1>;
                #size-cells = <0>;
                #pinmux-cells = <2>;

                /* uart3_rx_irrx dmtimer8_pwm_evt na gpio_143 na na na safe_mode */
                uart3_rx_irrx: mux-uart3_rx_irrx at 4a100144 {
                        reg = <0x4a100144>;
                        gpios = <&gpio1 1 0>;
                        #pin-args = <1>;
                };

                /* uart3_tx_irtx dmtimer9_pwm_evt na gpio_144 na na na safe_mode */
                uart3_tx_irtx: mux-uart3_tx_irtx at 4a100146 {
                        reg = <0x4a100146>;
                        gpios = <&gpio1 2 0>;
                        #pin-args = <1>;
                };
                ...
        };

        serial at 48020000 {
                compatible = "ti,8250";
                reg = <0x48020000 0x100>;
                reg-shift = <2>;
                interrupts = <106>;
                pins = <&uart3_rx_irrx 0x10
                        &uart3_tx_irtx 0x0>;
        };

Here I have just one value for each pin register but note that the
#pin-args allows specifying the number or configuration options
depending on the hardware like of_gpio.c does using
of_parse_phandle_with_args().

The various functions for each pin controller register are only
in the comments, so currently the function needs to be provided as
a value. A preprosessor should solve that issue at some point.

This should work for anything that has one register per pin.I'd
assume the pin groups can be described here too for the hardware
that one register per pin group only just by specifying group-pins
array there?

Cheers, 

Tony
