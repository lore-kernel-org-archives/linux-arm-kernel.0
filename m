From: stepanm@codeaurora.org (stepanm at codeaurora.org)
Date: Tue, 20 Jul 2010 22:18:55 -0700 (PDT)
Subject: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU,
	CPU and device memory management
Message-ID: <5a63b73ff04b72db2930eae4e43e5c5b.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What is the problem about mapping a 1MB buffer with the DMA API?
>
> Possibly, an IOMMU can't find space for 1MB but it's not the problem of
the DMA API.

As you have pointed out, one of the issues is that allocation can fail.
While technically VCMM allocations can fail as well, these allocations can
be made from one or more memory pools that have been set aside
specifically to be used by devices. Thus, the kernel's normal allocator
will not encroach on the large physically-contiguous chunks (of size 1MB
or even 16MB) that are not easy to get back, and would be forced to deal
with increasing memory pressure in other ways.
Additionally, some of the memory pools may have special properties, such
as being part of on-chip memory with higher performance than regular
memory, and some devices may have special requirements regarding what type
or memory they need. The VCMM allocator solves the problem in a generic
way by being able to deal with multiple memory pools and supporting
prioritization schemes for which subset of the memory pools is to be used
for each physical allocation.

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
