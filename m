From: heechul@illinois.edu (heechul Yun)
Date: Fri, 1 Jul 2011 14:42:00 -0700
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110701101019.GA1723@e102109-lin.cambridge.arm.com>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
Message-ID: <BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Great.

Removing the PTE flush seems to have a noticeable performance
difference in my test. The followings are lmbench 3.0a performance
result measured on a Cortex A9 SMP platform. So far, I did not have
any problem while doing various test.

=========
mm-patch:
=========
Pagefaults on /tmp/XXX: 3.0759 microseconds
Process fork+exit: 464.5414 microseconds
Process fork+execve: 785.4944 microseconds
Process fork+/bin/sh -c: 488.6204 microseconds

=========
original:
=========
Pagefaults on /tmp/XXX: 3.6209 microseconds
Process fork+exit: 485.5236 microseconds
Process fork+execve: 820.0613 microseconds
Process fork+/bin/sh -c: 2966.3828 microseconds

Heechul

On Fri, Jul 1, 2011 at 3:10 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Jul 01, 2011 at 08:04:42AM +0100, heechul Yun wrote:
>> Based on TRM of Cortex A9, the MMU reads page table entries from L1-D
>> cache not from memory. Then I think we do not need to flush the cache
>> line in the following code because MMU will always see up-to-date view
>> of page table in both UP and SMP systems.
>>
>> linux/arch/arm/mm/proc-v7.S
>>
>> ENTRY(cpu_v7_set_pte_ext)
>> ? ? ? ...
>> ? ? ? ? mcr ? ? p15, 0, r0, c7, c10, 1 ? ? ? ? ?@ flush_pte from
>> D-cache // why we need this in A9?
>> ? ? ? ? ?
>>
>> If this is a necessary one, could you please explain the reason? Thanks.
>
> No, it's not necessary, only that this file is used by other processors
> as well. The solution below checks the ID_MMFR3[23:20] bits (coherent
> walk) and avoid flushing if the value is 1. The same could be done for
> PMD entries, though that's less critical than the PTEs.
>
> Please note that the patch is not fully tested.
>
> 8<--------------------
>
> From 67bd5ebdf622637f8293286146441e6292713c3d Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Fri, 1 Jul 2011 10:57:07 +0100
> Subject: [PATCH] ARMv7: Do not clean the PTE coherent page table walk is supported
>
> This patch adds a check for the ID_MMFR3[23:20] bits (coherent walk) and
> only cleans the D-cache corresponding to a PTE if coherent page table
> walks are not supported.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> ?arch/arm/mm/proc-v7.S | ? ?4 +++-
> ?1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 8013afc..fc5b36f 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -166,7 +166,9 @@ ENTRY(cpu_v7_set_pte_ext)
> ?ARM( ?str ? ? r3, [r0, #2048]! )
> ?THUMB( ? ? ? ?add ? ? r0, r0, #2048 )
> ?THUMB( ? ? ? ?str ? ? r3, [r0] )
> - ? ? ? mcr ? ? p15, 0, r0, c7, c10, 1 ? ? ? ? ?@ flush_pte
> + ? ? ? mrc ? ? p15, 0, r3, c0, c1, 7 ? ? ? ? ? @ read ID_MMFR3
> + ? ? ? tst ? ? r3, #0xf << 20 ? ? ? ? ? ? ? ? ?@ check the coherent walk bits
> + ? ? ? mcreq ? p15, 0, r0, c7, c10, 1 ? ? ? ? ?@ flush_pte
> ?#endif
> ? ? ? ?mov ? ? pc, lr
> ?ENDPROC(cpu_v7_set_pte_ext)
>
> --
> Catalin
>
