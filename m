From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Oct 2012 10:42:53 +0100 (BST)
Subject: [PATCH 3/9] ARM: Kirkwood: Convert dnskw to pinctrl
In-Reply-To: <20121026060151.GE21046@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-4-git-send-email-andrew@lunn.ch>
 <alpine.DEB.2.02.1210252352360.22302@gonzo> <20121026060151.GE21046@lunn.ch>
Message-ID: <alpine.DEB.2.00.1210261016190.10589@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Oct 2012, Andrew Lunn wrote:

> On Thu, Oct 25, 2012 at 11:58:37PM +0100, Jamie Lentin wrote:
>> Thanks for doing all this. Some typos to fix, I've commented below
>> but I thought it might be easier to push a version for you to steal.
>> It's here:
>>
>> git://github.com/lentinj/linux.git v3.7-rc2-pinctrl
>> https://raw.github.com/lentinj/linux/v3.7-rc2-pinctrl/arch/arm/boot/dts/kirkwood-dnskw.dtsi
>
> Thanks. I will probably squash the three patches into my original, and
> add a Signed-off-by: if that is O.K. for you.
>

Sounds good.

>>
>> Tested on a DNS-320, not a DNS-325 yet.
>>
>> Similar to lsxl_init, the custom GPIO registrations fail:-
>>
>> dnskw: failed to configure power-off GPIO
>> dnskw: Failed to register dnskw:power:sata0
>> dnskw: Failed to register dnskw:power:sata1
>> dnskw: Failed to register dnskw:power:recover
>>
>> So I guess they will need a new home somewhere.
>
> I hope to look at this problem this weekend. Maybe a gpio regulator
> could be a solution, or loading the pinctrl stuff earlier. We will
> see.
>

I did look at using the gpio-regulator stuff a while back, and decided it 
wasn't quite the right shape. Although I can't remember why, and it might 
have changed since.

The power-off GPIO registration could happen in dnskw_power_off instead, 
or the attempt at a gpio-poweroff driver could be resurrected (I'd 
forgotten about it until now).

I could accept dnskw:power:recover is a weirdo configuration option that 
should be set in the bootloader / userland rather than the kernel 
supporting it. Although it would be nice if the kernel registered it's 
purpose. Maybe GPIO pins could be exported by adding sub-nodes to the GPIO 
chip, if that's not too hackish?

>> However most things (fan, buttons, SATA detect/power via sysfs,
>> power via sysfs) work. The key thing that doesn't is LEDs.
>> Registration looks reasonable:
>>
>> Registered led device: dns320:blue:power
>> kirkwood-pinctrl f1010000.pinctrl: request pin 43 (PIN43) for mvebu-gpio:43
>> Registered led device: dns320:blue:usb
>> kirkwood-pinctrl f1010000.pinctrl: request pin 28 (PIN28) for mvebu-gpio:28
>> Registered led device: dns320:orange:l_hdd
>> kirkwood-pinctrl f1010000.pinctrl: request pin 27 (PIN27) for mvebu-gpio:27
>> Registered led device: dns320:orange:r_hdd
>> kirkwood-pinctrl f1010000.pinctrl: request pin 35 (PIN35) for mvebu-gpio:35
>> Registered led device: dns320:orange:usb
>>
>> However setting brightness on/off does the following:
>> cat /sys/class/leds/dns320\:blue\:power/trigger
>>
>> dns320:blue:power - No effect, LED continues to blink as bootloader
>> configures it
>> dns320:orange:l_hdd - Works fine
>> dns320:orange:r_hdd - Works fine
>> dns320:orange:usb - Turns on, turning off locks NAS hard
>> dns320:blue:usb - Turns on, turning off locks NAS hard
>>
>> Any ideas?
> First thing that comes to mind, is it registering them for the correct
> GPIO controller. I think with the new setup, pinctrl and gpio are
> closely linked, so maybe, its modifying pins on the wrong controller.
> Bit of a long shot....
>

I did wonder that, but then why would turning the LEDs on work fine? I 
wonder if both pins are being toggled or something. I'll investigate 
further and report back. The two that cause the NAS to lock up are the 
only ones on &gpio1 though.

>>> 	ocp at f1000000 {
>>> +		pinctrl: pinctrl at 10000 {
>>> +			compatible = "marvell,88f6281-pinctrl";
>>> +			reg = <0x10000 0x20>;
>>> +
>>> +			pinctrl-0 = < &pmx_uart1 &pmx_sata1
>>
>> Need a &pmx_sata0 too (see below).
>
> I just turned the existing MPP setup into pinctrl. Things like SATA,
> SPI pins, etc, i left alone if they were not configured in the old C
> code. I've no problems adding them here.
>
>>
>>> +				      &pmx_gpio_24 &pmx_gpio_25
>>> +				      &pmx_led_power &pmx_led_power
>>
>> Shouldn't be repeated, I'm guessing.
>>
>>> +				      &pmx_led_red_right_hdd
>>> +				      &pmx_led_red_left_hdd
>>> +				      &pmx_led_red_usb_325
>>> +				      &pmx_gpio_30 &pmx_gpio_31
>>> +				      &pmx_gpio_32 &pmx_gpio_33
>>> +				      &pmx_button_power
>>> +				      &pmx_led_red_usb_320
>>> +				      &pmx_power_off &pmx_power_back_on
>>> +				      &pmx_power_sata0 &pmx_power_sata1
>>> +				      &pmx_present_sata0 &pmx_present_sata1
>>> +				      &pmx_led_white_usb &pmx_fan_tacho
>>> +				      &pmx_fan_high_speed &pmx_fan_low_speed
>>> +				      &pmx_button_unmount &pmx_button_reset
>>> +				      &pmx_temp_alarm >;
>>> +			pinctrl-names = "default";
>>> +
>>> +			pmx_uart1: pmx-uart1 {
>>> +				marvell,pins = "mpp13", "mpp14";
>>> +				marvell,function = "uart1";
>>> +			};
>>> +			pmx_sata1: pmx-sata1 {
>>> +				marvell,pins = "mpp4", "mpp20", "mpp22";
>>
>> mpp4 is for the NAND. I'm guessing mpp22 should be mpp21, but this
>> should have the "sata0" function.
>
>        MPP_MODE(4,
>                MPP_VAR_FUNCTION(0x0, "gpio", NULL,      V(1, 1, 1, 1, 1)),
>                MPP_VAR_FUNCTION(0x1, "nand", "io6",     V(1, 1, 1, 1, 1)),
>                MPP_VAR_FUNCTION(0x2, "uart0", "rxd",    V(1, 1, 1, 1, 1)),
>                MPP_VAR_FUNCTION(0x5, "sata1", "act",    V(0, 0, 1, 1, 1)),
>                MPP_VAR_FUNCTION(0xb, "lcd", "hsync",    V(0, 0, 0, 0, 1)),
>                MPP_VAR_FUNCTION(0xd, "ptp", "clk",      V(1, 1, 1, 1, 0))),
>
> 4 can be both NAND and SATA. It looks like NAND has to use pins
> mpp0-mpp5,mpp18-mmp19, they are not available anywhere else. SATA1 is
> duplicated, so we have to be careful to get the right pins.
>

The sata0 and sata1 activity leds are definitely MPP20 and MPP21---I've 
set them up as GPIO leds before successfully.

> Maybe boot the old kernel and look these lines:
>
> [   16.187814] initial MPP regs: 01112222 43303311 55550000 00000000 00000000 00000000 00000000
> [   16.187833]   final MPP regs: 01552222 03303311 55550000 00000000 00000000 00000000 00000000
>
> The first line is how uboot setup the MPP pins. The second is after
> the init function was called.

initial MPP regs: 01111111 03303311 00551100 00000000 00000000 00000000 00000000
   final MPP regs: 01111111 03303311 00551100 00000000 00000000 00000000 00000000

Although the initial MPP regs is also set by a recompiled u-boot with 
~identical MPP setup code.

>
>    Andrew
>

-- 
Jamie Lentin
