From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 26 Aug 2012 09:40:49 +0100
Subject: For physical memory management, why take holes page as free pages?
In-Reply-To: <CAFNq8R7w7nFSoR1S=r0_Uo3wvKzCALCFgC_TB9Vi_aSuuLwC+g@mail.gmail.com>
References: <CAFNq8R6FL3bVnht2b16zsCm82N+WyrobH3kXzXv3Z-YERfeudw@mail.gmail.com>
 <CAH+eYFCUOVnc81jLkDafN-9qzy+B66DWQ4zvdj7tzjeN=OS0nA@mail.gmail.com>
 <CAFNq8R7w7nFSoR1S=r0_Uo3wvKzCALCFgC_TB9Vi_aSuuLwC+g@mail.gmail.com>
Message-ID: <20120826084049.GK18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 26, 2012 at 12:29:13PM +0800, Li Haifeng wrote:
> I understand, but also confused. More seriously, mem_map array is a
> obsoleted comment in the code, right? It really means node_bootmem_map
> of a memory node, and it 's a bitmap, which a bit indicated a
> page,right?

No.  You're confusing two things - the bootmem bitmap array, and the
mem_map array, which is an array of "struct page"s.  One struct page
exists per page, where each struct page is normally around 32 bytes.
So one 4K page of struct pages is 128 entries in the map, which covers
512kB of memory.

Take the case where you have a hole of 128MB between your memory banks.
That's 256 pages of unused page structures, or a total of 1MB of memory
consumed by unused page structures.
