From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Jul 2012 17:49:08 +0100
Subject: [PATCH 1/2] ARM: mm: avoid setting nG bit for user mappings
 that aren't present
In-Reply-To: <1343318468-10412-2-git-send-email-will.deacon@arm.com>
References: <1343318468-10412-1-git-send-email-will.deacon@arm.com>
 <1343318468-10412-2-git-send-email-will.deacon@arm.com>
Message-ID: <20120726164908.GC29764@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 05:01:07PM +0100, Will Deacon wrote:
> Swap entries are encoding in ptes such that !pte_present(pte) and
> pte_file(pte). The remaining bits of the descriptor are used to identify
> the swapfile and offset within it to the swap entry.
> 
> When writing such a pte for a user virtual address, set_pte_at
> unconditionally sets the nG bit, which (in the case of LPAE) will
> corrupt the swapfile offset and lead to a BUG:
> 
> [  140.494067] swap_free: Unused swap offset entry 000763b4
> [  140.509989] BUG: Bad page map in process rs:main Q:Reg  pte:0ec76800 pmd:8f92e003
> 
> This patch fixes the problem by only setting the nG bit for user
> mappings that are actually present.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
