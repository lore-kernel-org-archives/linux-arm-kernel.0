From: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Wed, 15 Dec 2010 16:33:54 -0500
Subject: IMX SPI - 17-24 bit bug and >32 bit support.
Message-ID: <BLU0-SMTP23E8D9768DB476BFCE7B23B8140@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Attach is an example patch to the spi_imx.c file.  The iMX spi doesn't
handle 17-24bit values properly.  At least in sound/soc, the 24 bit
values are being passed with three data bytes per unit.  Also the SPI
count is being filled with '3' as a length.  Such data passed to the
current iMX spi driver will cause it to loop forever as it decrements
the unsigned length by '4' and eventually accesses invalid memory.

I believe that the reset of the kernel believes that the SPI layer
should use three bytes per transfer/receive item if the SPI word
length is 17 to 24 bits.

The other issue is that the current driver does not support SPI
transfers of greater than 32bits (called 'BURST LENGTH' in iMX
documentation).

Currently I have left the original code and just conditionalized it on
SPI_IMX_FLEXIBLE.  I have changed the 'tx', and 'rx' pointers to call
fixed routines.  I have only currently coded for 'little endian'.  I
am unsure whether any iMx processor can work with little endian.

I haven't limited the word size to 128*32 bits which is the maximum
burst for the iMx25 and investigated the maximums for the other
supported processors.  I suspect there is a better way to do the
wrapping of bytes.

I have tested this code with 8 and 24 bit transfer sizes on the
transmit side with the iMx25.

Thanks,
Bill Pringlemeir.

Signed-off-by: Bill Pringlemeir <bpringle@sympatico.ca>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx_spi.patch
Type: text/x-diff
Size: 4413 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101215/49f6c84f/attachment.bin>
