From: dvyukov@google.com (Dmitry Vyukov)
Date: Tue, 15 Jul 2014 13:45:50 +0400
Subject: [RFC/PATCH RESEND -next 20/21] fs: dcache: manually unpoison
 dname after allocation to shut up kasan's reports
In-Reply-To: <53C4F5A9.6030202@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-21-git-send-email-a.ryabinin@samsung.com>
 <20140715061219.GK11317@js1304-P5Q-DELUXE> <53C4F5A9.6030202@samsung.com>
Message-ID: <CACT4Y+YHEvCb35YN6OO_Vgs17UFfF0D3B45JBMqnG-k6Wf_sXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 1:34 PM, Andrey Ryabinin <a.ryabinin@samsung.com> wrote:
> On 07/15/14 10:12, Joonsoo Kim wrote:
>> On Wed, Jul 09, 2014 at 03:30:14PM +0400, Andrey Ryabinin wrote:
>>> We need to manually unpoison rounded up allocation size for dname
>>> to avoid kasan's reports in __d_lookup_rcu.
>>> __d_lookup_rcu may validly read a little beyound allocated size.
>>
>> If it read a little beyond allocated size, IMHO, it is better to
>> allocate correct size.
>>
>> kmalloc(name->len + 1, GFP_KERNEL); -->
>> kmalloc(roundup(name->len + 1, sizeof(unsigned long ), GFP_KERNEL);
>>
>> Isn't it?
>>
>
> It's not needed here because kmalloc always roundup allocation size.
>
> This out of bound access happens in dentry_string_cmp() if CONFIG_DCACHE_WORD_ACCESS=y.
> dentry_string_cmp() relays on fact that kmalloc always round up allocation size,
> in other words it's by design.
>
> That was discussed some time ago here - https://lkml.org/lkml/2013/10/3/493.
> Since filesystem's maintainer don't want to add needless round up here, I'm not going to do it.
>
> I think this patch needs only more detailed description why we not simply allocate more.
> Also I think it would be better to rename unpoisoin_shadow to something like kasan_mark_allocated().


Note that this poison/unpoison functionality can be used in other
contexts. E.g. when you allocate a bunch of pages, then at some point
poison a part of it to ensure that nobody touches it, then unpoison it
back. Allocated/unallocated looks like a bad fit here, because it has
nothing to do with allocation state. Poison/unpoison is also what we
use in user-space.
