From: noralf@tronnes.org (=?windows-1252?Q?Noralf_Tr=F8nnes?=)
Date: Thu, 07 May 2015 19:28:23 +0200
Subject: [PATCH 2/3 v8] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <1430857666-18877-2-git-send-email-eric@anholt.net>
References: <1430857666-18877-1-git-send-email-eric@anholt.net>
 <1430857666-18877-2-git-send-email-eric@anholt.net>
Message-ID: <554BA0B7.8040600@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 05.05.2015 22:27, skrev Eric Anholt:
> From: Lubomir Rintel <lkundrak@v3.sk>
>
> This mailbox driver provides a single mailbox channel to write 32-bit
> values to the VPU and get a 32-bit response.  The Raspberry Pi
> firmware uses this mailbox channel to implement firmware calls, while
> Roku 2 (despite being derived from the same firmware tree) doesn't.
>
> The driver was originally submitted by Lubomir, based on the
> out-of-tree 2708 mailbox driver.  Eric Anholt fixed it up for
> upstreaming, with the major functional change being that it now has no
> notion of multiple channels (since that is a firmware-dependent
> concept) and instead the raspberrypi-firmware driver will do that
> bit-twiddling in its own messages.
...
> +static struct platform_driver bcm2835_mbox_driver = {
> +	.driver = {
> +		.name = "bcm2835-mbox",
> +		.owner = THIS_MODULE,
> +		.of_match_table = bcm2835_mbox_of_match,
> +	},
> +	.probe		= bcm2835_mbox_probe,
> +	.remove		= bcm2835_mbox_remove,
> +};
> +module_platform_driver(bcm2835_mbox_driver);

I have tested this driver and the firmware driver booting directly
from the VideoCore bootloader (no uboot).
The mailbox driver loads too late to turn on USB power:

[    0.754258] platform soc:firmware: Driver raspberrypi-firmware 
requests probe deferral

[    2.041136] dwc2 20980000.usb: 256 invalid for 
host_nperio_tx_fifo_size. Check HW configuration.
[    2.050058] dwc2 20980000.usb: 512 invalid for 
host_perio_tx_fifo_size. Check HW configuration.
[    4.140894] dwc2 20980000.usb: dwc2_core_reset() HANG! Soft Reset 
GRSTCTL=80000001
[    4.148583] dwc2 20980000.usb: dwc2_core_init(): Reset failed, aborting
[    4.155281] dwc2 20980000.usb: dwc2_hcd_init() FAILED, returning -16
[    4.161720] dwc2: probe of 20980000.usb failed with error -16

[    4.272027] bcm2835-mbox 2000b880.mailbox: mailbox enabled


When I move mailbox module init to arch_initcall, USB power is turned on.

[    0.548481] bcm2835-mbox 2000b880.mailbox: mailbox enabled

[    1.733669] raspberrypi_firmware_set_power  *** I have added this
[    2.242699] USB: Power-on latency exceeded, new value 509026000 ns
[    3.109748] dwc2 20980000.usb: DWC OTG Controller
[    3.114690] dwc2 20980000.usb: new USB bus registered, assigned bus 
number 1
[    3.121890] dwc2 20980000.usb: irq 33, io mem 0x00000000

This silences the warning:
struct raspberrypi_power_domain raspberrypi_power_domain_usb = {
     .base = {
         .power_on_latency_ns = 600000000,


Noralf.
