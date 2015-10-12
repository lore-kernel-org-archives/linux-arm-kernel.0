From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 12 Oct 2015 18:13:38 +0200
Subject: Regression: at24 eeprom writing
In-Reply-To: <561BCE33.2050904@lysator.liu.se>
References: <560F0DB1.2020101@lysator.liu.se>
 <561238A9.1060406@lysator.liu.se> <20151005150032.GA12137@odux.rfo.atmel.com>
 <561292AC.8060408@lysator.liu.se> <561BCE33.2050904@lysator.liu.se>
Message-ID: <561BDC32.2080401@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/10/2015 17:13, Peter Rosin a ?crit :
> On 2015-10-05 17:09, Peter Rosin wrote:
>> But what trouble does the i2c bus driver see? Admittedly I only
>> have a simple logic level bus viewer, and not a full-blown
>> oscilloscope, so there might be something analogue going on?
>> I don't think so though, those signals looked fine last time we
>> looked (but we obviously didn't have these issues then, and
>> didn't really look that closely). I'll see if I can recheck
>> with a real scope too.
> 
> We redid the tests with a real scope, and the signal looks nice
> and square, so it is not that.
> 
> Speculating further on the cause of the long ACKs, I think that
> the i2c driver gets confused by an interrupt that marks the
> transfer complete, and thinks it's a NACK interrupt instead. Is that
> plausible?
> 
> If the peripheral unit is such that it generates a stop automatically
> on NACKs, then this makes perfect sense. I.e. the TWI sees that the
> transfer is complete, generates an interrupt, and waits for further
> data or a stop command. Meanwhile the driver thinks it's a NACK and
> that a stop condition has already been sent to the bus, and just
> notifies the i2c consumer (the eeprom driver in this case) of the
> failure and frees up the bus for any future user.
> 
> This also matches what I see when I turn on some more traffic on the
> bus, that is interleaved with the eeprom traffic. AFAICT, it can be
> any command that gets chewed up by the eeprom if it is sent to the
> i2c driver during the long ACK.
> 
> Are you Atmel people making any progress on this data corrupting
> regression? Is there anything else I can do to help?
> 
> Cheers,
> Peter
> 

Hi Peter,

I have sent a patch to Ludovic for a first internal review before publishing to
mainline. The patch should fix your issue since it fixes it on my sama5d36ek
board with an at24 eeprom.

More details on the reason of this bug would be provided in both the commit
message and comments in the code provided by the reviewed patch but I you want
an early fix just read the Status Register (AT91_TWI_SR) at the beginning of
at91_do_twi_transfer(). This read clears the NACK bit in the Status Register.
Then the following source code can safely enable the NACK interrupt, otherwise
in some cases a pending NACK interrupt would rise immediately after the line:
at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_NACK);
hence breaking the sequence of operations to be done because the interrupt
handler would call complete() too early so wait_for_completion_timeout()
also exits too early.

So reading the Status Register at the beginning of at91_do_twi_transfer()
should be enough to fix the issue.

Another mistake is in the interrupt handler itself, ie atmel_twi_interrupt():
we should check the TWI_TXRDY status bit before calling
at91_twi_write_next_byte() only if both the TWI_TXCOMP and TWI_NACK status bits
are clear. Otherwise, writing a new byte into the THR tells the I2C controller
to start a new transfer. Then the I2C slave, the at24 eeprom, is likely to
also reply by a second NACK. Hence the NACK bit is already set into the Status
Register on the next call of at91_do_twi_transfer().
This is what I saw on my scope for PIO transfers.

By the way, in my case, the first NACK occurs because the at24 driver tries to
perform a second write transfer too quickly and the eeprom is not ready yet,
then replies with a NACK.
However while debugging, placing debug traces in the I2C controller driver
changed the timing: this small delay was enough to make the first NACK
disappear because the eeprom was now ready to process the second write
operation.

For DMA transfer, you have to know that when NACK error is detected, the I2C
controller sets the TWI_TXCOMP, TWI_NACK and TWI_TXRDY bits all together in
the Status Register:
- The TWI_NACK is cleared by reading the Status Register.
- The TWI_TXRDY triggers the DMA controller to write the next byte in the THR,
  which should also tell the I2C controller to start a new transfer.
- The TWI_TXCOMP bit is cleared by writing into the THR: this is why the
  interrupt handler may fail to detect NACK if it relies on TWI_TXCOMP.

Best Regards,

Cyrille
