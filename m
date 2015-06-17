From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Jun 2015 09:55:56 -0600
Subject: [RESEND PATCH 1/2] pinctrl: change function behavior for per
 pin muxing controllers
In-Reply-To: <20150617123816.GB12295@odux.rfo.atmel.com>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
 <1433948699-19800-2-git-send-email-ludovic.desroches@atmel.com>
 <557EF60D.8020007@wwwdotorg.org> <20150617123816.GB12295@odux.rfo.atmel.com>
Message-ID: <5581988C.50000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2015 06:38 AM, Ludovic Desroches wrote:
> Hi Stephen,
>
> On Mon, Jun 15, 2015 at 09:58:05AM -0600, Stephen Warren wrote:
>> On 06/10/2015 09:04 AM, Ludovic Desroches wrote:
>>> When having a controller which allows per pin muxing, declaring with
>>> which groups a function can be used is a useless constraint since groups
>>> are something virtual.
>>
>> This isn't true.
>>
>> Irrespective of whether a particular piece of pinmux HW can control the mux
>> function for each pin individually, or only in groups, it's quite likely
>> that each function can only be selected onto a subset of those pins or
>> groups. Requiring the pinctrl driver to inform the core which set of
>> pins/groups particular functions can be selected onto seems quite
>> reasonable.
>>
>> In my opinion at least, for HW that can select the mux function at the
>> per-pin level, the only sensible set of groups is one group per pin with
>> each group containing a single pin. Any other use of groups is a
>> SW/user-level construct, and is something unrelated to why the pinctrl
>> subsystem supports groups. If we want to represent those groups in pinctrl,
>> there should be two separate sets of groups; one to represent the actual HW
>> capabilities, and one to represent the SW/user-level convenience
>> abstractions.
>
> Groups that I would like to use are not something related to the user or
> software. It's an hardware reality but they would be more flexibles.
>
> Usually the muxing is done by selecting a function (which seems to be
> device related: usart, spi, etc.), then you select on which pins you
> want this function.
>
> In my case, I can't select a function only by choosing a mux. It is a
> combination of the mux and the pin on which it is applied. So my
> functions will be GPIO, A, B, C, etc. If I use function A on pin 12, I
> will have my i2c clock signal but I can have this signal on pin 58 if I
> use function C. Do you understand what I mean? It's not very easy to
> explain... So here is a real example:
>
>   --------------------------------------------------
> |              | pio peripheral                    |
>   --------------------------------------------------
> | signal | dir | func | signal       | dir | ioset |
>   --------------------------------------------------
> | PA8    | I/O | A    | SDMMC0_DAT6  | I/O | 1     |
> |        |     | B    | QSPI1_IO1    | I/O | 1     |
> |        |     | D    | TCLK5        | I   | 1     |
> |        |     | E    | FLEXCOM2_IO2 | I/O | 1     |
> |        |     | F    | NWE/NANDWE   | O   | 2     |
>   --------------------------------------------------
> | PD28   | I/O | A    | SPI1_NPCS0   | I/O | 3     |
> |        |     | B    | TDI          | I/O | 3     |
> |        |     | C    | FLEXCOM2_IO2 | I   | 2     |
>   --------------------------------------------------
>
>
> You are right that having a group per pin is a solution.
>
> If I follow your proposal (tell me if I'm wrong):
> - I will have 128 groups since I have 128 pins.

Yes.

> - I will have functions GPIO, A, B, C, D, E, F.

You could have functions A..F, and require the user to determine what 
option they want for each pin, find the pin-specific mux function value 
for each pin, and put that into the DT (or other pinmux data source). 
For example, the bcm2835 pinctrl driver works this way.

In that case, each of the functions A..F could be selected on each pin, 
so you'd have a very simple "get pins for function" implementation.

Alternatively, you could define a logic function per IO controller or 
signal that gets pinmuxed. In the example above, FLEXCOM2_IO2 is one 
such example. Given that set of functions, you'd need a mapping table to 
convert from the logical functions seen by the pinctrl subsystem to the 
HW values that need to be written into registers. For example, the Tegra 
pinctrl drivers work this way.

In that case, each (pinctrl) function could only be selected on a 
specific subset of all pins/groups, and so you'd probably need a 
table-based implementation of "get pins for function".

> - I have to give the groups which can achieve a function so I will have
> 128 groups for each function. It means 128 x 7 = 896 groups.

I don't think so no. I'm not sure why you'd consider multiplying 128 and 
7 here. I'd expect 128 groups since you have 128 pins[1].

Well, it's possible to have slightly more groups if, say, mux function 
is selectable per pin, whereas something else like drive strength is 
configured by a register that affects multiple pins at once. You'd need 
separate sets of groups for muxing and for drive strength configuration. 
Some Tegra SoCs are like this. Still, we just add the different sets of 
groups together here, not multiply. The overall set of groups is not 
that much larger than the set of pins.

> Does it seems to be something reasonable and intelligible? From my point
> of view no. And what about the sysfs readability?
>
> With my current implementation, I have something quite understandable
> for the user if he needs to check the pinmuxing:
>
>    # cat /sys/kernel/debug/pinctrl/ahb\:apb\:pinctrl at fc038000/pinmux-pins
>    pin 17 (PA17): (MUX UNCLAIMED) (GPIO UNCLAIMED)
>    pin 18 (PA18): b0000000.sdio-host (GPIO UNCLAIMED) function E group sdmmc1_0
>    pin 19 (PA19): b0000000.sdio-host (GPIO UNCLAIMED) function E group sdmmc1_0
>
>    # cat /sys/kernel/debug/pinctrl/pinctrl-maps
>    Pinctrl maps:
>
>    device b0000000.sdio-host
>    state default
>    type MUX_GROUP (2)
>    controlling device ahb:apb:pinctrl at fc038000
>    group sdmmc1_0
>    function E
>
>    device b0000000.sdio-host
>    state default
>    type CONFIGS_PIN (3)
>    controlling device ahb:apb:pinctrl at fc038000
>    pin PA28
>    config 00010003
>
>    device b0000000.sdio-host
>    state default
>    type CONFIGS_PIN (3)
>    controlling device ahb:apb:pinctrl at fc038000
>    pin PA18
>    config 00010003
>
>
> Doing as you propose, I assume the result should be:
>
>    # cat /sys/kernel/debug/pinctrl/ahb\:apb\:pinctrl at fc038000/pinmux-pins
>    pin 17 (PA17): (MUX UNCLAIMED) (GPIO UNCLAIMED)
>    pin 18 (PA18): b0000000.sdio-host (GPIO UNCLAIMED) function E group PA18
>    pin 19 (PA19): b0000000.sdio-host (GPIO UNCLAIMED) function E group PA19
>
>    # cat /sys/kernel/debug/pinctrl/pinctrl-maps
>    Pinctrl maps:
>
>    device b0000000.sdio-host
>    state default
>    type MUX_GROUP (2)
>    controlling device ahb:apb:pinctrl at fc038000
>    group PA28
>    function E
>
>    device b0000000.sdio-host
>    state default
>    type CONFIGS_PIN (3)
>    controlling device ahb:apb:pinctrl at fc038000
>    pin PA28
>    config 00010003
>
>    device b0000000.sdio-host
>    state default
>    type MUX_GROUP (2)
>    controlling device ahb:apb:pinctrl at fc038000
>    group PA18
>    function E
>
>    device b0000000.sdio-host
>    state default
>    type CONFIGS_PIN (3)
>    controlling device ahb:apb:pinctrl at fc038000
>    pin PA18
>    config 00010003
>
> I think it is more difficult to understand what is done here.

I don't think I agree. The HW level groups are the individual pins, so I 
think the second option is clearer and more correct. What is the 
"sdmmc1_0" group in the first example? Does any such thing even exist in HW?

> I have sent patches months ago trying to improve things by having
> something more flexible. I don't think I introduce too big changes.
> The only answers I got were from people thinking that pinctrl framework
> conception is not good to fit all kind of controllers. I re-sent the
> patch series to gain more expose and have no  answer...

I don't see anything in your description which implies pinctrl isn't 
perfectly suitable for your HW.

Note that I'm on vacation for a couple weeks soon, and I don't expect to 
follow this conversation during that time. Ultimately, LinusW owns the 
pinctrl subsystem, and you need to convince him of any changes.
