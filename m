From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 May 2012 20:17:57 +0100
Subject: [RFC 03/34] dmaengine: virt-dma: add support for cyclic DMA
 periodic callbacks
In-Reply-To: <CAMj5BkjGQXxA0gaNLKDSuRpYXoY3sqbzquKo-Lth9-TG_QcqHQ@mail.gmail.com>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIqg-0006yu-5Z@rmk-PC.arm.linux.org.uk>
 <CACRpkdba_aFbyBt9hkYqBR=oY6fq0KHchjGcuS_NhbOMbE0Owg@mail.gmail.com>
 <20120530080216.GH12217@n2100.arm.linux.org.uk>
 <CAMj5BkjGQXxA0gaNLKDSuRpYXoY3sqbzquKo-Lth9-TG_QcqHQ@mail.gmail.com>
Message-ID: <20120531191757.GI12217@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 11:45:54AM +0800, zhangfei gao wrote:
> On Wed, May 30, 2012 at 4:02 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, May 30, 2012 at 03:52:53PM +0800, Linus Walleij wrote:
> > No, I don't think we should do that - ALSA doesn't require it, and ALSA
> > is about the only user of this. ?As I've said, DMA engine drivers should
> > implement a correct tx_status function, which returns the remaining bytes
> > to be transferred to the end of the buffer so it's possible to find out
> > how many periods have completed when the callback is called.
> 
> Could we directly use pos, but unmatch with dma_tx_state.residue.
> For cyclic buffer, when pos reach to buffer size, pos will change to 0,
> remaining bytes also 0, we may have to distinguish them.

What pos?

The way I said above, you work out how many periods have expired by
using dma_tx_state.residue.  This tells you how many bytes are left to
transfer until the _end_ of the looped buffer.

>From that, you can tell directly how many periods have expired.

Really, ALSA is not interested in "how many periods have expired" but
is really after a regular update of where DMA is _now_, so it knows
how many bytes it can write into or read from the circular buffer.  It
really doesn't need to know that N periods have expired _if_ you're
capable of telling it exactly where the DMA is in the buffer.

And with a working dma_tx_state.residue, you can do exactly that.
