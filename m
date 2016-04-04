From: joro@8bytes.org (Joerg Roedel)
Date: Mon,  4 Apr 2016 17:49:16 +0200
Subject: [PATCH 0/6 v2] of: Implement iterator for phandles
Message-ID: <1459784962-9808-1-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here is a new version of the implementation of the iterator
over phandles concept which Rob Herring suggested to me some
time ago. My approach is a little bit different from what
the diff showed back then, but it gets rid of the allocation
and 'struct of_phandle_args' misuse.

I also converted the arm-smmu driver to make use of the
iterator. The resulting kernel boots on my AMD Seattle
system and fixes the warning triggered there. The patches
now also pass all dt-unittests in my kvm environment.

Patches are based on v4.6-rc2

Thanks,

	Joerg

Changes since v1:

* Rebased to v4.6-rc2

* Removed the 'if (i == 0)...' hunk from the last patch

* Tested again with DT unit-tests and on the seattle system

Changes since RFC post:

* Reordered members of 'struct of_phandle_iterator' and did
  some renaming

* Removed index counting from the iterator

* Split up iterator implementation into multiple patches

* Fixed the code to survive all dt-unittests, tested with each
  patch in this series

* Re-added and updated some comments which got lost during the
  conversion.

* Added of_for_each_phandle macro for easier handling

* Moved the counting special-case from __of_parse_phandle_with_args
  directly to of_count_phandle_with_args for code
  simplification

* Removed some iterator helper functions

* Formatting and style changes

Joerg Roedel (6):
  of: Introduce struct of_phandle_iterator
  of: Move phandle walking to of_phandle_iterator_next()
  of: Remove counting special case from __of_parse_phandle_with_args()
  of: Introduce of_for_each_phandle() helper macro
  of: Introduce of_phandle_iterator_args()
  iommu/arm-smmu: Make use of phandle iterators in device-tree parsing

 drivers/iommu/arm-smmu.c |  38 +++++++--
 drivers/of/base.c        | 206 ++++++++++++++++++++++++++++++-----------------
 include/linux/of.h       |  56 +++++++++++++
 3 files changed, 219 insertions(+), 81 deletions(-)

-- 
1.9.1
