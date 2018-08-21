From: liu.song.a23@gmail.com (Song Liu)
Date: Tue, 21 Aug 2018 14:35:29 -0700
Subject: [PATCH v9 2/4] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
In-Reply-To: <CAPhsuW4QbT+0wHYW-A7G8z-Xp=8M+0w1Efmc1006PbqNTfOSxg@mail.gmail.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-3-ravi.bangoria@linux.ibm.com>
 <CAPhsuW4QbT+0wHYW-A7G8z-Xp=8M+0w1Efmc1006PbqNTfOSxg@mail.gmail.com>
Message-ID: <CAPhsuW5DBOuYjYsUyWRZimeRKJhmA=RNM-rpcRhsfXwWfVG6qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 19, 2018 at 10:54 PM, Song Liu <liu.song.a23@gmail.com> wrote:
> On Sun, Aug 19, 2018 at 9:42 PM, Ravi Bangoria
> <ravi.bangoria@linux.ibm.com> wrote:
>> We assume to have only one reference counter for one uprobe.
>> Don't allow user to register multiple uprobes having same
>> inode+offset but different reference counter.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>
> Reviewed-by: Song Liu <songliubraving@fb.com>

Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>

>
>> ---
>>  kernel/events/uprobes.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 35065febcb6c..ecee371a59c7 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -679,6 +679,16 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>>         return u;
>>  }
>>
>> +static void
>> +ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
>> +{
>> +       pr_warn("ref_ctr_offset mismatch. inode: 0x%lx offset: 0x%llx "
>> +               "ref_ctr_offset(old): 0x%llx ref_ctr_offset(new): 0x%llx\n",
>> +               uprobe->inode->i_ino, (unsigned long long) uprobe->offset,
>> +               (unsigned long long) cur_uprobe->ref_ctr_offset,
>> +               (unsigned long long) uprobe->ref_ctr_offset);
>> +}
>> +
>>  static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>>                                    loff_t ref_ctr_offset)
>>  {
>> @@ -698,6 +708,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>>         cur_uprobe = insert_uprobe(uprobe);
>>         /* a uprobe exists for this inode:offset combination */
>>         if (cur_uprobe) {
>> +               if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
>> +                       ref_ctr_mismatch_warn(cur_uprobe, uprobe);
>> +                       put_uprobe(cur_uprobe);
>> +                       kfree(uprobe);
>> +                       return ERR_PTR(-EINVAL);
>> +               }
>>                 kfree(uprobe);
>>                 uprobe = cur_uprobe;
>>         }
>> @@ -1112,6 +1128,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>>         uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>>         if (!uprobe)
>>                 return -ENOMEM;
>> +       if (IS_ERR(uprobe))
>> +               return PTR_ERR(uprobe);
>> +
>>         /*
>>          * We can race with uprobe_unregister()->delete_uprobe().
>>          * Check uprobe_is_active() and retry if it is false.
>> --
>> 2.14.4
>>
