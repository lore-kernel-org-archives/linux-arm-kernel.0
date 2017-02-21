From: olekstysh@gmail.com (Oleksandr Tyshchenko)
Date: Tue, 21 Feb 2017 15:31:26 +0200
Subject: [RFC PATCH v1] iommu/io-pgtable-arm-v7s: Check for leaf entry
 right after finding it
In-Reply-To: <bc24299c-748a-4b86-fead-a9ed6b5e5b9f@arm.com>
References: <1487253137-13792-1-git-send-email-olekstysh@gmail.com>
 <bc24299c-748a-4b86-fead-a9ed6b5e5b9f@arm.com>
Message-ID: <CAPD2p-nPoiSanU4jYvnaYtAbbERE8c=4mLjTC3NX2bGYkZM5UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Robin.

On Tue, Feb 21, 2017 at 2:00 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 16/02/17 13:52, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> Do a check for already installed leaf entry at the current level before
>> performing any actions when trying to map.
>>
>> This check is already present in arm_v7s_init_pte(), i.e. before
>> installing new leaf entry at the current level if conditions to do so
>> are met (num_entries > 0).
>>
>> But, this might be insufficient in case when we have already
>> installed block mapping at this level and it is not time to
>> install new leaf entry (num_entries == 0).
>> In that case we continue walking the page table down with wrong pointer
>> to the next level.
>>
>> So, move check from arm_v7s_init_pte() to __arm_v7s_map() in order to
>> avoid all cases.
>
> Would it not be more logical (and simpler) to just check that the thing
> we dereference is valid to dereference when we dereference it? i.e.:
>
> -----8<-----
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c
> b/drivers/iommu/io-pgtable-arm-v7s.c
> index 0769276c0537..f3112f9ff494 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -418,8 +418,10 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable
> *data, unsigned long iova,
>                         pte |= ARM_V7S_ATTR_NS_TABLE;
>
>                 __arm_v7s_set_pte(ptep, pte, 1, cfg);
> -       } else {
> +       } else if (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
>                 cptep = iopte_deref(pte, lvl);
> +       } else {
> +               return -EEXIST;
>         }
>
>         /* Rinse, repeat */
> ----->8-----

Agree. Sounds reasonable.

>
> I think the equivalent could be done in LPAE as well.

OK.

I will resend both modified patches without RFC prefix, right?

>
> Robin.
>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> ---
>> This patch does similar things as the patch I have pushed a week ago
>> for long-descriptor format [1].
>> The reason why this patch is RFC is because I am not sure I did the right
>> thing and I even didn't test it.
>>
>> [1] https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020411.html
>> ---
>> ---
>>  drivers/iommu/io-pgtable-arm-v7s.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
>> index f50e51c..7f7594b 100644
>> --- a/drivers/iommu/io-pgtable-arm-v7s.c
>> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
>> @@ -364,10 +364,6 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
>>                       if (WARN_ON(__arm_v7s_unmap(data, iova + i * sz,
>>                                                   sz, lvl, tblp) != sz))
>>                               return -EINVAL;
>> -             } else if (ptep[i]) {
>> -                     /* We require an unmap first */
>> -                     WARN_ON(!selftest_running);
>> -                     return -EEXIST;
>>               }
>>
>>       pte |= ARM_V7S_PTE_TYPE_PAGE;
>> @@ -392,11 +388,20 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
>>  {
>>       struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>       arm_v7s_iopte pte, *cptep;
>> -     int num_entries = size >> ARM_V7S_LVL_SHIFT(lvl);
>> +     int i = 0, num_entries = size >> ARM_V7S_LVL_SHIFT(lvl);
>>
>>       /* Find our entry at the current level */
>>       ptep += ARM_V7S_LVL_IDX(iova, lvl);
>>
>> +     /* Check for already installed leaf entry */
>> +     do {
>> +             if (ptep[i] && !ARM_V7S_PTE_IS_TABLE(ptep[i], lvl)) {
>> +                     /* We require an unmap first */
>> +                     WARN_ON(!selftest_running);
>> +                     return -EEXIST;
>> +             }
>> +     } while (++i < num_entries);
>> +
>>       /* If we can install a leaf entry at this level, then do so */
>>       if (num_entries)
>>               return arm_v7s_init_pte(data, iova, paddr, prot,
>>
>



-- 
Regards,

Oleksandr Tyshchenko
