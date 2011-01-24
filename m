From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 13:35:13 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
	<000001cbbbc2$0e815e80$2b841b80$@moll@arm.com>
Message-ID: <20110124133513.GL16202@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 12:27:16PM -0000, Pawel Moll wrote:
> So - we'll try to enlarge FIFO. For the moment - playing with interrupts
> affinity seem to be a viable workaround.

I don't think enlarging the FIFO will help too much.  The issue is
whether the CPU can keep up with the data rate coming off the card.
If it can't, then no matter how large the FIFO is, it will eventually
overflow.

The real answer is to avoid PIO mode, and use DMA support.  However,
I've had problems using DMA on the ARM development boards.  You can
find details my DMA issues internally within ARM by talking to Catalin.

The alternative answer, I believe implemented by some of ARMs silicon
partners, is to turn the card clock off when the FIFO becomes full/empty
to stop it sending more data.  I think this violates some of the MMC/SD
requirements, but it seems to work for the silicon partners just fine.
