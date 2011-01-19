From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 20:51:58 +0000
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <AANLkTineFJhqMcJbg1YQbPymT537Ef=jVgXLC5uw7DOt@mail.gmail.com>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTin67iTj34QBv3T-9+oMdo6q=EsYKf=5ca=6B69s@mail.gmail.com>
	<4D346800.3070603@stericsson.com>
	<20110118121455.GB9719@n2100.arm.linux.org.uk>
	<AANLkTineFJhqMcJbg1YQbPymT537Ef=jVgXLC5uw7DOt@mail.gmail.com>
Message-ID: <20110119205158.GC6335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 09:34:49PM +0100, Linus Walleij wrote:
> 2011/1/18 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > How reliable is the FIFOCNT register ?
> >
> > What I'm wondering is whether we can get rid of the DATABLOCKEND
> > interrupts completely, and instead read the FIFOCNT register to
> > discover how many blocks have been successfully transferred. ?FIFOCNT
> > on read gives you the remaining number of words to be transferred into
> > the FIFO from the card, not the number of words still to be read by the
> > host CPU.
> 
> Hmm... the FIFOCNT is just the FIFO.

No, FIFOCNT.

 The MCIFifoCnt register contains the remaining number of words to be
 written to or read from the FIFO. The FIFO counter loads the value from
 the data length register (see Data length register, MCIDataLength on page
 3-11) when the Enable bit is set in the data control register. If the data
 length is not word aligned (multiple of 4), the remaining 1 to 3 bytes are
 regarded as a word. Table 3-19 shows the bit assignment of the MCIFifoCnt
 register.

static int mmci_pio_read(struct mmci_host *host, char *buffer, unsigned int remain)
{
        do {
                int count = host_remain - (readl(base + MMCIFIFOCNT) << 2);

                if (count > remain)
                        count = remain;

                if (count <= 0)
                        break;

                readsl(base + MMCIFIFO, ptr, count >> 2);

We use FIFOCNT to work out how many bytes are needing to be transferred
from the FIFO on PIO reads.
