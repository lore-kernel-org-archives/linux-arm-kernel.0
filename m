From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 12:14:55 +0000
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <4D346800.3070603@stericsson.com>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTin67iTj34QBv3T-9+oMdo6q=EsYKf=5ca=6B69s@mail.gmail.com>
	<4D346800.3070603@stericsson.com>
Message-ID: <20110118121455.GB9719@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 05:02:08PM +0100, Linus Walleij wrote:
> Yes it is very different, see the log I sent in reply to Russells earlier
> mail. It's not just one blockend missing, sometimes it's two (on U300)
> and on Ux500 it's something like 5 out of 128 blockends that actually
> get fired, the rest are missing.
>
> Now the only variant actually using that interrupt is the original
> ARM version found in RealView & Versatile. I have run this code
> on the PB1176 but it wasn't missing any blockends. No errors.
>
> I tried to increase the clock speed to see if I could provoke the
> error in the RealView, but hit FIFO overflow (since these variants
> does not have hardware flow control) before I got to the speed
> where I presume the error could occur.

How reliable is the FIFOCNT register ?

What I'm wondering is whether we can get rid of the DATABLOCKEND
interrupts completely, and instead read the FIFOCNT register to
discover how many blocks have been successfully transferred.  FIFOCNT
on read gives you the remaining number of words to be transferred into
the FIFO from the card, not the number of words still to be read by the
host CPU.

It's going to require some thought though, as I don't think you can use
the register to say X bytes, transferred, that means we got X bytes
successfully.  If you have a data CRC error, you will have transferred
most, if not all of the block in error, so you'd need to wind back to
the start of the block.  In theory, data CRC errors should cause the
card to stop transmission.

A data timeout (meaning a missing start condition) on the other hand
means the data block hasn't started to be transferred.

So, what I think's required (for read) is:

	remain = readl(host->base + MMCIFIFOCNT) << 2;
	success = data->blksz * data->blocks - remain;

	if (status & MCI_DATACRCFAIL) {
		/* round down to last block */
		host->data_xfered = ((success / data->blksz) - 1) * data->blksz;
		data->error = -EILSEQ;
	} else if (status & MCI_DATATIMEOUT) {
		host->data_xfered = success;
		data->error = -ETIMEDOUT;
	} else if (status & (MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
		host->data_xfered = success;
		data->error = -EIO;
	}

Not sure if that's valid for write atm.
