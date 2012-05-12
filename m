From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 May 2012 14:49:16 +0100
Subject: [PATCH 2/2] remove the debugging restrictions in devicemaps_init()
In-Reply-To: <alpine.LFD.2.02.1205081214220.21030@xanadu.home>
References: <1331876668-32492-1-git-send-email-nico@fluxnic.net>
 <1331876668-32492-3-git-send-email-nico@fluxnic.net>
 <20120506163016.GA7412@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1205072340540.21030@xanadu.home>
 <20120508071411.GP26481@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1205081214220.21030@xanadu.home>
Message-ID: <20120512134916.GB10453@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 12:17:40PM -0400, Nicolas Pitre wrote:
> On Tue, 8 May 2012, Russell King - ARM Linux wrote:
> 
> > On Tue, May 08, 2012 at 12:19:30AM -0400, Nicolas Pitre wrote:
> > > However, the switching itself doesn't involve a full cache flush.
> > 
> > That's where you're wrong.  Look at the switch_mm() helpers in proc-*.S.
> > StrongARM for example calls v4wb_flush_kern_cache_all() here, which needs
> > the cache flushing mappings to be in place in the _current_ page table.
> 
> Right.  I had to be wrong somewhere.
> 
> What about abstracting the cache area mapping code in a function of its 
> own, and calling it inside install_temp_mm() as well?

One of the issues is that we check that the mappings don't conflict -
in other words, a section mapping doesn't conflict with a page table
mapping.  We need a clean page table to start with before we start
populating it with the IO entries, so that we know there's no mappings
in IO space to conflict with the newly setup entries.

What we could do is allocate a new page table, use that page table to
setup the new mappings, memcpy them to the swapper page table as a
final step before we kick the caches and TLB.

The down side to that approach is we have people abusing the map_io
method for other purposes (people - including you - just don't listen
when I tell them that they shouldn't do this kind of stuff) such as
setting up mappings which they then immediately access.  (In case
you've forgotten, Assabet, the probing of the SCR register at map_io
time to discover the platforms configuration.  That set the precident
and now other platforms also do this kind of thing.)

So, I don't think there's any easy solution to this - certainly not
one which is going to be fragile or restricted to a small set of
configurations.

Overall, I'm not sure it's worth trying to solve this.
