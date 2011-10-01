From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 17:09:37 +0100
Subject: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
In-Reply-To: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20111001160937.GF11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 09:46:08AM +0200, Ulf Hansson wrote:
> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> 
> Corrects a bug in pio read when reading packets < 4 bytes. These
> small packets are only relevant for SDIO transfers.

Does this even work?  From the MMCI spec, I see no way for the MMCI
peripheral to know the size of the read/write on the APB bus.

The APB bus signals the MMCI uses are:

PCLK - APB bus clock
PRESETn - APB bus reset
PADDR[11:2] - APB bus address
PSEL - APB bus peripheral select
PENABLE - APB bus enable
PWRITE - APB bus write signal
PWDATA[31:0] - APB bus write data
PRDATA[31:0] - APB bus read data

As you can see, nothing in that set indicates whether it's an 8-bit,
16-bit or 32-bit access.

Moreover, if you read the MMCIFifoCnt register writeup:

  The MMCIFifoCnt register contains the remaining number of words to be
  written to or read from the FIFO. The FIFO counter loads the value
  from the data length register (see Data length register, MMCIDataLength
  on page 3-11) when the Enable bit is set in the data control register.
  If the data length is not word aligned (multiple of 4), the remaining
  1 to 3 bytes are regarded as a word.

This suggests that we should be reading a 32-bit word and then storing
the relevant bytes from it.

The other thing which concerns me is that the MMCI (ARM Ltd one at least)
only supports power-of-two block sizes.  So requesting a transfer of a
single block with a block size of 3 bytes is not supported by the ARM Ltd
MMCI.  (The way you end up with 1 to 3 bytes being received with ARM's
MMCI is if you're using a streaming transfer.)

The last thing I don't like about this patch is that this code is in a
really hot path - one which is absolutely critical for things to work -
and the need for the condition to be dealt with is only at the end of a
transfer, not each time the FIFO needs emptying.

Bear in mind that there are platforms with the ARM MMCI which must read
the data within a certain time or suffer overruns, and which have either
totally broken and useless DMA or no DMA capability at all (which are
the only platforms I have with a MMCI on.)
