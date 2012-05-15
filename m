From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Tue, 15 May 2012 10:32:29 +0530
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120511130352.GA6220@n2100.arm.linux.org.uk>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <20120504122611.GE26481@n2100.arm.linux.org.uk>
 <1336135550.1540.2.camel@vkoul-udesk3>
 <20120510225429.GG12727@n2100.arm.linux.org.uk>
 <1336705214.15424.1369.camel@vkoul-udesk3>
 <CACRpkdZpC4pwSCLrZuVg9C=5u5pVQpm8c7HVmshs09wtEOcnqg@mail.gmail.com>
 <20120511130352.GA6220@n2100.arm.linux.org.uk>
Message-ID: <1337058149.16185.5377.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-11 at 14:03 +0100, Russell King - ARM Linux wrote:
> On Fri, May 11, 2012 at 02:24:10PM +0200, Linus Walleij wrote:
> > > + * @residue: is defined as:
> > > + *   - for completed descriptor: 0
> > > + *   - for descriptors which are in DMA_PAUSED, DMA_IN_PROGRESS:
> > > + *     length - (current_addr - start_addr), where:
> > > + *             length = descriptor dma length
> > > + *             current_addr = current dma pointer queried for dma channel
> > > + *             start_addr: starting address of this descriptor
> > > + *   This is mandatory and needs to be correctly filled by driver
> > >  */
> > > Does this make it clear?
> > 
> > Looks good to me.
> 
> There's a problem with defining it that way.  Consider a scatterlist.
> What does 'current address' and 'start address' mean with respect to
> those transfers?
> 
> Rather than trying to define this in terms of mathematics, which will
> always lead to this kind of confusion, use English instead.
> 
> - for descriptors which are in progress or paused:
>   the number of bytes yet to be transferred to or from the memory for
>   MEM2DEV or DEV2MEM transfers.
> 
> This leaves MEM2MEM and DEV2DEV transfers ambiguous - both suffer from
> the problem of whether you use the source or destination pointers/lengths
> to calculate the residue.
in MEM2MEM both pointers should typically increment/decrement, so we
should consider any one of them. DEV2DEV is problematic unless h/w has a
way to tell you.
Btw some IPs like Synopsis ahb ones will decrement the length value, so
reading the length will effectively tell you where you are.
> 
> For MEM2MEM, I would suggest these should either be reported as complete
> or not-complete in their entirety.  (In other words, either their full
> transfer size or zero.)  It's racy to try to do anything else with an
> in-progress transfer...
Agree, I would also think for mem-copy which is much faster any query
would give not so accurate results. probably by the time you report
value the descriptor might have finished!
> 
> DEV2DEV I've not thought about, and I'm rather wishing we didn't have
> that transfer type...
well everything boils down to hardware capability. I would expect decent
hardware design to be able to report.
But why would someone take the data inside SoC just to send it back.
Would anyone have a practical use of this?

-- 
~Vinod
