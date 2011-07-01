From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Jul 2011 11:10:19 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
Message-ID: <20110701101019.GA1723@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2011 at 08:04:42AM +0100, heechul Yun wrote:
> Based on TRM of Cortex A9, the MMU reads page table entries from L1-D
> cache not from memory. Then I think we do not need to flush the cache
> line in the following code because MMU will always see up-to-date view
> of page table in both UP and SMP systems.
> 
> linux/arch/arm/mm/proc-v7.S
> 
> ENTRY(cpu_v7_set_pte_ext)
> 	...
>         mcr     p15, 0, r0, c7, c10, 1          @ flush_pte from
> D-cache // why we need this in A9?
>         ?
> 
> If this is a necessary one, could you please explain the reason? Thanks.

No, it's not necessary, only that this file is used by other processors
as well. The solution below checks the ID_MMFR3[23:20] bits (coherent
walk) and avoid flushing if the value is 1. The same could be done for
PMD entries, though that's less critical than the PTEs.

Please note that the patch is not fully tested.

8<--------------------
