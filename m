From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 12 Nov 2017 13:32:44 +0100
Subject: spi->irq == 0 on module reload of driver using IRQF_TRIGGER_LOW
Message-ID: <21FDD1B8-E8F6-4DCE-9D30-D82B713B0008@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

During the development of a new spi driver on a raspberry pi CM1
I have seen an issue with the following code triggering strange behavior:

	ret = request_threaded_irq(spi->irq, NULL,
				   mcp2517fd_can_ist,
				   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
				   DEVICE_NAME, priv);

This works fine the first time the module is loaded (spi->irq is not 0),
but as soon as the module gets removed and reinstalled spi->irq is 0 
and I get the message in dmesg:
[ 1282.311991] irq: type mismatch, failed to map hwirq-16 for /soc/gpio at 7e200000!

This does not happen when using the IRQF_TRIGGER_FALLING flag.

in spi_drv_probe spi core does sets spi->dev to 0 in case 
of_irq_get returns < 0;

The specific code that triggers this message and return 0 is 
irq_create_fwspec_mapping.

After implementing: https://www.spinics.net/lists/arm-kernel/msg528469.html
and also checking for spi->irq == 0, I get:

[   87.867456] irq: type mismatch (2/8), failed to map hwirq-16 for /soc/gpio at 7e200000!
[   87.867512] mcp2517fd spi0.0: no valid irq line defined: irq = 0

The test for irq == 0 is the first thing that happens in the 
spi.driver.probe code of the module.

So to me it looks as if something deeper down the stack during
initialization.

As if the irq-type is not cleaned up during release of the irq on module
unload - which I can confirm calls free_irq(spi->irq, priv).

After modprobe the module the first time the following entry in
/proc/interrupts shows:
 88:          0  pinctrl-bcm2835  16 Level     mcp2517fd

Any ideas why this happens and what can done about it?

Thanks, Martin

P.s: This issue shows on 4.14.0-rc8, but also on the downstream 4.9.57.
