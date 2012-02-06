From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 6 Feb 2012 10:29:57 +0000
Subject: [PATCH 4/7] Store huge page linux pte in mm_struct
In-Reply-To: <4F2F352B.9080408@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-5-git-send-email-bill4carson@gmail.com>
 <20120131100154.GC889@n2100.arm.linux.org.uk>
 <4F28D18D.1040402@gmail.com> <4F2F352B.9080408@gmail.com>
Message-ID: <20120206102957.GB26538@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bill4carson wrote:
> Normal page based pte has hardware version and linux version, these
> two kinds of ptes occupy half of 4K page, and each of two pmd level
> entry pointer to this half 4K page.
>
> For huge page, mappings only exist in pmd level from hardware
> perspective, however mm subsystem also needs to know the linux version
> *pte* of this huge page based mapping, problems is where to store
> these huge page linux pte?
>
> A:
> Store huge page linux pte in mm_struct
>
> B:
> Store huge page linux pte in mm_context_t suggested by Catalin.
> This is almost like option A, while it's nice to modify arm code only
> and take small effort to make it happen.
>
> C:
> Modify pgd_alloc to allocate 2048 pgd_t entries plus two void pointers
> Use these two additional pointers to store huge page linux pte.
> It's feasible, but I don't know whether this is a good idea.

I wouldn't add this to pgd_alloc since not all tasks need huge pages.
First option is also not feasible as we shouldn't touch generic code.
This leaves us with B, unless better options are suggested.

I had a patch couple of years ago
(http://article.gmane.org/gmane.linux.ports.arm.kernel/55045) to use the
AF (Access Flag) bit and free up some bits in the page table, allowing
us to drop the Linux PTE. But we end up in a bigger configuration mess
as we already have to choose between classic MMU and LPAE. The
performance advantage wasn't that big either.

-- 
Catalin
