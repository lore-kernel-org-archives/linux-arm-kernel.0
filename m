From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 27 Jun 2014 20:22:12 +0900
Subject: [PATCH v3 0/2] drm: nouveau: memory coherency for ARM
Message-ID: <1403868134-31741-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2 was doing some pretty nasty things with the DMA API, so I took a different
approach for this v3.

As suggested, this version uses ttm_dma_populate() to populate BOs. The reason
for doing this was that it would entitle us to using the DMA sync functions,
but since the memory returned is already coherent anyway, we do not even
need to call these functions anymore.

So this series has turned into 2 small patches:

- The first attempts to make it more obvious that Nouveau can use different
ways to populate TTs, and make it possible to choose which method to use from
a single place.
- The second leverages this work to select the DMA allocator to populate TTs
on ARM.

Doing this solves all our coherency problems with Nouveau on Tegra, and
hopefully makes the code easier to read in the process.

Alexandre Courbot (2):
  drm/nouveau: cleanup TTM population logic
  drm/nouveau: use DMA TT population method on ARM

 drivers/gpu/drm/nouveau/nouveau_bo.c  | 63 ++++++++++++++++++-----------------
 drivers/gpu/drm/nouveau/nouveau_drm.h | 11 ++++++
 drivers/gpu/drm/nouveau/nouveau_ttm.c | 17 ++++++++++
 3 files changed, 61 insertions(+), 30 deletions(-)

-- 
2.0.0
