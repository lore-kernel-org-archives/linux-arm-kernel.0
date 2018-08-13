From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Mon, 13 Aug 2018 11:17:56 +0530
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
Message-ID: <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Song,

On 08/11/2018 01:27 PM, Song Liu wrote:
>> +
>> +static void delayed_uprobe_delete(struct delayed_uprobe *du)
>> +{
>> +       if (!du)
>> +               return;
> Do we really need this check?


Not necessary though, but I would still like to keep it for a safety.


> 
>> +       list_del(&du->list);
>> +       kfree(du);
>> +}
>> +
>> +static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
>> +{
>> +       struct list_head *pos, *q;
>> +       struct delayed_uprobe *du;
>> +
>> +       if (!uprobe && !mm)
>> +               return;
> And do we really need this check?


Yes. delayed_uprobe_remove(uprobe=NULL, mm=NULL) is an invalid case. If I remove
this check, code below (or more accurately code suggested by Oleg) will remove
all entries from delayed_uprobe_list. So I will keep this check but put a comment
above function.


[...]
>> +
>> +       ret = get_user_pages_remote(NULL, mm, vaddr, 1,
>> +                       FOLL_WRITE, &page, &vma, NULL);
>> +       if (unlikely(ret <= 0)) {
>> +               /*
>> +                * We are asking for 1 page. If get_user_pages_remote() fails,
>> +                * it may return 0, in that case we have to return error.
>> +                */
>> +               ret = (ret == 0) ? -EBUSY : ret;
>> +               pr_warn("Failed to %s ref_ctr. (%d)\n",
>> +                       d > 0 ? "increment" : "decrement", ret);
> This warning is not really useful. Seems this function has little information
> about which uprobe is failing here. Maybe we only need warning in the caller
> (or caller of caller).


Sure, I can move this warning to caller of this function but what are the
exact fields you would like to print with warning? Something like this is
fine?

    pr_warn("ref_ctr %s failed for 0x%lx, 0x%lx, 0x%lx, 0x%p",
		d > 0 ? "increment" : "decrement", inode->i_ino,
		offset, ref_ctr_offset, mm);

More importantly, the reason I didn't print more info is because dmesg is
accessible to unprivileged users in many distros but uprobes are not. So
printing this information may be a security violation. No?


> 
>> +               return ret;
>> +       }
>> +
>> +       kaddr = kmap_atomic(page);
>> +       ptr = kaddr + (vaddr & ~PAGE_MASK);
>> +
>> +       if (unlikely(*ptr + d < 0)) {
>> +               pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
>> +                       "curr val: %d, delta: %d\n", vaddr, *ptr, d);
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       *ptr += d;
>> +       ret = 0;
>> +out:
>> +       kunmap_atomic(kaddr);
>> +       put_page(page);
>> +       return ret;
>> +}
>> +
>> +static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
>> +                         bool is_register)
> What's the reason of bool is_register here vs. short d in __update_ref_ctr()?
> Can we use short for both?


Yes, I can use short as well.


> 
>> +{
>> +       struct vm_area_struct *rc_vma;
>> +       unsigned long rc_vaddr;
>> +       int ret = 0;
>> +
>> +       rc_vma = find_ref_ctr_vma(uprobe, mm);
>> +
>> +       if (rc_vma) {
>> +               rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
>> +               ret = __update_ref_ctr(mm, rc_vaddr, is_register ? 1 : -1);
>> +
>> +               if (is_register)
>> +                       return ret;
>> +       }
> Mixing __update_ref_ctr() here and delayed_uprobe_add() in the same
> function is a little confusing (at least for me). How about we always use
> delayed uprobe for uprobe_mmap() and use non-delayed in other case(s)?


No. delayed_uprobe_add() is needed for uprobe_register() case to handle race
between uprobe_register() and process creation.


[...]
>>
>> +static int delayed_uprobe_install(struct vm_area_struct *vma)
> This function name is confusing. How about we call it delayed_ref_ctr_incr() or
> something similar? Also, we should add comments to highlight this is vma is not
> the vma containing the uprobe, but the vma containing the ref_ctr.


Sure, I'll do that.


> 
>> +{
>> +       struct list_head *pos, *q;
>> +       struct delayed_uprobe *du;
>> +       unsigned long vaddr;
>> +       int ret = 0, err = 0;
>> +
>> +       mutex_lock(&delayed_uprobe_lock);
>> +       list_for_each_safe(pos, q, &delayed_uprobe_list) {
>> +               du = list_entry(pos, struct delayed_uprobe, list);
>> +
>> +               if (!valid_ref_ctr_vma(du->uprobe, vma))
>> +                       continue;
>> +
>> +               vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
>> +               ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
>> +               /* Record an error and continue. */
>> +               if (ret && !err)
>> +                       err = ret;
> I think this is a good place (when ret != 0) to call pr_warn(). I guess we can
> print which mm get error for which uprobe (inode+offset).


__update_ref_ctr() is already printing warning, so I didn't add anything here.
In case I remove a warning from __update_ref_ctr(), a warning something like
below is fine?

    pr_warn("ref_ctr increment failed for 0x%lx, 0x%lx, 0x%lx, 0x%p",
		inode->i_ino, offset, ref_ctr_offset, vma->vm_mm);

Again, can this lead to a security violation?

Thanks for detailed review :)
-Ravi
