From: ulf.samuelsson@atmel.com (Ulf Samuelsson)
Date: Sat, 27 Mar 2010 00:16:58 +0100
Subject: request_irq in I2C driver causes kernel to freeze during probe, but
	if done later - no problem!
Message-ID: <4BAD406A.7070208@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am currently working on an I2C driver which requires an irq.

The driver was developed on a Beagleboard running linux-2.6.29-rc3
(Android 1.6) where everything works OK.
I then try the driver on a customer board, where they use 2.6.27.16
(also Android 1.6) on a Qualcomm Snapdragon.

In the "probe" for the driver, I request an irq.
If the code below is active, then the driver completes the "probe"
and can communicate with other I2C peripherals.
(This is verified by listening to the I2C bus communications)
After ~20 I2C messages to 3 different peripherals, the kernel freezes.
The customer board does not have a console port!,
so you can only read the bootlog if the boot succeeds.

If the code below is ifdef'ed away. the boot succeeds.
I have implemented a workaround, using sysfs, which allows me to request
the irq manually after the system has completed the boot.

If I do that, then the interrupts are accepted and the correct interrupt
routine is called.


#ifdef	MAXINT
if (mxt->irq) {
	error = request_irq(
			mxt->irq,
			mxt_irq_handler,
			IRQF_TRIGGER_FALLING,
			client->dev.driver->name,
			mxt
		);
	if (error < 0) {
		dev_err(&client->dev,
			"failed to allocate irq %d\n", mxt->irq);
		goto err_free_device;
	}
}
#endif

Some notes:
"request_irq" completes with (error >= 0) so the error handling
is not processed. This is verified by listening to the I2C bus.

Since we take the appropriate interrupt, "mxt->irq" must be correct.
Since we call the correct irq handler,"mxt_irq_handler" must be correct.
"mxt" is a pointer to the driver local data.
We use the same pointer when we request the irq in sysfs.
Not sure about the contents of "client->dev.driver->name".

If the interrupt is executing, then we would see some I2C communication
as a result, but we do not see this, before the kernel freezes.

The interrupt is (and should be) called on the falling edge of the
interrupt.

I am currently scratching my head, and need help with ideas...


Best Regards
Ulf Samuelsson
