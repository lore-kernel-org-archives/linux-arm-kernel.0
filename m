From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 5 Oct 2015 17:28:56 +0200
Subject: Regression: at24 eeprom writing
In-Reply-To: <561238A9.1060406@lysator.liu.se>
References: <560F0DB1.2020101@lysator.liu.se> <561238A9.1060406@lysator.liu.se>
Message-ID: <56129738.3030009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/10/2015 10:45, Peter Rosin a ?crit :
> On 2015-10-03 01:05, Peter Rosin wrote:
>> Hi!
>>
>> I recently upgraded from the atmel linux-3.18-at91 kernel to vanilla 4.2
>> and everything seemed fine. Until I tried to write to the little eeprom
>> chip. I then tried the linux-4.1-at91 kernel and that suffers too.
>>
>> The symptoms are that it seems like writes get interrupted, and restarted
>> again without properly initializing everything again. Inspecting the i2c
>> bus during these fails gets me something like this (int hex) when I
>>
>> echo abcdefghijklmnopqr > /sys/bus/i2c/devices/0-0050/eeprom
>>
>> S a0 00 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f 70 P
>> S a0 10 (clk and data low for a "long" time) 10 71 72 0a P
>>
>> Notice how the address byte in the second chunk (10) is repeated after
>> the strange event on the i2c bus.
>>
>> I looked around and found that if I revert a839ce663b3183209fdf7b1fc4796bfe2a4679c3
>> "eeprom: at24: extend driver to allow writing via i2c_smbus_write_byte_data"
>> eeprom writing starts working again.
>>
>> AFAICT, the i2c-at91 bus driver makes the eeprom driver use the
>> i2c_transfer code path both with that patch and with it reverted,
>> so I sadly don't see why the patch makes a difference.
>>
>> I'm on a board that is based on the sama5d31 evaluation kit, with a
>> NXP SE97BTP,547 chip and this in the devicetree:
>>
>> 			i2c0: i2c at f0014000 {
>> 				status = "okay";
>>
>> 				jc42 at 18 {
>> 					compatible = "jc42";
>> 					reg = <0x18>;
>> 				};
>>
>> 				eeprom at 50 {
>> 					compatible = "24c02";
>> 					reg = <0x50>;
>> 					pagesize = <16>;
>> 				};
>> 			};
> 
> Ok, I found the culprit, and I double and triple checked it this time...
> 
> If I move to the very latest on the linux-3.18-at91 branch, the bug is
> there too. Which made it vastly more palatable to bisect the bug.
> 
> The offender (in the 4.2 kernel) is 93563a6a71bb69dd324fc7354c60fb05f84aae6b
> "i2c: at91: fix a race condition when using the DMA controller"
> which is far more understandable. Ao, adding Cyrille Pitchen to the Cc list.
> 
> If I add that patch on top of my previously working tree, it behaves just
> as newer kernels, i.e. equally bad. The patch doesn't revert cleanly, but
> reverting the patch and quick-n-dirty-fixing the conflict on vanilla 4.2
> makes the problem go away.
> 
> I have attached what I actually reverted.
> 
> Cheers,
> Peter
> 

Hi Peter,

Can you tell me whether your device tree sets the I2C controller i2c0 to use
dma channels, especially the "tx" one. I guess so but it is just to confirm 
hence we look in the right direction.

Then I think we should look at this part of the original patch:

        } else {
                if (dev->use_dma && (dev->buf_len > AT91_I2C_DMA_THRESHOLD)) {
+                       at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_NACK);
                        at91_twi_write_data_dma(dev);
-                       at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_TXCOMP);
                } else {
                        at91_twi_write_next_byte(dev);
                        at91_twi_write(dev, AT91_TWI_IER,

Here, for DMA TX transfers, we enable the NACK interrupt instead of the TXCOMP
one. This is the actual fix of the DMA race. Indeed there were two issues when
using TXCOMP to detect NACK conditions.

As written in the datasheet and confirmed by the IP designer, the TXCOMP bit is
set in the Status Register when both the Transmit Holding Register (THR) and
its internal shifter are empty and the STOP condition has been sent.
So when a first transfer successfully completes, the TXCOMP bit is set. Then
this bit remains set until the next write into THR.

The first issue is the race condition:
at91_twi_write_data_dma(dev);
at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_TXCOMP);

The first line prepares a DMA transfer but when we execute the second line to
enable the TXCOMP interrupt, we have no mean to know whether the DMA has
already performed a first write access into THR, which also clears the TXCOMP
bit in the Status Register. If the DMA controller hasn't completed this first
write yet, the TXCOMP bit is still set in the Status Register. Hence the
interrupt handler is executed immediately after the TXCOMP interrupt has been
enabled. If the interrupt handler reads the Status Register before the DMA
controller has written into the THR, the TXCOMP bit is still set. Consequently,
the interrupt handler calls complete(&dev->cmd_complete) thinking the transfer
has completed though it actually has not even started.


The second issue is about the detection of NACK condition when using the DMA
controller. Before the patch, the driver relied on the TXCOMP interrupt to
detect NACK condition. It is true that the TXCOMP bit is set in the Status
Register when a NACK condition occurs. However if the I2C controller has
already triggered the DMA controller before it detects a NACK condition and
sets the TXCOMP bit, the DMA controller writes into the THR right after, hence
clears the TXCOMP bit in the Status Register. when the interrupt handler is
executed, it reads the Status Register but fails to detect the NACK condition
since the TXCOMP bit has been cleared: The driver misses the NACK condition.
This is why we should rely on the NACK interrupt instead. the NACK bit is
cleared on read in the Status Register, the NACK condition is properly
detected.

So instead of reverting the patch, maybe you could try to add the single line
which used to enable the TXCOMP interrupt after having scheduled the TX DMA
transfer:

        } else {
                if (dev->use_dma && (dev->buf_len > AT91_I2C_DMA_THRESHOLD)) {
                        at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_NACK);
                        at91_twi_write_data_dma(dev);
+                       at91_twi_write(dev, AT91_TWI_IER, AT91_TWI_TXCOMP);
                } else {
                        at91_twi_write_next_byte(dev);
                        at91_twi_write(dev, AT91_TWI_IER,

I don't know whether this would "fix" your issue. Anyway if it does, this is
not a proper fix but it may help us to understand what is going on.

On my side, I will try to reproduce your issue on a sama5d3x board.


Best Regards,

Cyrille
