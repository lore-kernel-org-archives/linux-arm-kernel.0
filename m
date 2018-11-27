From: vdumpa@nvidia.com (Krishna Reddy)
Date: Tue, 27 Nov 2018 02:30:05 +0000
Subject: [PATCH v2 0/5] Add Tegra194 Dual ARM SMMU driver
In-Reply-To: <20181126235856.vnseoe5lucfryc5p@localhost>
References: <1541029430-14150-1-git-send-email-vdumpa@nvidia.com>
 <20181126235856.vnseoe5lucfryc5p@localhost>
Message-ID: <BYAPR12MB27598D08E89D93CD8C171993B3D00@BYAPR12MB2759.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
Thanks for the comments!

>>Based on what I can see, it seems that you're trying to describe two
pieces of hardware with only one device in the DT. That seems like an
odd choice. 

T194 SOC HW is designed to use Two ARM SMMU's together like one SMMU.
The IOVA accesses from the HW controllers clients is interleaved across these Two
SMMU's by Memory controller HW.
Even though,  there are two ARM SMMU's,  HW design requires SW programming
these two ARM SMMU instances identically.

>>Also, it seems like all three SMMUs share the same interrupt
line? That's somewhat suboptimal IMHO, but harder to change.

This is by HW design.  SMMU interrupts are only expected if there is an illegal IOVA
access, which shouldn't happen in practical. The SMMU interrupts are only used
to log the faults and for debug purpose on T194.


>>Why not instantiate both of them and create a reference between then
such that the TLB and sync ops are done on both of them in the native
driver? I.e. two arm_smmu structs and a pointer between then (i.e. add a
"next shared smmu" pointer in the struct arm_smmu).

DMA framework supports only one SMMU driver instance per device.
SMMU driver setup iommu_ops pointer in the device struct during the boot when
the platform device is added to the bus.
There is no support to allow a platform device register with two different SMMU
devices.
Two different  SMMU instances is 2x page table memory and 2x map/unmap overhead.
With SMMU driver knowing about two smmu instances, page table memory usage, map/unmap
Overhead would be efficient.

>>As long as devices only references one of them, locking only that one should
provide suitable protection as well.

Earlier proposal on creating one Master SMMU node and slave SMMU nodes within isn't liked. 
Will has proposed creating a library and reusing the code. I have made the patches
to share the code.
https://www.spinics.net/lists/linux-tegra/msg35539.html
https://www.spinics.net/lists/linux-tegra/msg35494.html


>>Seems like a simpler approach than adding a new layer to the driver, but maybe
>>I am missing some complexity here?

Programming both SMMU instances identically with existing ARM SMMU driver is not
possible with multiple DT nodes. 
In the following patch, by writel* macro override, both ARM SMMU instances are
programmed identically in  Tegra194 SMMU driver transparently. Only tlb sync and
interrupt handling need to know about specific instance.

https://lkml.org/lkml/2018/11/1/573
+#define writel_relaxed writel_relaxed_all
+#define writeq_relaxed writeq_relaxed_all
+#define writel writel_all

-KR
