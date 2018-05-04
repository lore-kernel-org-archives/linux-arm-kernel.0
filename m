From: vkilari@codeaurora.org (vkilari at codeaurora.org)
Date: Fri, 4 May 2018 13:40:09 +0530
Subject: [PATCH v8 00/13] Support PPTT for ARM64
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
Message-ID: <050a01d3e37f$57678470$06368d50$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Jeremy Linton <jeremy.linton@arm.com>
> Sent: Thursday, April 26, 2018 5:01 AM
> To: linux-acpi at vger.kernel.org
> Cc: Sudeep.Holla at arm.com; linux-arm-kernel at lists.infradead.org;
> Lorenzo.Pieralisi at arm.com; hanjun.guo at linaro.org; rjw at rjwysocki.net;
> Will.Deacon at arm.com; Catalin.Marinas at arm.com;
> gregkh at linuxfoundation.org; Mark.Rutland at arm.com; linux-
> kernel at vger.kernel.org; linux-riscv at lists.infradead.org;
> wangxiongfeng2 at huawei.com; vkilari at codeaurora.org; ahs3 at redhat.com;
> Dietmar.Eggemann at arm.com; Morten.Rasmussen at arm.com;
> palmer at sifive.com; lenb at kernel.org; john.garry at huawei.com;
> austinwc at codeaurora.org; tnowicki at caviumnetworks.com;
> jhugo at qti.qualcomm.com; timur at qti.qualcomm.com;
> ard.biesheuvel at linaro.org; Jeremy Linton <jeremy.linton@arm.com>
> Subject: [PATCH v8 00/13] Support PPTT for ARM64
> 
> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
used to
> describe the processor and cache topology. Ideally it is used to
extend/override
> information provided by the hardware, but right now ARM64 is entirely
> dependent on firmware provided tables.
> 
> This patch parses the table for the cache topology and CPU topology.
> When we enable ACPI/PPTT for arm64 we map the package_id to the PPTT
> node flagged as the physical package by the firmware.
> This results in topologies that match what the remainder of the system
expects.
> Finally, we update the scheduler MC domain so that it generally reflects
the
> LLC unless the LLC is too large for the NUMA domain (or package).
> 
> For example on juno:
> [root at mammon-juno-rh topology]# lstopo-no-graphics
>   Package L#0
>     L2 L#0 (1024KB)
>       L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
>       L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
>       L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
>       L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
>     L2 L#1 (2048KB)
>       L1d L#4 (32KB) + L1i L#4 (48KB) + Core L#4 + PU L#4 (P#4)
>       L1d L#5 (32KB) + L1i L#5 (48KB) + Core L#5 + PU L#5 (P#5)
>   HostBridge L#0
>     PCIBridge
>       PCIBridge
>         PCIBridge
>           PCI 1095:3132
>             Block(Disk) L#0 "sda"
>         PCIBridge
>           PCI 1002:68f9
>             GPU L#1 "renderD128"
>             GPU L#2 "card0"
>             GPU L#3 "controlD64"
>         PCIBridge
>           PCI 11ab:4380
>             Net L#4 "enp8s0"
> 
> Git tree at:
> http://linux-arm.org/git?p=linux-jlinton.git
> branch: pptt_v8

Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>

> 
> v7->v8:
> Modify the logic used to select the MC domain (the change
>   shouldn't modify the sched domains on any existing machines
>   compared to v7, only how they are built) Reduce the severity of some
parsing
> messages.
> Fix s390 link problem.
> Further checks to deal with broken PPTT tables.
> Various style tweaks, SPDX license addition, etc.
> 
> v6->v7:
> Add additional patch to use the last cache level within the NUMA
>   or socket as the MC domain. This assures the MC domain is
>   equal or smaller than the DIE.
> 
> Various formatting/etc review comments.
> 
> Rebase to 4.16rc2
> 
> v5->v6:
> Add additional patches which re-factor how the initial DT code sets
>   up the cacheinfo structure so that its not as dependent on the
>   of_node stored in that tree. Once that is done we rename it
>   for use with the ACPI code.
> 
> Additionally there were a fair number of minor name/location/etc
>   tweaks scattered about made in response to review comments.
> 
> v4->v5:
> Update the cache type from NOCACHE to UNIFIED when all the cache
>   attributes we update are valid. This fixes a problem where caches
>   which are entirely created by the PPTT don't show up in lstopo.
> 
> Give the PPTT its own firmware_node in the cache structure instead of
>   sharing it with the of_node.
> 
> Move some pieces around between patches.
> 
> (see previous cover letters for futher changes)
> 
> Jeremy Linton (13):
>   drivers: base: cacheinfo: move cache_setup_of_node()
>   drivers: base: cacheinfo: setup DT cache properties early
>   cacheinfo: rename of_node to fw_token
>   arm64/acpi: Create arch specific cpu to acpi id helper
>   ACPI/PPTT: Add Processor Properties Topology Table parsing
>   ACPI: Enable PPTT support on ARM64
>   drivers: base cacheinfo: Add support for ACPI based firmware tables
>   arm64: Add support for ACPI based firmware tables
>   ACPI/PPTT: Add topology parsing code
>   arm64: topology: rename cluster_id
>   arm64: topology: enable ACPI/PPTT based CPU topology
>   ACPI: Add PPTT to injectable table list
>   arm64: topology: divorce MC scheduling domain from core_siblings
> 
>  arch/arm64/Kconfig                |   1 +
>  arch/arm64/include/asm/acpi.h     |   4 +
>  arch/arm64/include/asm/topology.h |   6 +-
>  arch/arm64/kernel/cacheinfo.c     |  15 +-
>  arch/arm64/kernel/topology.c      | 103 +++++-
>  arch/riscv/kernel/cacheinfo.c     |   1 -
>  drivers/acpi/Kconfig              |   3 +
>  drivers/acpi/Makefile             |   1 +
>  drivers/acpi/pptt.c               | 678
> ++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/tables.c             |   2 +-
>  drivers/base/cacheinfo.c          | 157 ++++-----
>  include/linux/acpi.h              |   4 +
>  include/linux/cacheinfo.h         |  18 +-
>  13 files changed, 886 insertions(+), 107 deletions(-)  create mode 100644
> drivers/acpi/pptt.c
> 
> --
> 2.13.6
