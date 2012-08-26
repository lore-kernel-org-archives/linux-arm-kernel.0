From: omycle@gmail.com (Li Haifeng)
Date: Sun, 26 Aug 2012 12:29:13 +0800
Subject: For physical memory management, why take holes page as free pages?
In-Reply-To: <CAH+eYFCUOVnc81jLkDafN-9qzy+B66DWQ4zvdj7tzjeN=OS0nA@mail.gmail.com>
References: <CAFNq8R6FL3bVnht2b16zsCm82N+WyrobH3kXzXv3Z-YERfeudw@mail.gmail.com>
 <CAH+eYFCUOVnc81jLkDafN-9qzy+B66DWQ4zvdj7tzjeN=OS0nA@mail.gmail.com>
Message-ID: <CAFNq8R7w7nFSoR1S=r0_Uo3wvKzCALCFgC_TB9Vi_aSuuLwC+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your attention.

2012/8/26 Rabin Vincent <rabin@rab.in>:
> 2012/8/25 Li Haifeng <omycle@gmail.com>:
>> Sorry to disturb you. When I study memory management of boot_mem, I
>> have question about 505~506 lines below code for initialization of
>> physical memory management. The function of these two lines is to make
>> the holes between adjacent bank free in node_bootmem_map of
>> corresponding node, which is a bitmap.
>
> What's being freed here is the unused parts of the mem_map array, i.e.
> those parts which would have held the struct page structures which cover
> the pages in the memory holes.

I understand, but also confused. More seriously, mem_map array is a
obsoleted comment in the code, right? It really means node_bootmem_map
of a memory node, and it 's a bitmap, which a bit indicated a
page,right?

But the code free the holes between banks. For example, a soc have two
banks, one is [0x800000~0x10000000], the other is
[0x10800000~0x20000000].

>From the code, it set bit 0 in node_bootmem_map for range
[0x10000000~0x10800000]. And when initialize the buddy system, the bit
0 in node_bootmem_map will be looked as free page and be available for
allocation in buddy system.

Maybe I misunderstand the code.

>
>> IMO, the holes between two bank should be marked reserved in page
>> bitmap, because it couldn't be used for allocating memory in buddy
>> system.
>
> The pages in the memory holes are simply never released to the page
> allocator, and are therefore never available for allocation in the buddy
> system.  This code frees the holes in the mem_map array itself.

Yes, I also agree this point. But I am still confused with the code.

Thanks for your attention again.
