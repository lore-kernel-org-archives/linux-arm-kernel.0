From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 4 Mar 2016 11:23:46 +0000
Subject: [RFC PATCH 0/8] PM / Domains: Add support for removing PM domains
Message-ID: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to safely remove PM domains there are a few changes that need to be
made to ensure that no one is holding an external reference to a PM domain
after it has been removed. One solution, implemented here, solves this by
eliminating external references to PM domain. Another alternative would be
to employ some reference counting for the PM domains, however, I did not see
a good reason for allowing external references in the first place (as always
there could be something that I have over-looked!).

Jon Hunter (8):
  PM / Domains: Add new helper functions for device-tree
  ARM: EXYNOS: Remove calls to of_genpd_get_from_provider()
  staging: board: Remove calls to of_genpd_get_from_provider()
  PM / Domains: Don't expose generic_pm_domain structure
  PM / Domains: Verify the PM domain is present when adding a provider
  PM / Domains: Remove a provider by referencing the data pointer
  PM / Domains: Prepare for adding support to remove PM domains
  PM / Domains: Add support for removing PM domains

 arch/arm/mach-exynos/pm_domains.c |  23 +--
 drivers/base/power/domain.c       | 324 +++++++++++++++++++++++++++++++++++---
 drivers/staging/board/board.c     |   9 +-
 include/linux/pm_domain.h         |  55 ++++---
 4 files changed, 348 insertions(+), 63 deletions(-)

-- 
2.1.4
