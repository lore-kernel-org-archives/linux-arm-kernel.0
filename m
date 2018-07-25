From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Jul 2018 17:53:35 +0100
Subject: [RFC] mm: Do not look up the next level table when large page
 exist.
In-Reply-To: <1532532119-59955-1-git-send-email-zhongjiang@huawei.com>
References: <1532532119-59955-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <20180725165334.4zjsenp6p3cdureq@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 11:21:59PM +0800, zhong jiang wrote:
> show_pte can show the kernel page table and user page table. user
> page table is totally four level table.

Well, you can have huge pages in user space.

> but kernel page table can
> be a large page. Therefore, it need to check the page table.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/arm64/mm/fault.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 1b40676..a397a54 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -169,13 +169,13 @@ void show_pte(unsigned long addr)
>  		pudp = pud_offset(pgdp, addr);
>  		pud = READ_ONCE(*pudp);
>  		pr_cont(", pud=%016llx", pud_val(pud));
> -		if (pud_none(pud) || pud_bad(pud))
> +		if (pud_none(pud) || pud_bad(pud) || pud_sect(pud))

Have you actually hit a problem with this code?

pud_sect() checks that the bottom two bits of the pud are 0b01.
pud_bad() is true when bit 1 is 0, which is the case with a section
mapping.

-- 
Catalin
