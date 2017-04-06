From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Apr 2017 17:36:25 +0100
Subject: [PATCH v4] arm64: print a fault message when attempting to write
 RO memory
In-Reply-To: <20170405191831.8246-1-stephen.boyd@linaro.org>
References: <20170405191831.8246-1-stephen.boyd@linaro.org>
Message-ID: <20170406163625.GD7705@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 12:18:31PM -0700, Stephen Boyd wrote:
> If a page is marked read only we should print out that fact,
> instead of printing out that there was a page fault. Right now we
> get a cryptic error message that something went wrong with an
> unhandled fault, but we don't evaluate the esr to figure out that
> it was a read/write permission fault.
> 
> Instead of seeing:
> 
>   Unable to handle kernel paging request at virtual address ffff000008e460d8
>   pgd = ffff800003504000
>   [ffff000008e460d8] *pgd=0000000083473003, *pud=0000000083503003, *pmd=0000000000000000
>   Internal error: Oops: 9600004f [#1] PREEMPT SMP
> 
> we'll see:
> 
>   Unable to handle kernel write to read-only memory at virtual address ffff000008e760d8
>   pgd = ffff80003d3de000
>   [ffff000008e760d8] *pgd=0000000083472003, *pud=0000000083435003, *pmd=0000000000000000
>   Internal error: Oops: 9600004f [#1] PREEMPT SMP
> 
> We also add a userspace address check into is_permission_fault()
> so that the function doesn't return true for ttbr0 PAN faults
> when it shouldn't.
> 
> Reviewed-by: James Morse <james.morse@arm.com>
> Tested-by: James Morse <james.morse@arm.com>
> Acked-by: Laura Abbott <labbott@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

Queued for 4.12. Thanks.

-- 
Catalin
