From: marco.lazzaroni@tesielettronica.it (Marco Lazzaroni)
Date: Fri, 19 Oct 2012 08:03:02 -0000
Subject: Changing sd card data bits on the clock falling edge
Message-ID: <508107CE.1060407@tesielettronica.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
   I'm using kernel 3.6 on a i.MX23 processor.
I was able to enable and use a second SD Card by using interface SSP2 (I 
boot from a SD Card on SSP1).
The short story is, I need to keep BM_SSP_CTRL1_POLARITY bit in 
HW_SSP_CTRL1 register to a 1 value, while now it is initialized at 1, 
but after that it changes to 0.
How do I accomplish this?

Here I explain why I need this behaviour.
The SD Card is correctly recognised, (kern.log tells that I have a 
1.84GB card in it is correct), but then I'm having some communication errors

[...]
Oct 18 19:19:30 debian kernel: [  527.800000] mmcblk1: error -84 
transferring data, sector 0, nr 8, cmd response 0x900, card status 0x800b00
Oct 18 19:19:30 debian kernel: [  527.810000] mmcblk1: retrying using 
single block read
Oct 18 19:19:30 debian kernel: [  527.820000] mmcblk1: error -84 
transferring data, sector 0, nr 8, cmd response 0x900, card status 0x0
Oct 18 19:19:30 debian kernel: [  527.830000] end_request: I/O error, 
dev mmcblk1, sector 0
Oct 18 19:19:30 debian kernel: [  527.840000] mmcblk1: error -84 
transferring data, sector 1, nr 7, cmd response 0x900, card status 0x0
Oct 18 19:19:30 debian kernel: [  527.840000] end_request: I/O error, 
dev mmcblk1, sector 1
Oct 18 19:19:30 debian kernel: [  527.850000] mmcblk1: error -84 
transferring data, sector 2, nr 6, cmd response 0x900, card status 0x0
Oct 18 19:19:30 debian kernel: [  527.860000] end_request: I/O error, 
dev mmcblk1, sector 2
Oct 18 19:19:30 debian kernel: [  527.870000] mmcblk1: error -84 
transferring data, sector 3, nr 5, cmd response 0x900, card status 0x0
Oct 18 19:19:30 debian kernel: [  527.880000] end_request: I/O error, 
dev mmcblk1, sector 3
Oct 18 19:19:30 debian kernel: [  527.900000] mmcblk1: error -84 
transferring data, sector 4, nr 4, cmd response 0x900, card status 0x0
Oct 18 19:19:30 debian kernel: [  527.910000] end_request: I/O error, 
dev mmcblk1, sector 4
Oct 18 19:19:30 debian kernel: [  527.940000] mmcblk1: error -84 
transferring data, sector 5, nr 3, cmd response 0x900, card status 0x0
Oct 18 19:19:30 debian kernel: [  527.950000] end_request: I/O error, 
dev mmcblk1, sector 5
Oct 18 19:19:30 debian kernel: [  527.960000] mmcblk1: error -84 
transferring data, sector 6, nr 2, cmd response 0x900, card status 0x0
Oct 18 19:19:30 debian kernel: [  527.960000] end_request: I/O error, 
dev mmcblk1, sector 6
Oct 18 19:19:30 debian kernel: [  527.980000] mmcblk1: error -84 
transferring data, sector 7, nr 1, cmd response 0x900, card status 0x0
Oct 18 19:19:30 debian kernel: [  527.990000] end_request: I/O error, 
dev mmcblk1, sector 7
Oct 18 19:19:30 debian kernel: [  527.990000] quiet_error: 13 callbacks 
suppressed
Oct 18 19:19:30 debian kernel: [  528.000000] Buffer I/O error on device 
mmcblk1, logical block 0
Oct 18 19:19:30 debian kernel: [  528.020000] mmcblk1: error -110 
sending stop command, original cmd response 0x900, card status 0x800b00
[...]

Here is some facts:
- if I'm right, SD standard says that data bits are sampled on the 
rising edge of the clock signal, and must be valid for at least 2.5ns 
after that.
- in mxs-mmc.c, I see that BM_SSP_CTRL1_POLARITY bit in HW_SSP_CTRL1 
register is set in function mxs_mmc_reset -> this means data changes 
after falling edge (this information is contained in the imx23 datasheet 
p1042 -> http://www.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf 
<http://www.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf> )
- with an oscilloscope I see that data bits correctly change after 
falling in edge during the first communications (the phase at 400 kHz clock)
- I see also that after this, when clock switches to high speed (default 
is 50MHz, but I slowed down because of hardware problems to 1 MHz), data 
bits change after rising edge
- in fact if I printk out HW_SSP_CTRL1, I see that BM_SSP_CTRL1_POLARITY 
is reset (-> data changes after rising edge).

The outcome is that even if I slow down to 1 MHz, I can't correctly read 
the content of the SD card. Looking at the oscilloscope if I measure 
signals near the SD Card I see that the clock rising edge is a little 
late, so the SD Card sees that bits changing when they're sampled.
I think that doing changes after the rising edge while in high speed is 
the correct thing, so there's enough time for data bits to settle.
Anyway, because of my hardware problems (SD Card is 50 cm away from the 
CPU), slowing down the card to 1MHz does not improve things because data 
are changed so close to the time at which they're sampled. Signals and 
good and squared, with no ringings, but that little time shift throws me 
in trouble).

I would need to keep the  BM_SSP_CTRL1_POLARITY bit to 1 even in high 
speed, so data bits change on the falling edge; data bits have all the 
time to settle before the arriving of the rising edge since the clock is 
as slow as 1MHz.
But I don't know how to keep this bit at 1.
There's only a reference in mxs-mmc.c to BM_SSP_CTRL1_POLARITY, when it 
is set to 1, so I can't figure where it gets changed and set to 0.

Any help is appreciated. Thank you very much in advance.
Best regards,
   Marco Lazzaroni
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121019/136c5ec0/attachment-0001.html>
