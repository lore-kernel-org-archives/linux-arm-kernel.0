From: wmills@ti.com (Bill Mills)
Date: Sun, 5 Jun 2016 23:20:25 -0400
Subject: [RFC v2 0/4] ARM LPAE Outer Shared v2
Message-ID: <1465183229-24147-1-git-send-email-wmills@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This RFC series adds support for outer shared LPAE page table
attributes. This attribute is needed by at least keystone to achieve
dma coherency. The choice is done at early boot time and can co-exist
with other platforms that want only inner shared.

v2 addresses the concern about changing the memory attributes while the
MMU is on that was raised in v1. It also puts the primary
responsibility of choosing the right mode on the platform.

Instead of creating an "need outer shared flag" to the pv_fixup code, I
created a generic attribute modification mechanism. The idea was it
could be used to solve other problems where the assumptions of the
early boot tables need to be changed in a safe manner. Right now it is
LPAE only and tied 1:1 with pv_fixup but that could change. I did test
that applying a 0 pv_fixup seemed to do no harm.

There is a patch that adds an early param "defshared". This is a
separate patch as I am unsure if this is really desired. It is useful
for testing the series however. You can use it to force keystone to
use inner shared (and it will fallback to non-coherent dma-ops) or you
can use it to force another platform to use outer shared and see what
happens. If we keep the param, documentation will be added.

This series needs more testing and finishing but I wanted to get a read
on the direction. This does run on Keystone and for QEMU vexpress-A15.
QEMU vexpress runs with inner or outer shared :)
Multiple TODO points marked in-line. If the approach is accepted I
will complete the TODO items and TI will do more testing.

Series based on V4.7-rc2

v1 was here:
http://marc.info/?t=146044908600005&r=1&w=2

-- Bill
