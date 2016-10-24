From: david@lechnology.com (David Lechner)
Date: Mon, 24 Oct 2016 10:50:21 -0500
Subject: [PATCH 5/5] ARM: dts: Add LEGO MINDSTORTMS EV3 dts
In-Reply-To: <b0022fad-a96e-86d4-71ba-2b803e5421fe@ti.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
 <1477075018-20176-6-git-send-email-david@lechnology.com>
 <b0022fad-a96e-86d4-71ba-2b803e5421fe@ti.com>
Message-ID: <1593441f-d147-4c91-8aab-8622dd8ced19@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 06:58 AM, Sekhar Nori wrote:
> On Saturday 22 October 2016 12:06 AM, David Lechner wrote:
>> This adds a device tree definition file for LEGO MINDSTORMS EV3.
>
> Thanks for the patch!
>
>>
>> What is working:
>>
>> * Pin muxing
>> * MicroSD card reader
>> * UART on input port 1
>>
>> What is partially working:
>>
>> * Buttons - working after GPIO fix
>> * LEDs - working after GPIO fix
>> * Poweroff/reset - working after GPIO fix
>
> Is the GPIO fix something that will go in v4.9-rc cycle ?

Not sure. This is still being discussed.

http://www.gossamer-threads.com/lists/linux/kernel/2550178

>
>> * Flash memory - driver loads but can't read the block devices - this is
>>   probably due to the fact that we are not able to configure the SPI to
>>   use DMA via device tree
>
> Hmm, I would not have expected PIO mode to be so inefficient that you
> are unable to even read the block device.

I am getting a -EIO error. I haven't been able to trace down exactly 
what is causing it yet though.

>
...
>> +/ {
>> +	compatible = "lego,ev3", "ti,da850";
>> +	model = "LEGO MINDSTORMS EV3";
>> +
>> +	soc at 1c00000 {
>> +		/*
>> +		 * (ab)using pinctrl-single to disable all internal pullups/
>> +		 * pulldowns on I/O.
>> +		 */
>> +		pinmux at 22c00c {
>> +			compatible = "pinctrl-single";
>> +			reg = <0x22c00c 0x4>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			pinctrl-single,bit-per-mux;
>> +			pinctrl-single,register-width = <32>;
>> +			pinctrl-single,function-mask = <0xf>;
>> +			/*
>> +			 * There is a bug in pinctrl-single that prevents us
>> +			 * from setting function-mask to 1, so doing things
>> +			 * in groups of 4. Doesn't really matter since we are
>> +			 * disabling all at once anyway.
>> +			 */
>> +
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&pupu_disable>;
>> +
>> +			pupu_disable: pinmux_all_pins {
>> +				pinctrl-single,bits = <
>> +					0x0 0x00000000 0xffffffff
>> +				>;
>> +			};
>
> Sigh. This is quite an abuse :)
>
> I know we don't have a good way to configure this in kernel today. And I
> am surprised we never had to care about disabling pullups so far. Can
> you clarify why you need it? I assume there is some contention you want
> to avoid, but on which interface?

The EV3 was designed with external pullup/pulldown everywhere. I know 
for certain that it breaks one of the buttons if you do not disable the 
internal ones. I imagine that it would have subtle effects elsewhere if 
they are not disabled.

I have not gone through each pullup/pulldown bank individually, but it 
would not surprise me at all if there was at least one thing on most of 
them that would be adversely affected.

>
> I dont think this can be done this way using pinctrl-single. A small
> driver to handle pullup/down control for da850 may have to be added to
> drivers/pinctrl. It will be better to check with Linus Walleij on his
> thoughts using a new thread ccing the pinctrl subsystem list as well.

I will be glad to try to make a driver, but when I ran into this problem 
I could not find much information on how to handle banks of 
pullup/pulldown. Most of what I saw was for ones that can be 
individually controlled. If anyone knows something like this already 
that I could look at, it would be helpful to me.


> [...]
>
>> +	in1_pins: pinmux_in1_pins {
>> +		pinctrl-single,bits = <
>> +			/* GP0[15] */
>> +			0x0 0x00000008 0x0000000f
>> +			/* GP0[2] */
>> +			0x4 0x00800000 0x00f00000
>> +			/* GP2[2] */
>> +			0x18 0x00800000 0x00f00000
>> +			/* GP8[10], GP8[11] */
>> +			0x48 0x88000000 0xff000000
>> +		>;
>> +	};
>
> I see that this is not really used. Can you add these when you actually
> use them. Looks like that applies to some other definitions like this below.

It will be possible to uses these gpios via sysfs (until a proper driver 
for input and output ports is merged). So how about I attach these to 
the gpio node for now?

>
>> +&ehrpwm1 {
>> +	status = "disabled";
>
> Hmm, disabled? Can you add this node when you actually use it?

Not sure why I have this disabled. Like the gpios, the pwms can be used 
via sysfs, so I would like to leave them.

>
>> +	pinctrl-names = "default";
>> +	/* MBPWM, MAPWM */
>> +	pinctrl-0 = <&ehrpwm1a_pins>, <&ehrpwm1b_pins>;
>> +};
>> +
>> +&ecap1 {
>> +	status = "disabled";
>
> same here and other places below.
>
>> +	pinctrl-names = "default";
>> +	/* MDPWM */
>> +	pinctrl-0 = <&ecap1_pins>;
>> +};
>> +
>> +&spi0 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>, <&spi0_cs3_pin>;
>> +	dmas = <&edma0 14 0>, <&edma0 15 0>;
>> +	dma-names = "rx", "tx";
>> +
>> +	spi-flash at 0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "n25q128a13", "jedec,spi-nor";
>> +		reg = <0>;
>> +		spi-max-frequency = <50000000>;
>> +		ti,spi-wdelay = <8>;
>> +
>> +		partition at 0 {
>> +			label = "U-Boot";
>> +			reg = <0 0x40000>;
>
> Thats 256KB for U-Boot and MLO (I assume in concatenated AIS image). Is
> that sufficient for future too? Moving partitions later is tough ask
> because that means users will lose data when they upgrade the kernel
> because of partitions moving around. Just a suggestion to keep future
> U-Boot bloat in mind and not use a "just fits" number.

The MLO is on an EEPROM in the EV3, so the U-Boot partition is just 
U-boot. The SoC boots from I2C, which then runs whatever is as 0x0 on 
the flash memory.

This partition table matches the partition scheme used on the official 
LEGO firmware that ships with the devices. Most people running their own 
kernel will probably be loading it from a microSD card, leaving the 
official firmware intact and therefore will always have this partition 
table.

My thinking is that if someone does want to use a different partitioning 
scheme, they can build their own U-Boot and configure it to modify the 
device tree with a new partition table.

The way the LEGO firmware flashing utility works, it wipes out the 
entire flash memory each time you flash the firmware. So, data loss is 
not a concern - you will loose your data anyway.

>
>> +		};
>> +
>> +		partition at 40000 {
>> +			label = "U-Boot Env";
>> +			reg = <0x40000 0x10000>;
>> +		};
>> +
>> +		partition at 50000 {
>> +			label = "Kernel";
>> +			reg = <0x50000 0x200000>;
>> +		};
>> +
>> +		partition at 250000 {
>> +			label = "Filesystem";
>> +			reg = <0x250000 0xa50000>;
>> +		};
>> +
>> +		partition at cb0000 {
>> +			label = "Storage";
>> +			reg = <0xcb0000 0x2f0000>;
>> +		};
>> +	};
>> +
>> +	/* TODO: ADC goes here */
>
> I would drop this comment.

ack

>
>> +};
>> +
>> +&spi1 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&spi1_pins>, <&spi1_cs0_pin>;
>> +
>> +	/* TODO: LCD Display goes here */
>
> Add this node when you actually have display working.

What if we set this up as a spidev node instead? This way the display 
could be used from userspace without a driver.
