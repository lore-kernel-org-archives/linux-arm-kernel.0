From: juri.lelli@arm.com (Juri Lelli)
Date: Thu, 11 May 2017 09:48:30 +0100
Subject: [PATCH v4 0/8] Fix issues and factorize arm/arm64 capacity
 information code
In-Reply-To: <20170420144316.15632-1-juri.lelli@arm.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
Message-ID: <20170511084830.rn32pvi6weej2cna@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

I'm not sure what your plans are with this set. Are we targeting 4.12?

IMHO, if possible, it would be good to have this refactoring in now, so
that we can base further development on it for the next cycle.

Thanks,

- Juri

On 20/04/17 15:43, Juri Lelli wrote:
> Hi,
> 
> arm and arm64 topology.c share a lot of code related to parsing of capacity
> information. This is v4 of a solution [1] (based on Will's, Catalin's and
> Mark's off-line suggestions) to move such common code in a single place:
> drivers/base/arch_topology.c (by creating such file and conditionally compiling
> it for arm and arm64 only).
> 
> First 4 patches are actually fixes for the current code.
> 
> Patch 5 is the actual refactoring.
> 
> Patch 6 removes one of the extern symbols by changing a bit the now common
> code.
> 
> Patch 7 removes the remaining externs (as required by Russell during v1 review)
> by creating a new header file include/linux/arch_topology.h and including that
> from arm, arm64 and drivers.
> 
> Last patch addresses Dietmar's comments to v1 and adds a 'atd_' prefix to
> interfaces exported by drivers code and used by arch (and potentially others in
> the future).
> 
> Changes from v3:
> 
>  - rebase on top of 4.11-rc7
>  - addressed Vincent's comment on patch 3/8
>  - removed v3 6/9 as discussed with Russell
>  - added Russell and Catalin's Acked-by
> 
> The set is based on top of linux/master (4.11-rc7 f61143c45077) and it is also
> available from:
> 
>  git://linux-arm.org/linux-jl.git upstream/default_caps_factorize-v4
> 
> Best,
> 
> - Juri
> 
> [1] v1 - https://marc.info/?l=linux-kernel&m=148483680119355&w=2
>     v2 - https://marc.info/?l=linux-kernel&m=148663344018205&w=2
>     v3 - http://marc.info/?l=linux-kernel&m=149062080701399&w=2
> 
> Juri Lelli (8):
>   Documentation: arm: fix wrong reference number in DT definition
>   Documentation/ABI: add information about cpu_capacity
>   arm: fix return value of parse_cpu_capacity
>   arm: remove wrong CONFIG_PROC_SYSCTL ifdef
>   arm, arm64: factorize common cpu capacity default code
>   arm,arm64,drivers: reduce scope of cap_parsing_failed
>   arm,arm64,drivers: move externs in a new header file
>   arm,arm64,drivers: add a prefix to drivers arch_topology interfaces
> 
>  Documentation/ABI/testing/sysfs-devices-system-cpu |   7 +
>  Documentation/devicetree/bindings/arm/cpus.txt     |   4 +-
>  arch/arm/Kconfig                                   |   1 +
>  arch/arm/kernel/topology.c                         | 221 +------------------
>  arch/arm64/Kconfig                                 |   1 +
>  arch/arm64/kernel/topology.c                       | 226 +------------------
>  drivers/base/Kconfig                               |   8 +
>  drivers/base/Makefile                              |   1 +
>  drivers/base/arch_topology.c                       | 243 +++++++++++++++++++++
>  include/linux/arch_topology.h                      |  17 ++
>  10 files changed, 290 insertions(+), 439 deletions(-)
>  create mode 100644 drivers/base/arch_topology.c
>  create mode 100644 include/linux/arch_topology.h
> 
> -- 
> 2.10.0
> 
