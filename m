From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 24 Oct 2012 21:49:45 +0200
Subject: [PATCH 1/9] ARM: Kirkwood: Convert TS219 to pinctrl.
In-Reply-To: <20121024213128.2d4c07dc@skate>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>	<1351090434-30499-2-git-send-email-andrew@lunn.ch>
 <20121024213128.2d4c07dc@skate>
Message-ID: <50884659.1020208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 09:31 PM, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
>
> On Wed, 24 Oct 2012 16:53:46 +0200, Andrew Lunn wrote:
>
>> +			pinctrl-0 =<  &pmx_uart0&pmx_uart1&pmx_spi
>> +				&pmx_twsi0&pmx_sata0&pmx_sata1
>> +				&pmx_ram_size&pmx_reset_button
>> +				&pmx_USB_copy_button&pmx_board_id>;
>
> It would be really better to have those under each device, rather than
> globally declared here. For some devices such as UARTs, it is not yet
> possible with the 8250 driver to associate pinctrl pins (but I'm
> planning to work on that soon). However for the other drivers (SPI,
> TWSI, SATA, button), it should be possible.

Thomas,

Agree, but for now a global pinhog on pinctrl node itself is the correct
way to go here. As soon as there is pinctrl support in the specific
device drivers we can move pinmux phandle there.

>> +			pmx_uart0: pmx-uart0 {
>> +				marvell,pins = "mpp10", "mpp11";
>> +				marvell,function = "uart0";
>> +			};
 >> ...
>
> All those definitions are not board specific, they are common to the
> SoC. So they should be in the corresponding .dtsi file.
>
> Basically:
>
>   * The SoC .dtsi file should define all the pinmux groups that are
>     described in the datasheet and are used by boards. I.e, there may be
>     conflicting groups defined, where one group configures pin X with
>     function Y, while another group configures pin X with function Z.

Here I disagree. Even quite simple interfaces like uart can have dozens
of possible mpp configurations, e.g. rx/tx on up to three different pins
each plus rts/cts on various pins plus all possible combinations.

Now consider some more complex interface with more than one mpp pin per
interface pin. Do you really want to predefine all possible combinations
even if it is more likely that in fact only one is used on all boards
because they are all based on the same reference design?

>   * The board .dts file should define the pinmux groups that are really
>     board-specific (buttons, LEDs, etc.), and then for each device,
>     point to the correct pinmux group (either defined in the .dtsi file
>     or in the board file).

With respect to mpp the actual configuration _is_ board specific. There
are maybe only some pins that are always used if a specific interface is
used, e.g. nand pins on dove can only be switched with gpio.

Sebastian
