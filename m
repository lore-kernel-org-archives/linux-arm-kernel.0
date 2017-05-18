From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 18 May 2017 11:27:56 +0100
Subject: [PATCH v2 0/3] arm64: Add support for handling memory corruption
In-Reply-To: <1495081650.3981.15@smtp.canonical.com> (Manoj Iyer's message of
 "Wed, 17 May 2017 23:27:30 -0500")
References: <20170517152336.6052-1-punit.agrawal@arm.com>
 <1495081650.3981.15@smtp.canonical.com>
Message-ID: <87y3tujw7n.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manoj,

Manoj Iyer <manoj.iyer@canonical.com> writes:

> On Wed, May 17, 2017 at 10:23 AM, Punit Agrawal
> <punit.agrawal@arm.com> wrote:
>
>     Hi, This series enables memory failure handling for arm64.
>     Previous posting can be found at [0]. Changes since v1: * Reworked
>     Patch 1 based on Catalin's feedbak to symmetrically deal with PUD
>     and PMD hugepages in huge_pte_offset() * Added Steve's acks With
>     support for contiguous hugepages being turned off[1], some of the
>     problems arising from swap entries go away[2]. This simplifies the
>     changes needed to enable memory corruption handling for arm64
>     (done in this seris). In this series, we updates huge_pte_offset()
>     to correctly deal with swap entries (Patch 1). This function will
>     need to be updated when contiguous hugepages are re-enabled. Patch
>     2 adds support to send SIGBUS to processes that have their memory
>     corrupted. With the prerequisites in place, enable memory
>     corruption handling for arm64 (patch 3).
>
>     Thanks, Punit [0]
>     https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1376052.html
>    [1] https://lkml.org/lkml/2017/4/7/486 [2]
>     https://lkml.org/lkml/2017/4/5/402 Jonathan (Zhixiong) Zhang (2):
>     arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling arm64:
>     kconfig: allow support for memory failure handling Punit Agrawal
>     (1): arm64: hugetlb: Fix huge_pte_offset to return poisoned page
>     table entries arch/arm64/Kconfig | 1 +
>     arch/arm64/include/asm/pgtable.h | 2 +- arch/arm64/mm/fault.c | 22
>     +++++++++++++++++++--- arch/arm64/mm/hugetlbpage.c | 29
>     ++++++++++------------------- 4 files changed, 31 insertions(+),
>     23 deletions(-) 
>     -- 
>     2.11.0 
>
> I applied Jonathans 2 patches to Ubuntu Zesty kernel (4.10) and ran
> the mce-test ./run_hugepage.sh after fixing a few things in the test
> case. This generated the bad pmd messages.
>
> linux-4.10.0/mm/pgtable-generic.c:33: bad pmd 0000000172420074.
>
> Then I applied Punit's patch to the kernel and re-ran the mce-test and
> did not see the bad pmd messages. The tests were done on a Qualcomm
> Centriq 2400 platform. 
>
> Tested-by: Manoj Iyer <manoj.iyer@canonical.com>

Thanks for taking the patches for a spin.
