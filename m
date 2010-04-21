From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed, 21 Apr 2010 10:00:39 +0300
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D85BE26@AUSP01VMBX24.collaborationhost.net>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BCCC@AUSP01VMBX24.collaborationhost.net>
	<z2h56d259a01004201654y93f6c533j11b5accd7e2f46e7@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BDD8@AUSP01VMBX24.collaborationhost.net>
	<n2u56d259a01004201810j22c17bcfn9fee59e9c65c4d7f@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BE26@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100421070039.GK19534@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 20, 2010 at 08:52:26PM -0500, H Hartley Sweeten wrote:
> On Tuesday, April 20, 2010 6:10 PM, Martin Guy wrote:
> > I have noticed on card insertion, the last line of:
> > 
> > mmc0: problem reading switch capabilities, performance might suffer.
> > mmc0: host does not support reading read-only switch. assuming write-enable.
> > mmc0: new SD card on SPI
> > mmcblk0: mmc0:0000 SD    952 MiB
> >  mmcblk0: p1 p2 p4
> > mmcblk0: retrying using single block read
> 
> That message might be related to the SFRM1 line being deasserted.

This message comes, depending on the card you are using.

It is easily reproduced with following command:

	# fdisk -l

Problem there seems to be that fdisk (and also part of block layer that reads
partition table) seeks to the end of the disk and reads last block. I remember
reading some mail thread about the matter and it could be that some cards
do read-ahead which causes the response message to return failure (address error
as a response to STOP message which is completely bogus).

You can enable MMC debugging and see if this is the case with your card also.

I actually debugged this further some time ago and after failure if card status
register is read, there is no failure at all (card is in correct state).

> You could try cutting the trace going to pin 1 (CS pin) of the mmc socket and
> jumpering it to one of the EGPIO pins on JP15 (the LCD header) or JP16 (the
> keypad header).  You will of course need to modify your platform init to use
> the new chip select line.
> 
> > and the SDHC cards I have don't work at all, spewing tons of:
> > mmcblk0: error -38 sending status comand
> > mmcblk0: error -38 sending read/write command, response 0x4, card status 0xff04
> > end_request: I/O error, dev mmcblk0, sector 7744509
> 
> I haven't seen those error messages before.  Of course I don't have any SDHC
> cards... ;-)

With my TS-7260 board, SDHC cards work (but it uses GPIO lines).

MW
