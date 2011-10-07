From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Oct 2011 20:11:28 +0100
Subject: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
In-Reply-To: <4E8F00E4.5010702@stericsson.com>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com>
	<20111001160937.GF11710@n2100.arm.linux.org.uk>
	<4E895F6A.9070203@stericsson.com> <4E8F00E4.5010702@stericsson.com>
Message-ID: <20111007191128.GA25689@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 03:38:44PM +0200, Ulf Hansson wrote:
> In this hot path we already do a read of the FIFOCNT register for every  
> loop in pio_read, won't this sometimes cause caches to flush and  
> similar, thus cost quite a lot - at least a lot more than executing a  
> switch/if sentence like Stefan added? Or do I miss something?

The read of FIFOCNT just reads the counter and does nothing more.  Why
do you think it causes a cache flush, and what cache do you think would
be flushed?

> I were also thinking of a possible optimization of minimizing the total  
> numbers of reads of the FIFOCNT register in pio_read. Basically we can  
> make use of the RXFIFOHALFFULL irq/status to know when there is a  
> "burst" available in the FIFO. Do you think this will be feasible for  
> the ARM MMCI Pl18x IP as well? I mean the consequence of using  
> RXFIFOHALFFULL will be less numbers of IRQ raised and then when reading  
> data from the FIFO it will be done in larger chunks.

We read the FIFOCNT register to allow us to empty as much data from the
FIFO as we possibly can at each interrupt.  We know that it's going to
be at least half full at that time because that's the interrupt which is
triggering us to do the read (except for the final few words).  What we
want to do is not just read half the FIFO, but everything that it
contains.  Hence why we read FIFOCNT.

> We could make use of the "likely" makro to make compiler optimizations  
> of the code, is that a way forward do you think?

That only helps if you look at the assembled code and inspect what the
compiler is doing.  If it's already correctly guessing the best paths,
then the likely macro does nothing for you.

But first, you need to fix your code so you're only reading 32-bit
quantities from the FIFO register.
