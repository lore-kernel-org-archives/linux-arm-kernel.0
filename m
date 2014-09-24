From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Sep 2014 12:20:26 +0200
Subject: [PATCH v2 8/8] tty/serial: add asm9260-serial driver
In-Reply-To: <54228DD5.1090606@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <3430001.JjzmzIerfp@wuerfel> <54228DD5.1090606@rempel-privat.de>
Message-ID: <102161224.Tj33eeeN8f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 September 2014 11:24:37 Oleksij Rempel wrote:
> m 22.09.2014 um 17:26 schrieb Arnd Bergmann:
> > On Sunday 21 September 2014 20:45:51 Oleksij Rempel wrote:
> >> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> >> ---
> >>  drivers/tty/serial/Kconfig          |   17 +
> >>  drivers/tty/serial/Makefile         |    1 +
> >>  drivers/tty/serial/asm9260_serial.c | 1485 +++++++++++++++++++++++++++++++++++
> >>  include/uapi/linux/serial_core.h    |    2 +
> >>  4 files changed, 1505 insertions(+)
> >>  create mode 100644 drivers/tty/serial/asm9260_serial.c
> >>
> > 
> > Similar to the irqchip driver, this one in turns seems to be a duplicate
> > of drivers/tty/serial/mxs-auart.c. Please see if you can make that one
> > work instead of adding a new copy.
> 
> Hmmm.... they are identical in some parts, but have some different
> offsets, and in some cases different bitmask. 

It really depends on how much is different.

> I think it will look
> messy. Asm9260 has some more extras: RS485, CTRL3, ISO7816.

None of these are used in your driver though. It's possible that
mxs has the same registers but the driver author did not document
them.

> Should it be moved to one file? Or may be better to create some
> common-dma.c and common-pio.c libs?

I'd suggest trying to do it in one file first, only splitting things
out if it gets too messy.
You will probably have to replace the .driver_data in mxs_auart_devtype
with a structure that has all the differences, either using function
pointers for accessing the registers that are not identical, or using
some data that can be used to look up the the actual registers.

	Arnd
