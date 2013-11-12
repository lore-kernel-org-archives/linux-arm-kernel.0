From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 12 Nov 2013 14:11:21 +0000
Subject: [PATCH 0/2] swiotlb-xen fixes
Message-ID: <alpine.DEB.2.02.1311121404590.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series is just a couple of fixes for swiotlb-xen.

In particular the slow path (bouncing on the swiotlb buffer for dma
operations) on ARM has two problems, each of them fixed by a separate
patch:

- a xen_dma_map_page call is missing in xen_swiotlb_map_sg_attrs;

- dma_capable often fails on ARM because devices don't set the dma_mask
  correctly. This causes swiotlb-xen to take the slow path, and that is
  bad enough, but in xen_swiotlb_map_page also causes the function to
  return an error an fail.



Stefano Stabellini (2):
      swiotlb-xen: add missing xen_dma_map_page call
      swiotlb-xen: xen_swiotlb_map_page: do not error out if dma_capable fails

 drivers/xen/swiotlb-xen.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)


git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git for-linus-3.13-fixes

Cheers,

Stefano
