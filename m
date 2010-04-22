From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 22 Apr 2010 08:53:26 +0300
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D8C8CDD@AUSP01VMBX24.collaborationhost.net>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
	<20100421071629.GL19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C84DA@AUSP01VMBX24.collaborationhost.net>
	<20100421165420.GP19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8CDD@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100422055326.GB26418@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 09:47:14PM -0500, H Hartley Sweeten wrote:
[...]
> First, every spi transaction, including a single byte transfer, is
> going to generate at least two interrupts.  One when the interrupts
> are first enabled because the TX FIFO is empty.  And a second when
> that byte has been transferred and the TX FIFO is again empty.
> 
> The first interrupt can be prevented by priming the TX FIFO before
> enabling the interrupts.  All you need to do is call ep93xx_spi_read_write
> right before ep93xx_spi_enable_interrupts.

OK thanks.

> Second, at high clock rates the RX FIFO will actually start to
> fill as you are putting data into the TX FIFO.  If you add an inner
> reader loop to the writer loop in ep93xx_spi_read_write you can
> take advantage of this and reduce the number of interrupts generated
> for large transfers.

I originally had inner read loop in the first version of the driver
but it wasn't functioning as it should (this was pointed out by
Martin). But now when we have explicit FIFO size handling, I think
that it can be added there again.

Thanks,
MW
