From: pullip.cho@samsung.com (KyongHo Cho)
Date: Fri, 25 May 2012 21:39:29 +0900
Subject: mm: fix faulty initialization in vmalloc_init()
In-Reply-To: <20120524151231.e3a18ac5.akpm@linux-foundation.org>
References: <001c01cd3987$d1a71a50$74f54ef0$%cho@samsung.com>
 <20120524151231.e3a18ac5.akpm@linux-foundation.org>
Message-ID: <CAHQjnOMt112PkHPD1omBZ6ziPXk7E4crt3_Z5JhyxEMhccTsWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 7:12 AM, Andrew Morton <akpm@linux-foundation.org>
wrote:
> On Thu, 24 May 2012 17:32:56 +0900
> KyongHo <pullip.cho@samsung.com> wrote:
>
>> vmalloc_init() adds 'vmap_area's for early 'vm_struct's.
>> This patch fixes vmalloc_init() to correctly initialize
>> vmap_area for the given vm_struct.
>>
>
> <daily message>
> Insufficient information.  When fixing a bug please always always
> always describe the user-visible effects of the bug.  Does the kernel
> instantly crash?  Is it a comestic cleanliness thing which has no
> effect?  Something in between?  I have simply no idea, and am dependent
> upon you to tell me.

Sorry for unkind commit message :)
Why this patch is needed is described by Olav
in the previous replies.

>
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -1185,9 +1185,10 @@ void __init vmalloc_init(void)
>>       /* Import existing vmlist entries. */
>>       for (tmp = vmlist; tmp; tmp = tmp->next) {
>>               va = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
>> -             va->flags = tmp->flags | VM_VM_AREA;
>> +             va->flags = VM_VM_AREA;
>
> This change is a mystery.  Why do we no longer transfer ->flags?
>
>>               va->va_start = (unsigned long)tmp->addr;
>>               va->va_end = va->va_start + tmp->size;
>> +             va->vm = tmp;
>
> OK, I can see how this might be important.  But why did you find it
> necessary?  Why was this change actually needed?

If it is not set, find_vm_area() with the early vm regions will always fail.

If the early vm regions must be neither found by find_vm_area()
nor removed by remove_vm_area(), va->vm must be NULL.

Please advise me what is right value for va->vm here :)

>
>>               __insert_vmap_area(va);
>>       }
>
> --
> To unsubscribe from this list: send the line "unsubscribe
linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120525/66f329c9/attachment-0001.html>
