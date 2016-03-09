From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Mar 2016 10:06:05 +0000
Subject: [PATCH] arm64: Fix the ptep_set_wrprotect() to set PTE_DIRTY if
 (PTE_DBM && !PTE_RDONLY)
In-Reply-To: <1457499768-31176-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1457499768-31176-1-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <20160309100605.GJ6192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 10:32:48AM +0530, Ganapatrao Kulkarni wrote:
> Commit 2f4b829c625e ("arm64: Add support for hardware updates of the
> access and dirty pte bits") introduced support for handling hardware
> updates of the access flag and dirty status.
> 
> ptep_set_wrprotect is setting PTR_DIRTY if !PTE_RDONLY,
> however by design it suppose to set PTE_DIRTY
> only if (PTE_DBM && !PTE_RDONLY). This patch addes code to
> test and set accordingly.

The reasoning behind the original code is that if !PTE_RDONLY, you have
no way to tell whether the page was written or not since it is already
writable, independent of the DBM. So by clearing the DBM bit (making the
page read-only), we need to ensure that a potential dirty state is
transferred to the software PTE_DIRTY bit.

By checking PTE_DBM && !PTE_RDONLY, you kind of imply that you can have
a page with !PTE_DBM && !PTE_RDONLY. Given that PTE_DBM is actually
PTE_WRITE, PTE_RDONLY must always be set when !PTE_DBM. The bug may be
elsewhere not setting these bits correctly.

> This patch fixes BUG,
> kernel BUG at /build/linux-StrpB2/linux-4.4.0/fs/ext4/inode.c:2394!
> Internal error: Oops - BUG: 0 [#1] SMP

Which bug is this? It's a PageWriteback() check in the for-next/core
branch. What kernel version are you using?

BTW, in 4.5-rc2 we pushed commit ac15bd63bbb2 ("arm64: Honour !PTE_WRITE
in set_pte_at() for kernel mappings"), though not sure that's what you
are hitting.

-- 
Catalin
