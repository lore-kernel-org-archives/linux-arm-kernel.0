From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Jan 2017 11:56:07 +0000
Subject: [Question] A question about arm64 pte
In-Reply-To: <d284f510-f025-db84-f21e-a5b167d4bcd2@huawei.com>
References: <d284f510-f025-db84-f21e-a5b167d4bcd2@huawei.com>
Message-ID: <20170116115606.GA6832@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 06:08:47PM +0800, Yisheng Xie wrote:
> I have question about arm64 pte.

I assume the context is ARMv8.0 (without hardware DBM support).

> For arm64, PTE_WRITE?== PTE_DBM? is to mark whether the page is writable,
> and PTE_DIRTY is to mark whether the page is dirty.
> However, PTE_RDONLY is only cleared when both PTE_WRITE and PTE_DIRTY are set.

That's what set_pte_at() does.

> Is that means that the page is still writable when PTE_RDONLY is set with PTE_WRITE?

No. On ARMv8.0, PTE_WRITE is a software only bit while PTE_RDONLY
describes the actual hardware permission. If set_pte_at() does not clear
the PTE_RDONLY bit (PTE_DIRTY not set), the page is read-only even
though PTE_WRITE may be set.

> But in ARM Architecture Reference Manual for ARMv8,
> when PTE_RDONLY is set(AP[2:1] = 0b1x), Acess from EL1 is Ready only?

Yes.

> so what is the really means of the PTE_RDONLY?

Read-only. On ARMv8.0, PTE_WRITE is irrelevant from a hardware
perspective.

-- 
Catalin
