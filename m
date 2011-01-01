From: rabin@rab.in (Rabin Vincent)
Date: Sat, 1 Jan 2011 16:35:14 +0530
Subject: mmci: U300 "sync with blockend" broken for multi-block?
Message-ID: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In MMCI, there is some code to sync between the MCI_DATABLOCKEND and the
MCI_DATAEND for U300 variants, which ensures that the transfer
terminates only when both MCI_DATABLOCKEND and MCI_DATAEND occurs:

	 * In the U300, the IRQs can arrive out-of-order,
	 * e.g. MCI_DATABLOCKEND sometimes arrives after MCI_DATAEND,
	 * so for this case we use the flags "blockend" and
	 * "dataend" to make sure both IRQs have arrived before
	 * concluding the transaction.

It seems to me that this code won't work correctly for multi-block
transfers, because there MCI_DATABLOCKEND will hit for the earlier
blocks and the blockend flag will be set, and if on the last block the
MCI_DATABLOCKEND hits after the MCI_DATAEND, this synching code won't do
what it's trying to do and will instead just terminate the transfer
after MCI_DATAEND.
