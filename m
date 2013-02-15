From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 15 Feb 2013 10:33:40 +0000
Subject: [BUG] v7_coherent_kern_range broken on big.LITTLE
In-Reply-To: <1360922677.4078.12.camel@linaro1.home>
References: <1360861663.3266.58.camel@linaro1.home>
 <20130214171615.GH12629@mudshark.cambridge.arm.com>
 <1360922677.4078.12.camel@linaro1.home>
Message-ID: <20130215103340.GA3014@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 10:04:37AM +0000, Jon Medhurst (Tixy) wrote:
> On Thu, 2013-02-14 at 17:16 +0000, Will Deacon wrote:
> > Hi Tixy,
> > 
> > On Thu, Feb 14, 2013 at 05:07:43PM +0000, Jon Medhurst (Tixy) wrote:
> > > The function v7_coherent_kern_range uses the macro icache_line_size to
> > > read the current CPUs icache line size for the purpose of invalidating
> > > all cache lines in the given range.
> > > 
> > > Unfortunately, on the TC2 big.LITTLE test chip, the A15 icache line size
> > > is 64 bytes, but the A7 size is only 32 bytes. So when the function
> > > executes on the A15 it will miss out every alternate cache line for the
> > > A7.
> > 
> > There is a signal (IMINLN) to the core which allows A15 to behave as though
> > it has a 32-byte line size and this should be driven correctly for big/little.
> 
> How do we set that signal? Is that something we have to set up in Linux
> or is it something that we expect the Firmware to set up?

If I am not mistaken, SCC register at offset 0x400 (bit 7) allows IMINLN to
be forced to 0 (ie Instruction Cache minimum line size == 32 bytes).

This can be done through board.txt so that it is set up as we want.

HTH,
Lorenzo
