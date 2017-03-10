From: josh.beavers@gmail.com (Josh Beavers)
Date: Fri, 10 Mar 2017 00:45:55 -0500
Subject: Managing shared buffers on VIVT cache systems
Message-ID: <CAE=AiOO4J1qGjZb5dqhniQ04aV+WBh4HU+TLsDbXgkrATB8iiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am debugging a driver that shared buffers between the kernel and
userspace.  These buffers are allocated by vmalloc_user() and mapped
by arch_get_unmapped_area_topdown() in arch/arm.

This driver works on other platforms, but on VIVT (Virtually Indexed
Virtually Tagged) cache systems inconsistent data seems to be
observed.  This is presumably due to cache aliasing (multiple virtual
mappings of a single physical memory location).

Attempts at manually flushing the dcache and using a cache coloring
approach both seem to have failed me.  In particular, I am interested
in why arch/arm/mm/mmap.c has the comment "We unconditionally provide
this function for all cases, however in the VIVT case, we optimize out
the alignment rules."  Both arch_get_unmapped_area() and
arch_get_unmapped_area_topdown() have aliasing code that is
conditional on a VIPT cache existing, but not VIVT.

Does this imply a different method exists for managing this same
situation on VIVT systems?  What is the best practice for managing
this on ARM with VIVT?

Is there a "correct" way to vmalloc a page-aligned buffer on such a system?

Thanks,
-J
