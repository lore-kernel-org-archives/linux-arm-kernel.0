From: linuc.decode@gmail.com (Linu Cherian)
Date: Sun, 10 Dec 2017 08:05:49 +0530
Subject: [PATCH 0/2] arm64 SMMUv3 PMU driver with IORT support
In-Reply-To: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <20171210023549.GA22492@virtx40>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Fri Aug 04, 2017 at 03:59:12PM -0400, Neil Leeder wrote:
> This adds a driver for the SMMUv3 PMU into the perf framework.
> It includes an IORT update to support PM Counter Groups.
>

In one of Cavium's upcoming SOC, SMMU PMCG implementation is such a way
that platform bus id (Device ID in ITS terminmology)is shared with that of SMMU.
This would be a matter of concern for software if the SMMU and SMMU PMCG blocks
are managed by two independent drivers.

The problem arises when we want to alloc/free MSIs for these devices
using the APIs, platform_msi_domain_alloc/free_irqs. 
Platform bus id being same for these two hardware blocks, they end up sharing the same
ITT(Interrupt Translation Table) in GIC ITS and hence alloc, free and management 
of this shared ITT becomes a problem when they are managed by two independent
drivers.

We were looking into the option of keeping the SMMU PMCG nodes as sub nodes under
SMMUv3 node, so that SMMUv3 driver could probe and figure out the total vectors
required for SMMU PMCG devices and make a common platform_msi_domain_alloc/free_irqs
function call for all devices that share the platform bus id.

Would like to know your expert opinion on what would be the right approach 
to handle this case ?

Thanks.


 
> IORT has no mechanism for determining device names so PMUs
> are named based on their physical address. 
> 
> Tested on Qualcomm QDF2400. perf_fuzzer ran for 4+ hours
> with no failures.
> 
> Neil Leeder (2):
>   acpi: arm64: add iort support for PMCG
>   perf: add arm64 smmuv3 pmu driver
> 
>  drivers/acpi/arm64/iort.c     |  54 +++
>  drivers/perf/Kconfig          |   9 +
>  drivers/perf/Makefile         |   1 +
>  drivers/perf/arm_smmuv3_pmu.c | 823 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/actbl2.h         |   9 +-
>  5 files changed, 895 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/perf/arm_smmuv3_pmu.c
> 
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Linu cherian
