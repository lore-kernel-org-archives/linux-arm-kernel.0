From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Jul 2014 18:46:49 +0100
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140717142720.GM21153@arm.com>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140717102425.34fe0181@free-electrons.com>
 <20140717083342.GS21766@n2100.arm.linux.org.uk>
 <6510599.Qoc205T3v7@wuerfel>
 <20140717131224.GW21766@n2100.arm.linux.org.uk>
 <20140717142720.GM21153@arm.com>
Message-ID: <20140728174649.GL15536@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 03:27:20PM +0100, Will Deacon wrote:
> On Thu, Jul 17, 2014 at 02:12:24PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Jul 17, 2014 at 02:39:42PM +0200, Arnd Bergmann wrote:
> > > On Thursday 17 July 2014 09:33:42 Russell King - ARM Linux wrote:
> > > > No - the problem is that we're running from the page table in question
> > > > with global mappings, and we need to switch all these mappings, including
> > > > the ones we're currently using to execute from.
> > > > 
> > > > We can't even create a new page table and switch to it because the
> > > > mappings in question are global mappings.
> > > > 
> > > > The only way to do that safely from an architectural point of view would
> > > > be to turn the MMU off, and drop back to assembly code to change the
> > > > page tables, and re-enable the MMU.  For something as obscure as Marvell's
> > > > coherency stuff, that's not something I want to see in core code.
> > > 
> > > Is this different from what we do in the LPAE version of
> > > early_paging_init()? That code already adjusts all the page
> > > table entries on a per-platform setting and should be very
> > > easy to extend for a modified procinfo->__cpu_mm_mmu_flags,
> > > and possibly able to extend for traditional (non-LPAE)
> > > page tables without a lot of duplication.
> > 
> > I'm going to have to profess no knowledge of how the LPAE stuff works.
> > LPAE is something I can't run, and something that I was not involved
> > in its creation.  Therefore, I know very little about it and zero
> > experience thereof.
> > 
> > From a glance over that function, I think that is unsafe for all the
> > reasons I've stated.  However, I'll pass this over to Will Deacon
> > to comment further on.
> 
> Just an FYI, but I've had to check internally to clarify the behaviour
> around TLB conflict aborts. We're changing live page tables here, but the
> *only* thing to differ is the output address, which I would hope is ok but
> need to check to be sure.
> 
> The ARM ARM recommends always going via an invalid mapping, but that's not
> always the most practical thing to do.

Ok, the answer from the architects is that we really shouldn't be doing
this. If we have two mappings for the same VA, then we run the risk of a
TLB conflict abort on implementations that can detect it. If we don't get
the abort, we can still have other things silently go wrong like exclusive
accesses, memory-ordering but, more importantly, it places us square in
UNPREDICTABLE territory, which isn't a friendly place to be.

So, we should fix the code we currently have for keystone so that it avoids
this possibility and avoid duplicating it elsewhere before we've done that.

I think Russell had a patch adding a comment, but I'd go further and add a
WARN_ON(1) because this is only going to be a source of subtle,
hard-to-debug issues that we'll really struggle to get to the bottom of.

Will
