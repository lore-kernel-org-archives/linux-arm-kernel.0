From: rene.wolf@mbda-systems.de (Wolf, Rene, HRO-GP)
Date: Thu, 17 Sep 2009 10:26:42 +0200
Subject: SPI, DMA and an i.MX31
Message-ID: <87077C4F48609F4392621D9F99DDE20901202DFF@tesla.star.galaxy.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone!

First of all this is my first post to this mailing list and I hope
I'm not screwing it :-).
I'm using the qong board from denx.de and their kernel in version
2.6.31 (should be equal to kernel.org). So, this is about the freescale
i.MX31 (ARM11), its SPI and (S)DMA. The goal is to do DMA-transfer
between the SPI and some buffer in memory. I'm quite new to drivers
under Linux, so I first tried to find out how DMA works here.

By this point I already worked with traditional MCU-DMAs, programing
them by hand with no OS (did so on an STM32 ARM Cortex-m3).
That would work something like that (for transmitting data
over SPI):
- get some buffer, fill in data.
- Tell SPI that it's going to be DMAed
- Tell DMA to communicate with SPI
- Tell DMA source pointer and set auto increment
- Tell DMA dest. (spi->tx) and set fixed
- Tell DMA count and length of word.
- Start transfer.

Now from books like "Essential Linux Device Drivers" and
"Linux Device Drivers" + "/usr/src/linux/Documentation/DMA-API.txt"
+ an example (/u/s/l/drivers/spi/atmel_spi.c) I got the following
idea how this might work under Linux (all those 'spi->cfg' are
figuratively :-)
- Get some buffer (buf=kmalloc or so...), fill in data
- Register buffer with system ( dma_map_single() )
- Tell SPI that it's going to be DMAed ( writel(spi->cfg, flags) )
- Tell DMA to communicate with SPI ( writel(dma->cfg, flags) )
- Tell DMA source pointer (+ autoinc.) ( writel(dma->src, &buf) )
- Tell DMA dest. (+ fixed) ( writel(dma->dest, &(spi->buf)) )
- Tell DMA count and length of words. (...)
- Start transfer. (...)

Am I right so far?

As far as I can tell this is mostly writing registers by hand,
there is no common API for setting stuff like src., dest., count,
device... is there? May be I missed, or didn't understand it.

Then I checked the (S)DMA that's inside the i.MX31 and how to do
the above. That SmartDMA is quite a nice piece of hardware: a
RISC processor with its own memory and it includes 32 threads
(DMA channels), scheduled by hardware. Pretty cool but that means
it has its own assembly language and needs some startup code ....

Looking around I found stuff like:
/u/s/l/arch/arm/plat-mxc/dma-mx1-mx2.c
though nothing for i.MX31. But then there is that:
http://osdir.com/ml/android-porting/2009-03/msg00251.html
http://lists.infradead.org/pipermail/linux-mtd/2009-May/025801.html
http://marc.info/?l=linux-arm-kernel&m=118003963232016&w=2
in those boot-msgs there is a line 'Using SDMA I.API'. At least
the 3rd one seams to be using LTIB.

So I guess there is no SDMA support for the i.MX31 and SPI unless
I switch to LTIB or do the SDMA-(errr...)-programing myself. Though
I would love to do the programing (I actually called freescale about
the SDMA API manual, cause they do not have it online), I don't have
time to do either of the two options. I would then resort to
interrupt-driven SPI for my task.


It would be nice if someone could give me a clue on my guess
about the basic concept for DMA+Linux. And if there really is no
SPI<->DMA support readily available for the i.MX31 (actually there
seems to be one for the IPU. There's a switch in the .config under:
'# DMA Devices' -> 'CONFIG_MX3_IPU=y' but as far as I recall the
i.MX31 manual this DMA serving the IPU is a different one.)

Any hints are welcome, even 'rtfm' :-) (coz then I know I
missed something)


Thanks a lot!

Cheers
Rene



Rene Wolf
LFK-Lenkflugk?rpersysteme GmbH
Human Resources Operations & Policy, HRO
Landshuter Stra?e 26, 85716 Unterschlei?heim, GERMANY
Phone: +49 89 3179 8337
Fax: +49 8252 99 8964
E-Mail: rene.wolf at mbda-systems.de

http://www.mbda.net

Chairman of the Supervisory Board: Antoine Bouvier
Managing Director: Werner Kaltenegger
Registered Office: Schrobenhausen
Commercial Register: Amtsgericht Ingolstadt, HRB 4365
