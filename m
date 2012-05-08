From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 08 May 2012 00:19:30 -0400 (EDT)
Subject: [PATCH 2/2] remove the debugging restrictions in devicemaps_init()
In-Reply-To: <20120506163016.GA7412@n2100.arm.linux.org.uk>
References: <1331876668-32492-1-git-send-email-nico@fluxnic.net>
 <1331876668-32492-3-git-send-email-nico@fluxnic.net>
 <20120506163016.GA7412@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1205072340540.21030@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 6 May 2012, Russell King - ARM Linux wrote:

> On Fri, Mar 16, 2012 at 01:44:28AM -0400, Nicolas Pitre wrote:
> > More code is getting involved through devicemaps_init() these days,
> > including calls to printk() or BUG().  Not being able to access any
> > device to print out debugging information and only being presented with
> > a silent kernel crash in that case has become a major inconvenience
> > lately.
> > 
> > By having the active page table separate from the one being initialized,
> > it is possible to preserve the initial debug mapping that was set in
> > head.S until the final page table is ready.  Because there exists some
> > code that installs a partial mapping in order to probe the hardware
> > before installing additional mappings, it is necessary to set up the
> > vector mapping early which enables the fault handler to copy some of
> > the newly created mappings into our page table copy as needed.
> > 
> > This patch implements such a temporary page table copy only for
> > non LPAE configurations at the moment.
> 
> I've been thinking about this on and off since you posted it, and I'm now
> convinced this will cause regressions.  You've probably forgotten about
> those CPUs which need to read data in order to clear unwanted cache lines
> from their cache.

Hmmm... I didn't forget them, but I might not have thought those cases 
all the way through.

Those CPUs I know about with a need to read memory to clear cache lines 
are either StrongARM based or XScale based.  But in those cases it is 
only when cleaning up the whole cache that the process of filling the 
cache with dummy lines is involved.

> This patch would cause all such CPUs to freeze when switching to or from
> the temporary mapping, because neither page table will contain the necessary
> mappings to allow those accesses to succeed.

However, the switching itself doesn't involve a full cache flush.  Only 
clean_dcache_area() is involved when installing the temporary mapping, 
and that translates into cpu_dcache_clean_area() which on all those CPUs 
I previously listed is implemented with a loop of individual cache line 
clean operations.  Switching back to the real mapping doesn't involve 
any cache ops since a full cache flush is performed anyway once the new 
mapping is in place.  TLBs may not be incoherent at that point since 
both mappings are not conflicting with each other.

Therefore I don't think there should be any issues even on those CPUs, 
unless I've overlooked something.

Maybe you could test this on your Assabet simply by adding a dummy 
printk() in create_mapping() once this patch is applied?


Nicolas
