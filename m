From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Fri, 01 Apr 2011 07:03:16 -0700
Subject: [PATCH 04/12] mm: alloc_contig_freed_pages() added
In-Reply-To: <op.vs8cf5xd3l0zgt@mnazarewicz-glaptop>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-5-git-send-email-m.szyprowski@samsung.com>
	<1301587083.31087.1032.camel@nimitz>
	<op.vs77qfx03l0zgt@mnazarewicz-glaptop>
	<1301606078.31087.1275.camel@nimitz>
	<op.vs8awkrx3l0zgt@mnazarewicz-glaptop>
	<1301610411.30870.29.camel@nimitz>
	<op.vs8cf5xd3l0zgt@mnazarewicz-glaptop>
Message-ID: <1301666596.30870.176.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-01 at 00:51 +0200, Michal Nazarewicz wrote:
> On Fri, 01 Apr 2011 00:26:51 +0200, Dave Hansen <dave@linux.vnet.ibm.com>  
> wrote:
> >> Bug in the above place does not mean that we could not allocate  
> >> memory.  It means caller is broken.
> >
> > Could you explain that a bit?
> >
> > Is this a case where a device is mapped to a very *specific* range of
> > physical memory and no where else?  What are the reasons for not marking
> > it off limits at boot?  I also saw some bits of isolation and migration
> > in those patches.  Can't the migration fail?
> 
> The function is called from alloc_contig_range() (see patch 05/12) which
> makes sure that the PFN is valid.  Situation where there is not enough
> space is caught earlier in alloc_contig_range().
> 
> alloc_contig_freed_pages() must be given a valid PFN range such that all
> the pages in that range are free (as in are within the region tracked by
> page allocator) and of MIGRATETYPE_ISOLATE so that page allocator won't
> touch them.

OK, so it really is a low-level function only.  How about a comment that
explicitly says this?  "Only called from $FOO with the area already
isolated."  It probably also deserves an __ prefix.

> That's why invalid PFN is a bug in the caller and not an exception that
> has to be handled.
> 
> Also, the function is not called during boot time.  It is called while
> system is already running.

What kind of success have you had running this in practice?  I'd be
worried that some silly task or a sticky dentry would end up in the
range that you want to allocate in.  


-- Dave
