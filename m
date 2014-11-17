From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 17 Nov 2014 09:48:04 +0100
Subject: [PATCHv2 7/8] arm: mvebu: add .dts file for Synology DS213j
In-Reply-To: <20141117012906.GA23536@lunn.ch> (Andrew Lunn's message of "Mon,
 17 Nov 2014 02:29:06 +0100")
References: <cover.1416158990.git.arno@natisbad.org>
 <9a6ba2383c1a4ce9fad3f7c15b23050e67409178.1416158990.git.arno@natisbad.org>
 <20141117012906.GA23536@lunn.ch>
Message-ID: <874mtyrz5n.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Andrew Lunn <andrew@lunn.ch> writes:

> On Sun, Nov 16, 2014 at 06:37:54PM +0100, Arnaud Ebalard wrote:
>> +				sata1_pres_pin: sata1-pres-pin {
>> +					marvell,pins = "mpp60";
>> +					marvell,function = "gpio";
>> +				};
>> +
>> +				sata2_pres_pin: sata2-pres-pin {
>> +					marvell,pins = "mpp48";
>> +					marvell,function = "gpio";
>> +				};
>
> Hi Arnaud
>
> Are they above correct?
>
>        MPP_MODE(48,
>            MPP_FUNCTION(0x0, "gpio", NULL),
>            MPP_FUNCTION(0x1, "dev", "ad9"),
>            MPP_FUNCTION(0x2, "uart0", "rts"),
>            MPP_FUNCTION(0x3, "sd0", "cmd"),
>            MPP_FUNCTION(0x4, "sata1", "prsnt"),
>            MPP_FUNCTION(0x5, "spi0", "cs1")),
>
> and
>
>         MPP_MODE(60,
>            MPP_FUNCTION(0x0, "gpio", NULL),
>            MPP_FUNCTION(0x1, "dev", "ale1"),
>            MPP_FUNCTION(0x2, "uart1", "rxd"),
>            MPP_FUNCTION(0x3, "sata0", "prsnt"),
>            MPP_FUNCTION(0x4, "pcie", "rst-out"),
>            MPP_FUNCTION(0x5, "audio", "sdi")),
>
> Seems like function sata[01] would be better than gpio.
>
> Also, i don't see you using these anywhere.

The main reason is that I have (still a draft version of) a patch that
adds a small feature to fixed regulator; the idea is to add an input
signal (gpio/interrupt) to be able to start/stop the regulator. I have
tested it on my RN102 and it works as expected.

ATM, disks on RN102, RN104 and RN2120 are powered by u-boot and I did
not add fixed regulators to have Linux kernel do it. This means if you
add a disk after boot which was not there at boot, it will not be
powered. If you remove a disk that was there at boot, power will still
be available.

With Synology NAS, it's a bit different: you need a fixed regulator to
power the disks because u-boot will not start them, AFAICT.

In the end, the sata presence pins are declared as gpio in order to be
able to use them as input signal for a modified fixed regulator. It's
also to document their existence.

I have nothing against changing the function to sata[01] but how will
those be used, by whom?


> There are a few files in /sys which you might find interesting.
>
> /sys/kernel/debug/pinctrl/f1018000.pinctrl/pinconf-groups shows you
> how pins are currently defined. These can be how Linux has set them,
> or if Linux has not touched them, how the boot loader set them.
>
> /sys/kernel/debug/pinctrl/f1018000.pinctrl/pinmux-pins shows you what
> has been claimed by Linux, either as a gpio or for a specific
> function.

Will take a look.


> There are two schools of thoughts for pinctl. One is to leave the
> bootloader to configure the pins, and Linux should use them as they
> are. The other is that Linux should not trust the bootloader and
> configure the pins itself. With kirkwood we have tried to configure
> everything in Linux. I also think for these two boards, we should
> configure everything. The reason being the broken bootloader. I
> suspect because of the saveenv corruption, more than average are going
> to install a new uboot, or barebox image. A generic uboot might not
> get the pinctl correct, and a barebox image will be using the dtb blob
> to configure the pins. So it would be good to see that all pins which
> are used and claimed by a driver.

I think I prefer second school. Relying on u-boot/barebox doing things
may break at next bootloader update. 

Cheers,

a+
