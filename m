From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 15 Jul 2015 09:46:42 +0200
Subject: [RESEND PATCH 1/2] pinctrl: change function behavior for per pin
 muxing controllers
In-Reply-To: <20150714055749.GB5161@pengutronix.de>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
 <1433948699-19800-2-git-send-email-ludovic.desroches@atmel.com>
 <557EF60D.8020007@wwwdotorg.org>
 <20150617123816.GB12295@odux.rfo.atmel.com>
 <5581988C.50000@wwwdotorg.org>
 <20150618123348.GB20227@odux.rfo.atmel.com>
 <20150714055749.GB5161@pengutronix.de>
Message-ID: <20150715074642.GA14886@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 07:57:49AM +0200, Sascha Hauer wrote:
> On Thu, Jun 18, 2015 at 02:33:48PM +0200, Ludovic Desroches wrote:
> > On Wed, Jun 17, 2015 at 09:55:56AM -0600, Stephen Warren wrote:
> > > On 06/17/2015 06:38 AM, Ludovic Desroches wrote:
> > > >Hi Stephen,
> > > >
> > > >On Mon, Jun 15, 2015 at 09:58:05AM -0600, Stephen Warren wrote:
> > > >>On 06/10/2015 09:04 AM, Ludovic Desroches wrote:
> > > >>>When having a controller which allows per pin muxing, declaring with
> > > >>>which groups a function can be used is a useless constraint since groups
> > > >>>are something virtual.
> > > >>
> > > >>This isn't true.
> > > >>
> > > >>Irrespective of whether a particular piece of pinmux HW can control the mux
> > > >>function for each pin individually, or only in groups, it's quite likely
> > > >>that each function can only be selected onto a subset of those pins or
> > > >>groups. Requiring the pinctrl driver to inform the core which set of
> > > >>pins/groups particular functions can be selected onto seems quite
> > > >>reasonable.
> > > >>
> > > >>In my opinion at least, for HW that can select the mux function at the
> > > >>per-pin level, the only sensible set of groups is one group per pin with
> > > >>each group containing a single pin. Any other use of groups is a
> > > >>SW/user-level construct, and is something unrelated to why the pinctrl
> > > >>subsystem supports groups. If we want to represent those groups in pinctrl,
> > > >>there should be two separate sets of groups; one to represent the actual HW
> > > >>capabilities, and one to represent the SW/user-level convenience
> > > >>abstractions.
> > > >
> > > >Groups that I would like to use are not something related to the user or
> > > >software. It's an hardware reality but they would be more flexibles.
> > > >
> > > >Usually the muxing is done by selecting a function (which seems to be
> > > >device related: usart, spi, etc.), then you select on which pins you
> > > >want this function.
> > > >
> > > >In my case, I can't select a function only by choosing a mux. It is a
> > > >combination of the mux and the pin on which it is applied. So my
> > > >functions will be GPIO, A, B, C, etc. If I use function A on pin 12, I
> > > >will have my i2c clock signal but I can have this signal on pin 58 if I
> > > >use function C. Do you understand what I mean? It's not very easy to
> > > >explain... So here is a real example:
> > > >
> > > >  --------------------------------------------------
> > > >|              | pio peripheral                    |
> > > >  --------------------------------------------------
> > > >| signal | dir | func | signal       | dir | ioset |
> > > >  --------------------------------------------------
> > > >| PA8    | I/O | A    | SDMMC0_DAT6  | I/O | 1     |
> > > >|        |     | B    | QSPI1_IO1    | I/O | 1     |
> > > >|        |     | D    | TCLK5        | I   | 1     |
> > > >|        |     | E    | FLEXCOM2_IO2 | I/O | 1     |
> > > >|        |     | F    | NWE/NANDWE   | O   | 2     |
> > > >  --------------------------------------------------
> > > >| PD28   | I/O | A    | SPI1_NPCS0   | I/O | 3     |
> > > >|        |     | B    | TDI          | I/O | 3     |
> > > >|        |     | C    | FLEXCOM2_IO2 | I   | 2     |
> > > >  --------------------------------------------------
> > > >
> > > >
> > > >You are right that having a group per pin is a solution.
> > > >
> > > >If I follow your proposal (tell me if I'm wrong):
> > > >- I will have 128 groups since I have 128 pins.
> > > 
> > > Yes.
> > > 
> > > >- I will have functions GPIO, A, B, C, D, E, F.
> > > 
> > > You could have functions A..F, and require the user to determine what option
> > > they want for each pin, find the pin-specific mux function value for each
> > > pin, and put that into the DT (or other pinmux data source). For example,
> > > the bcm2835 pinctrl driver works this way.
> > > 
> > > In that case, each of the functions A..F could be selected on each pin, so
> > > you'd have a very simple "get pins for function" implementation.
> > > 
> > > Alternatively, you could define a logic function per IO controller or signal
> > > that gets pinmuxed. In the example above, FLEXCOM2_IO2 is one such example.
> > > Given that set of functions, you'd need a mapping table to convert from the
> > > logical functions seen by the pinctrl subsystem to the HW values that need
> > > to be written into registers. For example, the Tegra pinctrl drivers work
> > > this way.
> > > 
> > > In that case, each (pinctrl) function could only be selected on a specific
> > > subset of all pins/groups, and so you'd probably need a table-based
> > > implementation of "get pins for function".
> > 
> > Thanks for giving me some examples. Let's take a look at these drivers.
> > My concern is that I didnn't want to have many and/or big tables in my
> > driver. I will have to update it for a new SoC even if the pin
> > controller is the same. I prefer to have it in the device as we did
> > before and as some drivers continue to do.
> > 
> > > 
> > > >- I have to give the groups which can achieve a function so I will have
> > > >128 groups for each function. It means 128 x 7 = 896 groups.
> > > 
> > > I don't think so no. I'm not sure why you'd consider multiplying 128 and 7
> > > here. I'd expect 128 groups since you have 128 pins[1].
> > > 
> > 
> > Sorry my mistake, I mean 896 possibilites since I have 128 groups for a
> > function.
> > 
> > > Well, it's possible to have slightly more groups if, say, mux function is
> > > selectable per pin, whereas something else like drive strength is configured
> > > by a register that affects multiple pins at once. You'd need separate sets
> > > of groups for muxing and for drive strength configuration. Some Tegra SoCs
> > > are like this. Still, we just add the different sets of groups together
> > > here, not multiply. The overall set of groups is not that much larger than
> > > the set of pins.
> > > 
> > > >Does it seems to be something reasonable and intelligible? From my point
> > > >of view no. And what about the sysfs readability?
> > > >
> > > >With my current implementation, I have something quite understandable
> > > >for the user if he needs to check the pinmuxing:
> > > >
> > > >   # cat /sys/kernel/debug/pinctrl/ahb\:apb\:pinctrl at fc038000/pinmux-pins
> > > >   pin 17 (PA17): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> > > >   pin 18 (PA18): b0000000.sdio-host (GPIO UNCLAIMED) function E group sdmmc1_0
> > > >   pin 19 (PA19): b0000000.sdio-host (GPIO UNCLAIMED) function E group sdmmc1_0
> > > >
> > > >   # cat /sys/kernel/debug/pinctrl/pinctrl-maps
> > > >   Pinctrl maps:
> > > >
> > > >   device b0000000.sdio-host
> > > >   state default
> > > >   type MUX_GROUP (2)
> > > >   controlling device ahb:apb:pinctrl at fc038000
> > > >   group sdmmc1_0
> > > >   function E
> > > >
> > > >   device b0000000.sdio-host
> > > >   state default
> > > >   type CONFIGS_PIN (3)
> > > >   controlling device ahb:apb:pinctrl at fc038000
> > > >   pin PA28
> > > >   config 00010003
> > > >
> > > >   device b0000000.sdio-host
> > > >   state default
> > > >   type CONFIGS_PIN (3)
> > > >   controlling device ahb:apb:pinctrl at fc038000
> > > >   pin PA18
> > > >   config 00010003
> > > >
> > > >
> > > >Doing as you propose, I assume the result should be:
> > > >
> > > >   # cat /sys/kernel/debug/pinctrl/ahb\:apb\:pinctrl at fc038000/pinmux-pins
> > > >   pin 17 (PA17): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> > > >   pin 18 (PA18): b0000000.sdio-host (GPIO UNCLAIMED) function E group PA18
> > > >   pin 19 (PA19): b0000000.sdio-host (GPIO UNCLAIMED) function E group PA19
> > > >
> > > >   # cat /sys/kernel/debug/pinctrl/pinctrl-maps
> > > >   Pinctrl maps:
> > > >
> > > >   device b0000000.sdio-host
> > > >   state default
> > > >   type MUX_GROUP (2)
> > > >   controlling device ahb:apb:pinctrl at fc038000
> > > >   group PA28
> > > >   function E
> > > >
> > > >   device b0000000.sdio-host
> > > >   state default
> > > >   type CONFIGS_PIN (3)
> > > >   controlling device ahb:apb:pinctrl at fc038000
> > > >   pin PA28
> > > >   config 00010003
> > > >
> > > >   device b0000000.sdio-host
> > > >   state default
> > > >   type MUX_GROUP (2)
> > > >   controlling device ahb:apb:pinctrl at fc038000
> > > >   group PA18
> > > >   function E
> > > >
> > > >   device b0000000.sdio-host
> > > >   state default
> > > >   type CONFIGS_PIN (3)
> > > >   controlling device ahb:apb:pinctrl at fc038000
> > > >   pin PA18
> > > >   config 00010003
> > > >
> > > >I think it is more difficult to understand what is done here.
> > > 
> > > I don't think I agree. The HW level groups are the individual pins, so I
> > > think the second option is clearer and more correct. What is the "sdmmc1_0"
> > > group in the first example? Does any such thing even exist in HW?
> > 
> > If a user see this, I will have to take the datasheet to undersand what
> > using function E on this pin really means.
> > 
> > sdmmc1_0 group doesn't really exists as a group but a collection of
> > pins. The minimum requirement is to have CK, CMD and DAT0 signals. The
> > user can choose if he wants to use DAT1,2,3,4,5,6,7 and CD. Maybe he
> > would like to keep this pins available for another function.
> > 
> > This is what I have in my device tree.
> > 
> > pinctrl at fc038000 {
> > 	group_defs {
> > 		sdmmc1_0 {
> > 			pins = <PIN_PA22__SDMMC1_CK>,
> > 			       <PIN_PA28__SDMMC1_CMD>,
> > 			       <PIN_PA18__SDMMC1_DAT0>,
> > 			       <PIN_PA19__SDMMC1_DAT1>,
> > 			       <PIN_PA20__SDMMC1_DAT2>,
> > 			       <PIN_PA21__SDMMC1_DAT3>,
> > 			       <PIN_PA30__SDMMC1_CD>;
> > 		};
> > 	};
> > 
> > 	pinctrl_sdmmc1_default: sdmmc1_default {
> > 		mux {
> > 			function = "E";
> > 			groups = "sdmmc1_0";
> > 		};
> > 
> > 		conf-cmd_data {
> > 			pins = <PIN_PA28__SDMMC1_CMD>,
> > 			       <PIN_PA18__SDMMC1_DAT0>,
> > 			       <PIN_PA19__SDMMC1_DAT1>,
> > 			       <PIN_PA20__SDMMC1_DAT2>,
> > 			       <PIN_PA21__SDMMC1_DAT3>;
> > 			bias-pull-up;
> > 		};
> > 
> > 		conf-ck_cd {
> > 			pins = <PIN_PA22__SDMMC1_CK>,
> > 			       <PIN_PA30__SDMMC1_CD>;
> > 			bias-disable;
> > 		};
> > 	};
> > }
> > 
> > From my point of view, it is not so far from what generic pinconf does.
> > The only addition is the group_defs node because I don't want SoC
> > dependant tables in my driver.
> 
> +1 for not having SoC dependent tables in the driver. This additional
> indirection makes the pinctrl drivers quite big and hard to follow.
> 
> However, I don't understand why you need the group_defs node. I can
> understand why having this may be helpful in the code, but otherwise it
> doesn't contain any new information. It basically collects all pins also
> contained in the sdmmc1_default node, so this information can be
> retrieved there.

You are right, I don't really need the group_defs node, I did it in this way
because I wanted to split pinmux and pinconf and I didn't want to
implement my own dt_node_to_map() function but to use the
pinconf_generic_dt_node_to_map_all() one.

> The "Function E" seems rather uninteresting since not
> all pins have to be configured in function E. I bet it's possible to
> implement card detection as gpio and then you'll have PIN_PA30__GPIO_X_Y
> which is not function E.

No with our new sdhci device, card detection is not a gpio. Groups
definition has to be done in order to have the same function for all the
pins of the group.

A full example here:
https://github.com/linux4sam/linux-at91/blob/master/arch/arm/boot/dts/at91-sama5d2_xplained.dts

> 
> So my take is: remove the group_defs node.
> 
> Note that in the recently introduced Mediatek pinctrl driver we used
> 'pinmux' for the property that you name 'pins' here. We probably want to
> use the same name.

This driver fits most of my needs but I didn't do it in this way for the
two previous reasons. If it is not an issue to add a new
dt_node_to_map() implementation which should be quite close to the
mediatek one, let's do it.

Regards

Ludovic
