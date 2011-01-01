From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Jan 2011 12:10:48 +0000
Subject: mmci: U300 "sync with blockend" broken for multi-block?
In-Reply-To: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
References: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
Message-ID: <20110101121048.GB25924@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 01, 2011 at 04:35:14PM +0530, Rabin Vincent wrote:
> In MMCI, there is some code to sync between the MCI_DATABLOCKEND and the
> MCI_DATAEND for U300 variants, which ensures that the transfer
> terminates only when both MCI_DATABLOCKEND and MCI_DATAEND occurs:
> 
> 	 * In the U300, the IRQs can arrive out-of-order,
> 	 * e.g. MCI_DATABLOCKEND sometimes arrives after MCI_DATAEND,
> 	 * so for this case we use the flags "blockend" and
> 	 * "dataend" to make sure both IRQs have arrived before
> 	 * concluding the transaction.
> 
> It seems to me that this code won't work correctly for multi-block
> transfers, because there MCI_DATABLOCKEND will hit for the earlier
> blocks and the blockend flag will be set, and if on the last block the
> MCI_DATABLOCKEND hits after the MCI_DATAEND, this synching code won't do
> what it's trying to do and will instead just terminate the transfer
> after MCI_DATAEND.

It would be good to characterize what's actually going on with U300 some
more, especially the timing between these signals and the FIFO interrupts,
rather than just stating that they occur "out of order".

Is the data block end interrupt being triggered when you've read the
required data from the FIFO, and the data end interrupt triggered when
the card has transferred the required amount of data (iow, data into
the FIFO)?

Once they have been properly characterized, then it may be possible to
come up with an alternative solution.  At the moment, it's very had to
guess what's going on from the descriptions given.
