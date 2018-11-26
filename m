From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Nov 2018 15:58:56 -0800
Subject: [PATCH v2 0/5] Add Tegra194 Dual ARM SMMU driver
In-Reply-To: <1541029430-14150-1-git-send-email-vdumpa@nvidia.com>
References: <1541029430-14150-1-git-send-email-vdumpa@nvidia.com>
Message-ID: <20181126235856.vnseoe5lucfryc5p@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krishna,

On Wed, Oct 31, 2018 at 04:43:45PM -0700, Krishna Reddy wrote:
> NVIDIA's Xavier (Tegra194) SOC has three ARM SMMU(MMU-500) instances.
> Two of the SMMU instances are used to interleave IOVA accesses across them.
> The IOVA accesses from HW devices are interleaved across these two SMMU instances
> and they need to be programmed identical.
> 
> The existing ARM SMMU driver can't be used in its current form for programming the
> two SMMU instances identically. But, most of the code can be shared between ARM SMMU
> driver and Tegra194 SMMU driver.
> Page fault handling and TLB sync operations need to know about specific instance
> of SMMU for correct fault handling and optimal TLB sync wait. Rest of the code doesn't
> need to know about number of SMMU instances. Based on this fact, The patch series here
> rearranges the arm-smmu.c code to allow sharing most of the ARM SMMU programming/iommu_ops
> code between ARM SMMU driver and Tegra194 SMMU driver and transparently
> handles programming of two SMMU instances.

Based on what I can see, it seems that you're trying to describe two
pieces of hardware with only one device in the DT. That seems like an
odd choice. Also, it seems like all three SMMUs share the same interrupt
line? That's somewhat suboptimal IMHO, but harder to change.

Why not instantiate both of them and create a reference between then
such that the TLB and sync ops are done on both of them in the native
driver? I.e. two arm_smmu structs and a pointer between then (i.e. add a
"next shared smmu" pointer in the struct arm_smmu).

As long as devices only references one of them, locking only that one should
provide suitable protection as well.

Seems like a simpler approach than adding a new layer to the driver, but maybe
I am missing some complexity here?


-Olof
