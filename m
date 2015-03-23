From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 23 Mar 2015 10:45:37 +0000
Subject: [PATCH v2 0/3] arm64: relax Image placement requirement
In-Reply-To: <1427101646-465-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426870974-4801-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427101646-465-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150323104536.GA9724@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 09:07:23AM +0000, Ard Biesheuvel wrote:
> So as it turns out, the 512 MB alignment boundary restriction appears
> to have been introduced by accident when increasing the ID map to cover
> the entire kernel Image.
> 
> So this reverts that change, by reducing the ID map to something that
> can never cross a 512 MB boundary by construction.
> 
> Patch #1 removes some functions that are unused, so that I don't have
> to worry about them in patch #2
> 
> Patch #2 introduces the reduced ID map, using a separate linker section
> that contains code the manipulates the state of the MMU.
> 
> Patch #3 removes the sleep_idmap_phys global which always points to
> the ID map anyway

Patch 1 and 2 do not apply for me, what tree/commit are they based against ?

Please let me know so that I can give patch 3 a go.

Thanks,
Lorenzo

> 
> 
> Ard Biesheuvel (3):
>   arm64: remove soft_restart() and friends
>   arm64: reduce ID map to a single page
>   arm64: drop sleep_idmap_phys
> 
>  arch/arm64/include/asm/mmu.h         |  1 -
>  arch/arm64/include/asm/proc-fns.h    |  3 ---
>  arch/arm64/include/asm/system_misc.h |  1 -
>  arch/arm64/kernel/head.S             | 13 +++++++------
>  arch/arm64/kernel/process.c          | 12 +-----------
>  arch/arm64/kernel/sleep.S            |  9 ++++-----
>  arch/arm64/kernel/suspend.c          |  3 ---
>  arch/arm64/kernel/vmlinux.lds.S      | 11 ++++++++++-
>  arch/arm64/mm/mmu.c                  | 11 -----------
>  arch/arm64/mm/proc.S                 | 33 ---------------------------------
>  10 files changed, 22 insertions(+), 75 deletions(-)
> 
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
