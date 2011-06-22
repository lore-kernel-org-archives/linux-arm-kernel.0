From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Jun 2011 15:39:23 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous
	=?iso-8859-1?q?Memory=09Allocator?= added
In-Reply-To: <003701cc30de$7a159710$6e40c530$%szyprowski@samsung.com>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106221442.20848.arnd@arndb.de>
	<003701cc30de$7a159710$6e40c530$%szyprowski@samsung.com>
Message-ID: <201106221539.24044.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 June 2011, Marek Szyprowski wrote:
> Sounds really good, but it might be really hard to implemnt, at least for
> CMA, because it needs to tweak parameters of memory management internal 
> structures very early, when buddy allocator has not been activated yet.

Why that? I would expect you can do the same that hugepages (used to) do
and just attempt high-order allocations. If they succeed, you can add them
as a CMA region and free them again, into the movable set of pages, otherwise
you just fail the  request from user space when the memory is already
fragmented.
 
> > These essentially fight over the same memory (though things are slightly
> > different with dynamic hugepages), and they all face the same basic problem
> > of getting as much for themselves without starving the other three.
> 
> I'm not sure we can solve all such issues in the first version. Maybe we should
> first have each of the above fully working in mainline separately and then
> start the integration works.

Yes, makes sense. We just need to be careful not to introduce user-visible
interfaces that we cannot change any more in the process.

	Arnd
