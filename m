From: rrichter@cavium.com (Robert Richter)
Date: Thu, 15 Nov 2018 21:50:57 +0000
Subject: [PATCH 0/2] irqchip/gic-v3-its: Use CMA for its table allocation
Message-ID: <20181115215012.23922-1-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gicv3-its device table may have a size of up to 16MB (Cavium
ThunderX). With 4k pagesize the maximum size of memory allocation is
4MB. This series implements the use of CMA for allocation of large its
tables. To achieve this we need to make an its node a kernel device
(patch #1) and rework the its table allocation code (patch #2). Both
can only be done after the arch_initcall and thus this patch series
bases on my previous series that implements late its initialization:

      https://patchwork.kernel.org/cover/10673117/

Using its nodes as kernel devices has the side effect to ease the
release of resources (devres used) and device based messages (dev_*
printk variants used).

The new its table allocator still uses the old scheme for small tables
to allow a further rework that supports NUMA-aware its tables.

Robert Richter (2):
  irqchip/gic-v3-its: Handle its nodes as kernel devices
  irqchip/gic-v3-its: Use CMA for allocation of large device tables

 drivers/irqchip/irq-gic-v3-its.c | 224 +++++++++++++++++++++++----------------
 1 file changed, 135 insertions(+), 89 deletions(-)

-- 
2.11.0
