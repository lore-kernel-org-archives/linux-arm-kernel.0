From: Pawel.Moll@arm.com (Pawel Moll)
Date: Mon, 24 Jan 2011 16:13:14 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <20110124133513.GL16202@n2100.arm.linux.org.uk>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
	<20110124133513.GL16202@n2100.arm.linux.org.uk>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I don't think enlarging the FIFO will help too much.  The issue is
> whether the CPU can keep up with the data rate coming off the card.
> If it can't, then no matter how large the FIFO is, it will
> eventually overflow.

Yes, I realize that. But so far the only time when problem happens is the timeout caused by ISP1761 handler. If we substantially increase the FIFO depth, we'll just have much more margin - enough to "mostly work". To my taste, the 1.3ms required to service the USB interrupt is already waaay to long. I'd consider any substantially larger latencies pathological, so making sure that we have margin of 3, maybe even 5 ms sounds good enough to me.

It's not about making this interface perfect. This won't happen, I afraid :-( It's just about making it good enough :-)

> The real answer is to avoid PIO mode, and use DMA support.
> However,
> I've had problems using DMA on the ARM development boards.  You can

Well, using DMA won't be easy on VE, will it? ;-) Besides even with this, in some extreme situation, the bus could be potentially stalled long enough to cause an underrun. Yes, very unlikely, but not impossible.

> The alternative answer, I believe implemented by some of ARMs silicon
> partners, is to turn the card clock off when the FIFO becomes full/empty
> to stop it sending more data.  I think this violates some of the MMC/SD
> requirements, but it seems to work for the silicon partners just fine.

Oh no, that's absolutely legal - see JEDEC 84-A441, p. 7.7:
"The MultiMediaCard bus clock signal can be used by the host to put the card into energy saving mode, or to control the data flow (to avoid under-run or over-run conditions) on the bus."

So this would be the technically correct fix. The problem is that this would require even more MMCI modifications then enlarging FIFO, so it's unlikely to happen.

Pawe?

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
