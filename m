From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 12 Nov 2017 16:13:44 +0100
Subject: spi->irq == 0 on module reload of driver using IRQF_TRIGGER_LOW
In-Reply-To: <20171112141349.6b4b3852@why.wild-wind.fr.eu.org>
References: <21FDD1B8-E8F6-4DCE-9D30-D82B713B0008@martin.sperl.org>
 <20171112141349.6b4b3852@why.wild-wind.fr.eu.org>
Message-ID: <CD4EBEF8-DDFD-40C3-A03E-7EC964B32357@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc!

> On 12.11.2017, at 15:13, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> On Sun, 12 Nov 2017 13:32:44 +0100
> <kernel@martin.sperl.org> wrote:
> 
> Martin,
> 
>> Hi!
>> 
>> During the development of a new spi driver on a raspberry pi CM1
>> I have seen an issue with the following code triggering strange behavior:
>> 
>> 	ret = request_threaded_irq(spi->irq, NULL,
>> 				   mcp2517fd_can_ist,
>> 				   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
>> 				   DEVICE_NAME, priv);
>> 
>> This works fine the first time the module is loaded (spi->irq is not 0),
>> but as soon as the module gets removed and reinstalled spi->irq is 0 
>> and I get the message in dmesg:
>> [ 1282.311991] irq: type mismatch, failed to map hwirq-16 for /soc/gpio at 7e200000!
>> 
>> This does not happen when using the IRQF_TRIGGER_FALLING flag.
>> 
>> in spi_drv_probe spi core does sets spi->dev to 0 in case 
>> of_irq_get returns < 0;
>> 
>> The specific code that triggers this message and return 0 is 
>> irq_create_fwspec_mapping.
>> 
>> After implementing: https://www.spinics.net/lists/arm-kernel/msg528469.html
>> and also checking for spi->irq == 0, I get:
>> 
>> [   87.867456] irq: type mismatch (2/8), failed to map hwirq-16 for /soc/gpio at 7e200000!
> 
> Well, you have the answer here: The interrupt has been configured with
> a falling edge trigger, while you're requesting a level low. Obviously,
> something is changing it.

It was configured as level on the first install/request and the driver is
not changed between rmmod and insmod, so it again requests level on the
second request.

> 
> It would be interesting to see both the driver code and the DT file
> where the interrupt is described?

The relevant patch to the device tree I am using:
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -107,3 +107,38 @@
        pinctrl-0 = <&uart0_gpio14>;
        status = "okay";
 };
+
+&gpio {
+      can0_pins: can0_pins {
+                brcm,pins = <16>;
+                brcm,function = <0>; /* input */
+      };
+};
+
+/ {
+            can0_osc: can0_osc {
+                compatible = "fixed-clock";
+                #clock-cells = <0>;
+                clock-frequency  = <4000000>;
+            };
+};
+
+&spi {
+            status = "okay";
+
+            can0: mcp2517fd at 0 {
+                reg = <0>;
+                compatible = "microchip,mcp2517fd";
+                pinctrl-names = "default";
+                pinctrl-0 = <&can0_pins>;
+                spi-max-frequency = <12500000>;
+                interrupt-parent = <&gpio>;
+                interrupts = <16 0x2>;
+                clocks = <&can0_osc>;
+                microchip,clock_div = <1>;
+                microchip,clock_out_div = <4>;
+                microchip,gpio0_mode = <1>;
+                microchip,gpio1_mode = <1>;
+                status = "okay";
+            };
+};

Here a very much trimmed down version of the driver 
(probably still contains too much code):
/*
 * CAN bus driver for Microchip 2517FD CAN Controller with SPI Interface
 *
 * Copyright 2017 Martin Sperl <kernel@martin.sperl.org>
 *
 * Based on Microchip MCP251x CAN controller driver written by
 * David Vrabel, Copyright 2006 Arcom Control Systems Ltd.
 *
 */

#include <linux/device.h>
#include <linux/interrupt.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/of_device.h>
#include <linux/platform_device.h>
#include <linux/slab.h>
#include <linux/spi/spi.h>
#include <linux/uaccess.h>

#define DEVICE_NAME "mcp2517fd"
#define CAN_MCP2517FD 0x2517f

static irqreturn_t mcp2517fd_can_ist(int irq, void *dev_id)
{
	return IRQ_HANDLED;
}

static const struct of_device_id mcp2517fd_of_match[] = {
	{ .compatible     = "microchip,mcp2517fd", },
	{ }
};
MODULE_DEVICE_TABLE(of, mcp2517fd_of_match);

static int mcp2517fd_can_probe(struct spi_device *spi)
{
	int ret;

	/* as irq_create_fwspec_mapping() can return 0, check for it */
	if (spi->irq <= 0) {
		dev_err(&spi->dev, "no valid irq line defined: irq = %i\n",
			spi->irq);
		return -EINVAL;
	}

	ret = request_threaded_irq(spi->irq, NULL,
				   mcp2517fd_can_ist,
				   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
//				   IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
				   DEVICE_NAME, NULL);
	if (ret)
		dev_err(&spi->dev, "failed to acquire irq %d - %i\n",
			spi->irq, ret);

	return ret;
}

static int mcp2517fd_can_remove(struct spi_device *spi)
{
	free_irq(spi->irq, NULL);

	return 0;
}

static struct spi_driver mcp2517fd_can_driver = {
	.driver = {
		.name = DEVICE_NAME,
		.of_match_table = mcp2517fd_of_match,
	},
	.probe = mcp2517fd_can_probe,
	.remove = mcp2517fd_can_remove,
};
module_spi_driver(mcp2517fd_can_driver);

MODULE_AUTHOR("Martin Sperl <kernel@martin.sperl.org>");
MODULE_DESCRIPTION("Microchip 2517FD CAN driver");
MODULE_LICENSE("GPL v2");

It is severely cut down (and not 100% clean), but it shows the behaviur already!
in the real driver the request_irq happens in a later stage?
But this way you do not require the HW to replicate it and it reduces components...

Here the example right after a reboot (but on a downstream 4.9 Kernel) 
with TRIGGER_FALLING:
root at raspcm:~# dmesg -C; rmmod mcp2517fd; insmod /tmp/mcp2517fd.ko; dmesg; grep mcp2517fd /proc/interrupts
rmmod: ERROR: Module mcp2517fd is not currently loaded
176:          0  pinctrl-bcm2835  16 Edge      mcp2517fd
root at raspcm:~# dmesg -C; rmmod mcp2517fd; insmod /tmp/mcp2517fd.ko; dmesg; grep mcp2517fd /proc/interrupts
176:          0  pinctrl-bcm2835  16 Edge      mcp2517fd
root at raspcm:~# dmesg -C; rmmod mcp2517fd; insmod /tmp/mcp2517fd.ko; dmesg; grep mcp2517fd /proc/interrupts
176:          0  pinctrl-bcm2835  16 Edge      mcp2517fd
root at raspcm:~# dmesg -C; rmmod mcp2517fd; insmod /tmp/mcp2517fd.ko; dmesg; grep mcp2517fd /proc/interrupts
176:          0  pinctrl-bcm2835  16 Edge      mcp2517fd

Here the example right after a reboot with TRIGGER_LOW:
root at raspcm:~# dmesg -C; rmmod mcp2517fd; insmod /tmp/mcp2517fd.ko; dmesg; grep mcp2517fd /proc/interrupts
rmmod: ERROR: Module mcp2517fd is not currently loaded
176:          0  pinctrl-bcm2835  16 Level     mcp2517fd
root at raspcm:~# dmesg -C; rmmod mcp2517fd; insmod /tmp/mcp2517fd.ko; dmesg; grep mcp2517fd /proc/interrupts
[   86.131543] irq: type mismatch (2/8), failed to map hwirq-16 for /soc/gpio at 7e200000!
[   86.131579] mcp2517fd spi0.0: no valid irq line defined: irq = 0
[   86.131634] mcp2517fd: probe of spi0.0 failed with error -22
root at raspcm:~# dmesg -C; rmmod mcp2517fd; insmod /tmp/mcp2517fd.ko; dmesg; grep mcp2517fd /proc/interrupts
[   87.390516] irq: type mismatch (2/8), failed to map hwirq-16 for /soc/gpio at 7e200000!
[   87.390554] mcp2517fd spi0.0: no valid irq line defined: irq = 0
[   87.390609] mcp2517fd: probe of spi0.0 failed with error -22
root at raspcm:~# dmesg -C; rmmod mcp2517fd; insmod /tmp/mcp2517fd.ko; dmesg; grep mcp2517fd /proc/interrupts
[   88.085940] irq: type mismatch (2/8), failed to map hwirq-16 for /soc/gpio at 7e200000!
[   88.085977] mcp2517fd spi0.0: no valid irq line defined: irq = 0
[   88.086032] mcp2517fd: probe of spi0.0 failed with error -22

Hope that shows the issue.

> 
>> [   87.867512] mcp2517fd spi0.0: no valid irq line defined: irq = 0
>> 
>> The test for irq == 0 is the first thing that happens in the 
>> spi.driver.probe code of the module.
>> 
>> So to me it looks as if something deeper down the stack during
>> initialization.
>> 
>> As if the irq-type is not cleaned up during release of the irq on module
>> unload - which I can confirm calls free_irq(spi->irq, priv).
> 
> I don't really understand this remark. The trigger type is a property
> of the generating device, so "cleaning up" doesn't make much sense
> (even if you;re not using the interrupt anymore, the device is still
> there).

As far as I see it the free_irq (or something else) does change something
in the info structure of the interrupt, so that it is now
configured as edge not level.

This means that it fails on the second attempt.

How/where this happens is unclear to me.

I darkly remember that there was something with regards to bcm2835 and
level interrupts, that had to be implemented as edge with a wrapper layer
to implement level or something?

But then I may be wrong here.

Ciao,
	Martin
