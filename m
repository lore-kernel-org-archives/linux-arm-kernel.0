From: dsafonov@virtuozzo.com (Dmitry Safonov)
Date: Thu, 18 May 2017 14:13:29 +0300
Subject: [PATCHv2] ARM32: Support mremap() for sigpage/vDSO
In-Reply-To: <871579ef-ee9a-c321-80e4-47836bb0e472@virtuozzo.com>
References: <20170414132529.8337-1-dsafonov@virtuozzo.com>
 <871579ef-ee9a-c321-80e4-47836bb0e472@virtuozzo.com>
Message-ID: <bebbe3ce-12ed-419a-248a-55f41d74d9da@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2017 08:18 PM, Dmitry Safonov wrote:
> On 04/14/2017 04:25 PM, Dmitry Safonov wrote:
>> CRIU restores application mappings on the same place where they
>> were before Checkpoint. That means, that we need to move vDSO
>> and sigpage during restore on exactly the same place where
>> they were before C/R.
>>
>> Make mremap() code update mm->context.{sigpage,vdso} pointers
>> during VMA move. Sigpage is used for landing after handling
>> a signal - if the pointer is not updated during moving, the
>> application might crash on any signal after mremap().
>>
>> vDSO pointer on ARM32 is used only for setting auxv at this moment,
>> update it during mremap() in case of future usage.
>>
>> Without those updates, current work of CRIU on ARM32 is not reliable.
>> Historically, we error Checkpointing if we find vDSO page on ARM32
>> and suggest user to disable CONFIG_VDSO.
>> But that's not correct - it goes from x86 where signal processing
>> is ended in vDSO blob. For arm32 it's sigpage, which is not disabled
>> with `CONFIG_VDSO=n'.
>>
>> Looks like C/R was working by luck - because userspace on ARM32 at
>> this moment always sets SA_RESTORER.
>>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
>> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
>> Cc: Christopher Covington <cov@codeaurora.org>
>> Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
>> ---
>> v2: (buildbot) Fix (unsinged long) to (void*) cast warning.
>>
>>   arch/arm/kernel/process.c |  8 ++++++++
>>   arch/arm/kernel/vdso.c    | 18 ++++++++++++++++++
>>   arch/x86/entry/vdso/vma.c |  3 ---
>>   mm/mmap.c                 |  4 ++++
>>   4 files changed, 30 insertions(+), 3 deletions(-)
> 
> Ping?

Ping?

> 
>>
>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
>> index 939e8b58c59d..1e6039cac68d 100644
>> --- a/arch/arm/kernel/process.c
>> +++ b/arch/arm/kernel/process.c
>> @@ -404,9 +404,17 @@ static unsigned long sigpage_addr(const struct 
>> mm_struct *mm,
>>   static struct page *signal_page;
>>   extern struct page *get_signal_page(void);
>> +static int sigpage_mremap(const struct vm_special_mapping *sm,
>> +        struct vm_area_struct *new_vma)
>> +{
>> +    current->mm->context.sigpage = new_vma->vm_start;
>> +    return 0;
>> +}
>> +
>>   static const struct vm_special_mapping sigpage_mapping = {
>>       .name = "[sigpage]",
>>       .pages = &signal_page,
>> +    .mremap = sigpage_mremap,
>>   };
>>   int arch_setup_additional_pages(struct linux_binprm *bprm, int 
>> uses_interp)
>> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
>> index 53cf86cf2d1a..a4d6dc0f2427 100644
>> --- a/arch/arm/kernel/vdso.c
>> +++ b/arch/arm/kernel/vdso.c
>> @@ -54,8 +54,26 @@ static const struct vm_special_mapping 
>> vdso_data_mapping = {
>>       .pages = &vdso_data_page,
>>   };
>> +static int vdso_mremap(const struct vm_special_mapping *sm,
>> +        struct vm_area_struct *new_vma)
>> +{
>> +    unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
>> +    unsigned long vdso_size;
>> +
>> +    /* without VVAR page */
>> +    vdso_size = (vdso_total_pages - 1) << PAGE_SHIFT;
>> +
>> +    if (vdso_size != new_size)
>> +        return -EINVAL;
>> +
>> +    current->mm->context.vdso = new_vma->vm_start;
>> +
>> +    return 0;
>> +}
>> +
>>   static struct vm_special_mapping vdso_text_mapping __ro_after_init = {
>>       .name = "[vdso]",
>> +    .mremap = vdso_mremap,
>>   };
>>   struct elfinfo {
>> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
>> index 226ca70dc6bd..363730caa60e 100644
>> --- a/arch/x86/entry/vdso/vma.c
>> +++ b/arch/x86/entry/vdso/vma.c
>> @@ -77,9 +77,6 @@ static int vdso_mremap(const struct 
>> vm_special_mapping *sm,
>>       if (image->size != new_size)
>>           return -EINVAL;
>> -    if (WARN_ON_ONCE(current->mm != new_vma->vm_mm))
>> -        return -EFAULT;
>> -
>>       vdso_fix_landing(image, new_vma);
>>       current->mm->context.vdso = (void __user *)new_vma->vm_start;
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index bfbe8856d134..534aef99cfe9 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -3152,8 +3152,12 @@ static int special_mapping_mremap(struct 
>> vm_area_struct *new_vma)
>>   {
>>       struct vm_special_mapping *sm = new_vma->vm_private_data;
>> +    if (WARN_ON_ONCE(current->mm != new_vma->vm_mm))
>> +        return -EFAULT;
>> +
>>       if (sm->mremap)
>>           return sm->mremap(sm, new_vma);
>> +
>>       return 0;
>>   }
>>
> 
> 


-- 
              Dmitry
