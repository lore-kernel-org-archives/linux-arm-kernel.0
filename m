From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:34:33 +0000
Subject: [PATCH 0/5] Minor cleanups to kernel pte handling
Message-ID: <20120120103433.GF1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of five patches cleans up the pte handling for users of
the 'TOP_PTE' - those CPUs which require special handling of cache
aliases and the like.

TOP_PTE() always was ugly, so this patch set gets rid of it, in favour
of a couple of helper functions (set_top_pte() and get_top_pte()).
set_top_pte() contains the necessary local TLB flush to ensure that
the update will be seen by the MMU.

We also centralize the virtual addresses used for these mappings into
arch/arm/mm/mm.h.

Finally, we transform pfn_pte(page_to_pfn(page), prot) to
mk_pte(page, prot) as we don't need to open-code this operation, and
we have this helper anyway.

 arch/arm/mm/copypage-v4mc.c   |    9 ++-------
 arch/arm/mm/copypage-v6.c     |   20 ++++++--------------
 arch/arm/mm/copypage-xscale.c |    9 +--------
 arch/arm/mm/flush.c           |   14 +++++---------
 arch/arm/mm/highmem.c         |   21 ++++++++-------------
 arch/arm/mm/mm.h              |   26 +++++++++++++++++++++++++-
 6 files changed, 47 insertions(+), 52 deletions(-)
