From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 31 Dec 2013 12:20:56 +0100
Subject: Regression (ARM) arch/arm/mm/init.c doesn't build without
 CONFIG_ARM_PATCH_PHYS_VIRT.
Message-ID: <m38uv1uuzr.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mm/init.c: In function 'setup_dma_zone':
arch/arm/mm/init.c:232:19: error: '__pv_phys_offset' undeclared (first use in this function)

Reverting the following commit fixes it:

commit 787b0d5c1ca7ff24feb6f92e4c7f4410ee7d81a8
Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date:   Mon Dec 2 20:29:12 2013 +0100

    ARM: 7908/1: mm: Fix the arm_dma_limit calculation

    Current code is using PHYS_OFFSET to calculate the arm_dma_limit which
    will lead to wrong calculations in cases where PHYS_OFFSET is updated
    runtime.

    So fix the code by using __pv_phys_offset instead of PHYS_OFFSET.

It seems PHYS_OFFSET is equal to __pv_phys_offset if the latter is
available:

arch/arm/include/asm/memory.h:#define PHYS_OFFSET __pv_phys_offset

Otherwise (without CONFIG_ARM_PATCH_PHYS_VIRT) PHYS_OFFSET is a
hard-coded CONFIG value, or whatever the platform/CPU code needs:

arch/arm/include/asm/memory.h:#define PHYS_OFFSET     PLAT_PHYS_OFFSET

Perhaps the patch in question was needed at some point but I think the
situation had changed before it was commited.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
