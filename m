From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 21 Apr 2010 21:47:14 -0500
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <20100421165420.GP19534@gw.healthdatacare.com>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
	<20100421071629.GL19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C84DA@AUSP01VMBX24.collaborationhost.net>
	<20100421165420.GP19534@gw.healthdatacare.com>
Message-ID: <0D753D10438DA54287A00B0270842697636D8C8CDD@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mika,

I have added some debug messages to the driver trying to figure out
how to chain the transfers in a message together in order to keep
the SFRM signal asserted for the entire message.  I still haven't
worked out a good solution but I did notice something else.

First, every spi transaction, including a single byte transfer, is
going to generate at least two interrupts.  One when the interrupts
are first enabled because the TX FIFO is empty.  And a second when
that byte has been transferred and the TX FIFO is again empty.

The first interrupt can be prevented by priming the TX FIFO before
enabling the interrupts.  All you need to do is call ep93xx_spi_read_write
right before ep93xx_spi_enable_interrupts.

Second, at high clock rates the RX FIFO will actually start to
fill as you are putting data into the TX FIFO.  If you add an inner
reader loop to the writer loop in ep93xx_spi_read_write you can
take advantage of this and reduce the number of interrupts generated
for large transfers.

For instance the mmc_spi driver regularly does 3 transfer messages
where the last transfer is a 512 byte read.  With your current v4
driver this message averages 69 interrupts to complete.  By adding
the inner reader it reduces the number of interrupts to an average
of 40.

Regards,
Hartley
