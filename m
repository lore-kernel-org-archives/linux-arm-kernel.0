From: labbott@redhat.com (Laura Abbott)
Date: Tue, 28 Feb 2017 14:55:51 -0800
Subject: [PATCH] arm64: dump: hide kernel pointers
In-Reply-To: <20170228100420.GA3691@leverpostej>
References: <1488265536-20441-1-git-send-email-miles.chen@mediatek.com>
 <CAKv+Gu_AG0n5jPDCuUD6tvr2sAz9a4sycDy9CtL4iT+OHiN_iQ@mail.gmail.com>
 <20170228100420.GA3691@leverpostej>
Message-ID: <ae6f608f-6c84-b999-d238-a74f6f42d2e5@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2017 02:04 AM, Mark Rutland wrote:
> On Tue, Feb 28, 2017 at 08:42:51AM +0000, Ard Biesheuvel wrote:
>> (+ Mark)
> 
> (+ Laura)
> 
>> On 28 February 2017 at 07:05, Miles Chen <miles.chen@mediatek.com> wrote:
>>> Mask kernel pointers of /sys/kernel/debug/kernel_page_tables entry like
>>> /proc/vmallocinfo does.
>>>
>>> With sysctl kernel.kptr_restrict=0 or 1:
>>> cat /sys/kernel/debug/kernel_page_tables
>>
>> I wonder if this file should be accessible at all if kptr_restrict > 0
> 
> I don't have strong feelings either way.
> 
> This isn't typically enabled, and it's under debugfs, so this shouldn't
> be accessible by a typical user anyhow.
> 
> That said, there are very few of us who need to take a look at this
> file. I'm happy to deal with attacking kptr_restrict when required.
> 

In the interest of security it's probably for the best to switch to the
restricted pointer. Who knows what might get enabled or forgotten about.
I don't like the idea of tying enablement of the file to kptr_restrict
though.

This should probably be fixed up on all arches that implement the
page table dump feature.

Laura

> Thanks,
> Mark.
> 
>>> ---[ Modules start ]---
>>> ---[ Modules end ]---
>>> ---[ vmalloc() Area ]---
>>> ffffff8008000000-ffffff8008010000          64K PTE       RW NX SHD AF...
>>> ffffff8008015000-ffffff8008016000           4K PTE       RW NX SHD AF...
>>> ffffff8008020000-ffffff8008030000          64K PTE       RW NX SHD AF...
>>> ffffff8008031000-ffffff8008071000         256K PTE       RW NX SHD AF...
>>> ffffff8008080000-ffffff8008200000        1536K PTE       ro x  SHD AF...
>>> ffffff8008200000-ffffff8008400000           2M PMD       ro x  SHD AF...
>>> ffffff8008400000-ffffff8008540000        1280K PTE       ro x  SHD AF...
>>> ffffff8008540000-ffffff8008690000        1344K PTE       ro NX SHD AF...
>>> ffffff8008940000-ffffff8008a10000         832K PTE       RW NX SHD AF...
>>> ffffff8008aca000-ffffff8008acd000          12K PTE       RW NX SHD AF...
>>> ffffffbebffd8000-ffffffbebffdb000          12K PTE       RW NX SHD AF...
>>> ---[ vmalloc() End ]---
>>> ---[ Fixmap start ]---
>>> ffffffbefe800000-ffffffbefea00000           2M PMD       ro NX SHD AF...
>>> ---[ Fixmap end ]---
>>> ---[ PCI I/O start ]---
>>> ---[ PCI I/O end ]---
>>> ---[ Linear Mapping ]---
>>> ffffffc000000000-ffffffc000080000         512K PTE       RW NX SHD AF...
>>> ffffffc000080000-ffffffc000200000        1536K PTE       ro NX SHD AF...
>>> ffffffc000200000-ffffffc000600000           4M PMD       ro NX SHD AF...
>>> ffffffc000600000-ffffffc000690000         576K PTE       ro NX SHD AF...
>>> ffffffc000690000-ffffffc000800000        1472K PTE       RW NX SHD AF...
>>> ffffffc000800000-ffffffc002000000          24M PMD       RW NX SHD AF...
>>> ffffffc002000000-ffffffc040000000         992M PMD       RW NX SHD AF...
>>> ffffffc040000000-ffffffc080000000           1G PGD       RW NX SHD AF...
>>>
>>> With sysctl kernel.kptr_restrict=2:
>>> cat /sys/kernel/debug/kernel_page_tables
>>> ---[ Modules start ]---
>>> ---[ Modules end ]---
>>> ---[ vmalloc() Area ]---
>>> 0000000000000000-0000000000000000          64K PTE       RW NX SHD AF...
>>> 0000000000000000-0000000000000000           4K PTE       RW NX SHD AF...
>>> 0000000000000000-0000000000000000          64K PTE       RW NX SHD AF...
>>> 0000000000000000-0000000000000000         256K PTE       RW NX SHD AF...
>>> 0000000000000000-0000000000000000        1536K PTE       ro x  SHD AF...
>>> 0000000000000000-0000000000000000           2M PMD       ro x  SHD AF...
>>> 0000000000000000-0000000000000000        1280K PTE       ro x  SHD AF...
>>> 0000000000000000-0000000000000000        1344K PTE       ro NX SHD AF...
>>> 0000000000000000-0000000000000000         832K PTE       RW NX SHD AF...
>>> 0000000000000000-0000000000000000          12K PTE       RW NX SHD AF...
>>> 0000000000000000-0000000000000000          12K PTE       RW NX SHD AF...
>>> ---[ vmalloc() End ]---
>>> ---[ Fixmap start ]---
>>> 0000000000000000-0000000000000000           2M PMD       ro NX SHD AF...
>>> ---[ Fixmap end ]---
>>> ---[ PCI I/O start ]---
>>> ---[ PCI I/O end ]---
>>> ---[ Linear Mapping ]---
>>> 0000000000000000-0000000000000000         512K PTE       RW NX SHD AF...
>>> 0000000000000000-0000000000000000        1536K PTE       ro NX SHD AF...
>>> 0000000000000000-0000000000000000           4M PMD       ro NX SHD AF...
>>> 0000000000000000-0000000000000000         576K PTE       ro NX SHD AF...
>>> 0000000000000000-0000000000000000        1472K PTE       RW NX SHD AF...
>>> 0000000000000000-0000000000000000          24M PMD       RW NX SHD AF...
>>> 0000000000000000-0000000000000000         992M PMD       RW NX SHD AF...
>>> 0000000000000000-0000000000000000           1G PGD       RW NX SHD AF...
>>>
>>> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
>>> ---
>>>  arch/arm64/mm/dump.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
>>> index ca74a2a..e055ecf 100644
>>> --- a/arch/arm64/mm/dump.c
>>> +++ b/arch/arm64/mm/dump.c
>>> @@ -253,8 +253,8 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
>>>                 if (st->current_prot) {
>>>                         note_prot_uxn(st, addr);
>>>                         note_prot_wx(st, addr);
>>> -                       pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
>>> -                                  st->start_address, addr);
>>> +                       pt_dump_seq_printf(st->seq, "%pK-%pK   ",
>>> +                                  (void *)st->start_address, (void *)addr);
>>>
>>>                         delta = (addr - st->start_address) >> 10;
>>>                         while (!(delta & 1023) && unit[1]) {
>>> --
>>> 1.9.1
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
