From: olekstysh@gmail.com (Oleksandr Tyshchenko)
Date: Thu, 16 Feb 2017 15:58:43 +0200
Subject: [RFC PATCH v1] iommu/io-pgtable-arm-v7s: Check for leaf entry
 right after finding it
In-Reply-To: <1487253137-13792-1-git-send-email-olekstysh@gmail.com>
References: <1487253137-13792-1-git-send-email-olekstysh@gmail.com>
Message-ID: <CAPD2p-mCOYOB7f6fvjvppHhOcaZ9pL-VR6Lpi2Kz3qj0hAQLMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Robin.

It would be greatly appreciated if you could test this patch if nobody
has objections to the patch itself.

On Thu, Feb 16, 2017 at 3:52 PM, Oleksandr Tyshchenko
<olekstysh@gmail.com> wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>
> Do a check for already installed leaf entry at the current level before
> performing any actions when trying to map.
>
> This check is already present in arm_v7s_init_pte(), i.e. before
> installing new leaf entry at the current level if conditions to do so
> are met (num_entries > 0).
>
> But, this might be insufficient in case when we have already
> installed block mapping at this level and it is not time to
> install new leaf entry (num_entries == 0).
> In that case we continue walking the page table down with wrong pointer
> to the next level.
>
> So, move check from arm_v7s_init_pte() to __arm_v7s_map() in order to
> avoid all cases.
>
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> This patch does similar things as the patch I have pushed a week ago
> for long-descriptor format [1].
> The reason why this patch is RFC is because I am not sure I did the right
> thing and I even didn't test it.
>
> [1] https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020411.html
> ---
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index f50e51c..7f7594b 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -364,10 +364,6 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
>                         if (WARN_ON(__arm_v7s_unmap(data, iova + i * sz,
>                                                     sz, lvl, tblp) != sz))
>                                 return -EINVAL;
> -               } else if (ptep[i]) {
> -                       /* We require an unmap first */
> -                       WARN_ON(!selftest_running);
> -                       return -EEXIST;
>                 }
>
>         pte |= ARM_V7S_PTE_TYPE_PAGE;
> @@ -392,11 +388,20 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
>  {
>         struct io_pgtable_cfg *cfg = &data->iop.cfg;
>         arm_v7s_iopte pte, *cptep;
> -       int num_entries = size >> ARM_V7S_LVL_SHIFT(lvl);
> +       int i = 0, num_entries = size >> ARM_V7S_LVL_SHIFT(lvl);
>
>         /* Find our entry at the current level */
>         ptep += ARM_V7S_LVL_IDX(iova, lvl);
>
> +       /* Check for already installed leaf entry */
> +       do {
> +               if (ptep[i] && !ARM_V7S_PTE_IS_TABLE(ptep[i], lvl)) {
> +                       /* We require an unmap first */
> +                       WARN_ON(!selftest_running);
> +                       return -EEXIST;
> +               }
> +       } while (++i < num_entries);
> +
>         /* If we can install a leaf entry at this level, then do so */
>         if (num_entries)
>                 return arm_v7s_init_pte(data, iova, paddr, prot,
> --
> 2.7.4
>



-- 
Regards,

Oleksandr Tyshchenko
