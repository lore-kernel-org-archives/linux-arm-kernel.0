From: pullip.cho@samsung.com (KyongHo Cho)
Date: Fri, 25 May 2012 20:12:40 +0900
Subject: mm: fix faulty initialization in vmalloc_init()
In-Reply-To: <002c01cd3a0c$aef39530$0cdabf90$@codeaurora.org>
References: <001c01cd3987$d1a71a50$74f54ef0$%cho@samsung.com>
 <20120524151231.e3a18ac5.akpm@linux-foundation.org>
 <002c01cd3a0c$aef39530$0cdabf90$@codeaurora.org>
Message-ID: <CAHQjnOP_n1ahLRYUmp+BE4+8tQ3KqvJK7Lyj41Qbz59qqzqYfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 9:24 AM, Olav Haugan <ohaugan@codeaurora.org> wrote:
>> -----Original Message-----
>> On Thu, 24 May 2012 17:32:56 +0900
>> KyongHo <pullip.cho@samsung.com> wrote:
>>
>> > --- a/mm/vmalloc.c
>> > +++ b/mm/vmalloc.c
>> > @@ -1185,9 +1185,10 @@ void __init vmalloc_init(void)
>> >     /* Import existing vmlist entries. */
>> >     for (tmp = vmlist; tmp; tmp = tmp->next) {
>> >             va = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
>  > -            va->flags = tmp->flags | VM_VM_AREA;
>> > +           va->flags = VM_VM_AREA;
>>
>> This change is a mystery.  Why do we no longer transfer ->flags?
>
> I was actually debugging the same exact issue today. This transfer of
flags
> actually causes some of the static mapping virtual addresses to be
> prematurely freed (before the mapping is removed) because VM_LAZY_FREE
gets
> "set" if tmp->flags has VM_IOREMAP set. This might cause subsequent
> vmalloc/ioremap calls to fail because it might allocate one of the freed
> virtual address ranges that aren't unmapped.
>
Thanks for description.

va->flags has different types of flags from tmp->flags.
If a region with VM_IOREMAP set is registered with vm_area_add_early(),
it will be removed by __purge_vmap_area_lazy().

 Cho KyongHo.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120525/ce9087e9/attachment-0001.html>
