From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Mar 2010 21:12:12 +0000
Subject: [PATCH] arm: convert /proc/cpu/aligment to seq_file
In-Reply-To: <20100305144523.GB23225@pengutronix.de>
References: <20091127063746.GB25983@x200.malnet.ru>
	<20100305144523.GB23225@pengutronix.de>
Message-ID: <20100305211212.GE4885@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 05, 2010 at 03:45:23PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Fri, Nov 27, 2009 at 09:37:46AM +0300, Alexey Dobriyan wrote:
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> What are the up and down sides of that patch?  I assume there are no
> changes for the userspace?

We have something like a 100 byte file for /proc/cpu/alignment.  Is
there really any risk that 8 32-bit numbers printed in decimal plus
some text will ever overflow the PAGE_SIZE (4096) bytes of space
allocated to procfs file data?

Let's assume 100 bytes for the text bits, plus 10 bytes per 32-bit
number (maximum 32-bit number is 4294967295).  So that's 180 bytes
maximum in this file.

Are we ever going to see an ARM machine with a page size less than
256 bytes?

In my opinion, there isn't any danger of overflowing the procfs file
buffer at all - so the question is whether the complexity of seq_file
is worth "fixing" a problem which just doesn't exist.

The only reason it would be worth it is if we're getting rid of the
old simple procfs PAGE_SIZE buffer interface.
