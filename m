From: will.deacon@arm.com (Will Deacon)
Date: Thu, 27 Feb 2014 18:15:44 +0000
Subject: arm64 cache maintenance on read only address loops forever
In-Reply-To: <530E5F60.4050701@codeaurora.org>
References: <530D74C2.4000402@codeaurora.org>
 <20140226135521.GF8961@mudshark.cambridge.arm.com>
 <530E5F60.4050701@codeaurora.org>
Message-ID: <20140227181544.GL30003@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Wed, Feb 26, 2014 at 09:40:48PM +0000, Laura Abbott wrote:
> On 2/26/2014 5:55 AM, Will Deacon wrote:
> > On Wed, Feb 26, 2014 at 04:59:46AM +0000, Laura Abbott wrote:
> >> Calling cache maintenance on an address that hasn't actually been
> >> written to isn't all that useful but looping forever seems like a poor
> >> result. It seems like the check in do_page_fault is too restrictive and
> >> we need to be able to fault in pages via cache maintenance.
> >
> > My understanding is that the EL0 cache maintenance instructions only require
> > read permission (note that DC ZVA is treated like a store and doesn't set
> > ESR.CM), so I'm failing to appreciate the problem here.
> >
> > Do you have a small testcase I can play with?
> >
> 
> 
> You probably won't like the test case because it's breaking assumptions 
> pretty badly. This uses 96f083d416c0d01687ed5b37074831f461838455 from
> Catalin's devel branch to call __dma_inv_range on an mmaped user space
> address. I see three possible outcomes:
> 
> 1) The test while questionable may have some merit and we will be able 
> to flush user space addresses using this API without causing a problem.
> 
> 2) The test is bad. Instead of looping forever we will instead die with 
> a fault.
> 
> 3) The test is really really bad. Looping forever is your punishment.

Ok, I spent some time getting your test working and, after managing to run
it, it promptly destroyed the flash on my FPGA. Once I managed to recover
that, the issue seems to be that __dma_inv_range doesn't have an exception
table entry for the dc ivac, mainly because it's written to be used only on
the kernel linear mapping. As such, __do_page_fault won't actually resolve
anything. If you enabled CONFIG_DEBUG_VM, you'll get a SEGV at the cost of
searching the tables at fault time.

So yeah, I'd say (2) or (3) depending on your .config ;)

Will
