From: rabin@rab.in (Rabin Vincent)
Date: Sat, 25 Aug 2012 21:23:33 +0200
Subject: For physical memory management, why take holes page as free pages?
In-Reply-To: <CAFNq8R6FL3bVnht2b16zsCm82N+WyrobH3kXzXv3Z-YERfeudw@mail.gmail.com>
References: <CAFNq8R6FL3bVnht2b16zsCm82N+WyrobH3kXzXv3Z-YERfeudw@mail.gmail.com>
Message-ID: <CAH+eYFCUOVnc81jLkDafN-9qzy+B66DWQ4zvdj7tzjeN=OS0nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/25 Li Haifeng <omycle@gmail.com>:
> Sorry to disturb you. When I study memory management of boot_mem, I
> have question about 505~506 lines below code for initialization of
> physical memory management. The function of these two lines is to make
> the holes between adjacent bank free in node_bootmem_map of
> corresponding node, which is a bitmap.

What's being freed here is the unused parts of the mem_map array, i.e.
those parts which would have held the struct page structures which cover
the pages in the memory holes.

> IMO, the holes between two bank should be marked reserved in page
> bitmap, because it couldn't be used for allocating memory in buddy
> system.

The pages in the memory holes are simply never released to the page
allocator, and are therefore never available for allocation in the buddy
system.  This code frees the holes in the mem_map array itself.
