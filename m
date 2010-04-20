From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 20 Apr 2010 17:16:10 -0500
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B0270842697636D85BCCC@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 20, 2010 8:12 AM, Mika Westerberg wrote:
>
> This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
> in EP93xx chips (EP9301, EP9302, EP9307, EP9312 and EP9315).
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>

Mika,

I discovered one gotcha with this driver.  Bear with me through this...

1. ep93xx_spi_process_message is called by the workqueue worker function to handle
   a spi_message queued in by the ep93xx_spi_transfer function.  Before starting
   the actual transfer the chip select to the device is asserted.
2. ep93xx_spi_process_transfer processes each transfer in the spi_message, one at a
   time, and does a wait_for_completion on each transfer.
3. When the entire spi_message has been transferred the chip select to the device
   is deasserted.

The problem is if a hardware design uses the SFRM1 pin as part of the chip select
logic.  The EP93xx User's Guide states that "the SFRMOUT signal behaves as a slave
Select" in Motorola SPI mode.  This signal behaves differently depending on the
SPI_MODE_* used.

Modes 0 and 2:
  SFRMOUT is forced HIGH during idle periods.
  Start of transmission, SFRMOUT is driven LOW.
  Single word transmission, SFRMOUT is returned to its idle HIGH state one
    SCLKOUT period after the last bit has been captured.
  Back-to-back transmissions, SFRMOUT signal is pulsed HIGH between each
    data word transfer.  On completion the SFRMOUT pin returns to its idle
    HIGH state one SCLKOUT period after the last bit has been captured.

Modes 1 and 3:
  SFRMOUT is forced HIGH during idle periods.
  Start of transmission, SFRMOUT is driven LOW.
  Single word transmission, SFRMOUT is returned to its idle HIGH state one
    SCLKOUT period after the last bit has been captured.
  Back-to-back transmissions, SFRMOUT signal is held LOW between each
    data word transfer.  On completion the SFRMOUT pin returns to its idle
    HIGH state one SCLKOUT period after the last bit has been captured.

So, since each transfer does a wait_for_completion, all the data is transmitted
which causes the SFRMOUT pin to go HIGH between each transfer in the message.

For devices like the sst25lf040a SPI Flash on the EDB93xx boards this causes a
problem.  To read data from that device you need to send a two part message.  The
first part is a write transfer with the one byte command and three byte address.
This is then followed by a read transfer to get the data.  But since the SFRMOUT
pin goes high this ends the command.

The driver Ryan and I worked on actually does work with the sst25lf040a on the
EDB93xx boards.  But now that I know what the issue is, it was actually a race
condition.  Sometimes it worked and sometimes it didn't...

I would think the Sim.One board (Martin?) would have the same issue with the mmc
card since that design uses the SFRMOUT pin directly for the chip select.

Is there anyway to keep the transfers going in a muiltipart message?

Regards,
Hartley
