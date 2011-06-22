From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Jun 2011 14:42:20 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <201106220903.31065.hverkuil@xs4all.nl>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106150937.18524.arnd@arndb.de>
	<201106220903.31065.hverkuil@xs4all.nl>
Message-ID: <201106221442.20848.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 June 2011, Hans Verkuil wrote:
> > How about a Kconfig option that defines the percentage of memory
> > to set aside for contiguous allocations?
> 
> I would actually like to see a cma_size kernel option of some sort. This would
> be for the global CMA pool only as I don't think we should try to do anything
> more complicated here.

A command line is probably good to override the compile-time default, yes.

We could also go further and add a runtime sysctl mechanism like the one
for hugepages, where you can grow the pool at run time as long as there is
enough free contiguous memory (e.g. from init scripts), or shrink it later
if you want to allow larger nonmovable allocations.

My feeling is that we need to find a way to integrate the global settings
for four kinds of allocations:

* nonmovable kernel pages
* hugetlb pages
* CMA
* memory hotplug

These essentially fight over the same memory (though things are slightly
different with dynamic hugepages), and they all face the same basic problem
of getting as much for themselves without starving the other three.

	Arnd
