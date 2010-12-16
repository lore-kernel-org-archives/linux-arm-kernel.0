From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 16 Dec 2010 16:05:34 -0500
Subject: [PATCH 0/3] fix for issues resulting from the stack based kmap_atomic
Message-ID: <1292533537-26760-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is for the current -rc kernel.

The stack based kmap_atomic made the various KM_* fixed values
irrelevant to kmap_atomic(), however some ad hoc mapping functions
used for cache maintenance purposes are still using those fixed values
which may clash with the dynamically assigned entries in kmap_atomic().
Let's solve this issue by getting rid of those ad hoc mapping functions
which are largely unneeded now anyway.

In the Feroceon and XSC3 cases, this might introduce a slight performance
hit in the form of a needless cache flush for an empty cache.  Keeping the
exact same behavior as before is not straight forward, and it is not clear
if this is worth the trouble either.  So let's care about correctness for
now, and see if someone actually cares about this possible performance
impact later, if any.

In the meantime, the cleanup factor is non negligible:

 arch/arm/include/asm/highmem.h  |    3 -
 arch/arm/mm/cache-feroceon-l2.c |   37 +++++++-------
 arch/arm/mm/cache-xsc3l2.c      |   57 ++++++++--------------
 arch/arm/mm/dma-mapping.c       |    7 ++-
 arch/arm/mm/flush.c             |    7 ++-
 arch/arm/mm/highmem.c           |   87 ---------------------------------
 6 files changed, 48 insertions(+), 150 deletions(-)


Nicolas
