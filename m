From: mboards@prograde.net (Michael Cashwell)
Date: Fri, 14 May 2010 14:51:19 -0400
Subject: PXA/8250 UART Conflicts
In-Reply-To: <23b656b0c689be0c7ec0faaf37b6a9e6@localhost>
References: <3117D78B-5443-48B5-88BC-83EEB8F709F9@prograde.net>
	<23b656b0c689be0c7ec0faaf37b6a9e6@localhost>
Message-ID: <21152027-3FF3-462E-ADE1-4801CDD251D0@prograde.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 11, 2010, at 12:29 PM, Marc Zyngier wrote:

> On Tue, 11 May 2010 11:00:36 -0400, Michael Cashwell wrote:
>> 
>> Am I missing something? Are these drivers just incompatible ... ?
> 
> Both Viper and Zeus platforms faced the exact same problem. On the Viper, either we let the 8250 driver manage all the serial ports (including the PXA ports) ...

Thanks to all who responded. For my UART eval I when with this approach.

Not to hijack my own thread, but I have the 8250 via i2c working in pio mode. (DMA mode calls a wait_ function and gave me a flood of "scheduling while atomic" BUGs.)

But alas, trying to do this via SPI is not working. It seems that even without DMA the SPI layer uses interrupts and a tasklet to keep the transfers going and the 8250 driver does most of its work at atomic time (either directly in the top-half or inside a spin_lock_irqsave).

Thus, the sync SPI calls hit the same "scheduling while atomic" problem as non-PIO i2c and the async calls (followed by a cpu_relax() waiting for my completion function to run) never complete. I've seen some messages about an SPI functions that would allow for scheduling but no clear resolution.

This has me wondering why the 8250 driver needs to globally disable interrupts so much. In fact, other than the special case where it shares IRQs with other drivers I don't see why it needs to globally stop interrupts at all. If it has sole possession of its IRQs it would seem to me that the top-half could just run the bottom half at task-time and have it service the hardware. If it did that calling into SPI would be OK.

I may just be confused at this point. I'm still pondering my (few apparent) options, but at least it works with i2c.

Thanks for the assistance.

-Mike
