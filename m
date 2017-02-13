From: olekstysh@gmail.com (Oleksandr Tyshchenko)
Date: Mon, 13 Feb 2017 13:07:02 +0200
Subject: [RFC PATCH v1] iommu/io-pgtable-arm: Check for leaf entry right
 after finding it
In-Reply-To: <1486648600-27457-1-git-send-email-olekstysh@gmail.com>
References: <1486648600-27457-1-git-send-email-olekstysh@gmail.com>
Message-ID: <CAPD2p-=TtT9ZHpLu8w9jUdKR5u6JG_BGtz0BDDKejmWS-jQ9WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all.

Any comments?

On Thu, Feb 9, 2017 at 3:56 PM, Oleksandr Tyshchenko
<olekstysh@gmail.com> wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>
> Do a check for already installed leaf entry at the current level before
> performing any actions when trying to map.
>
> This check is already present in arm_lpae_init_pte(), i.e. before
> installing new leaf entry at the current level if conditions to do so
> are met (size == block_size).
>
> But, this might be insufficient in case when we have already
> installed block mapping at this level and it is not time to
> install new leaf entry (size != block_size).
> In that case we continue walking the page table down with wrong pointer
> to the next level.
>
> So, move check from arm_lpae_init_pte() to __arm_lpae_map() in order to
> avoid all cases.
>
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> I hope that following actions can help to catch it:
> 1. Call iommu_map for a block mapping (e.g. 2M) at some address
>    (e.g. iova 0x80000000 pa 0x80000000).
> 2. Call iommu_map for a page mapping (4k) at some address from
>    the previous mapped region (e.g. iova 0x80008000 pa 0x90000000).
>
> I understand that after iommu_map should be iommu_unmap, but
> different scenarios may occur).
> ---
> ---
>  drivers/iommu/io-pgtable-arm.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f5c90e1..ebdb82f 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -272,11 +272,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>         arm_lpae_iopte pte = prot;
>         struct io_pgtable_cfg *cfg = &data->iop.cfg;
>
> -       if (iopte_leaf(*ptep, lvl)) {
> -               /* We require an unmap first */
> -               WARN_ON(!selftest_running);
> -               return -EEXIST;
> -       } else if (iopte_type(*ptep, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
> +       if (iopte_type(*ptep, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
>                 /*
>                  * We need to unmap and free the old table before
>                  * overwriting it with a block entry.
> @@ -315,6 +311,13 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>         /* Find our entry at the current level */
>         ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
>
> +       /* Check for already installed leaf entry */
> +       if (iopte_leaf(*ptep, lvl)) {
> +               /* We require an unmap first */
> +               WARN_ON(!selftest_running);
> +               return -EEXIST;
> +       }
> +
>         /* If we can install a leaf entry at this level, then do so */
>         if (size == block_size && (size & cfg->pgsize_bitmap))
>                 return arm_lpae_init_pte(data, iova, paddr, prot, lvl, ptep);
> --
> 2.7.4
>



-- 
Regards,

Oleksandr Tyshchenko
