From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Jan 2010 09:31:29 +0000
Subject: Split page tables
In-Reply-To: <4B4B830D.20309@l4dev.org>
References: <4B4B830D.20309@l4dev.org>
Message-ID: <1263288689.29654.8.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bahadir,

(good to see you around :-))

On Mon, 2010-01-11 at 19:59 +0000, Bahadir Balban wrote:
> If split page tables were used in v6/v7, there might have been
> significant page table area savings e.g. 8KB * 256 = 2MB on a 256
> address space system with a 2GB task address space. This also seems to
> bring the relief of not having to map global mappings to every page
> table at run-time. Why wasn't this route chosen? Perhaps because it
> needs the TASK_SIZE to become smaller? Whatif it was made 0x8000 0000?

You can configure a 2:2 split and if you want you can set TTBR1 to the
kernel TTBR but I don't think you'd gain much. You only save about 2K of
the user TTBR but since we allocate a 1 x 4K page pgd, there isn't any
difference. Note the translation table entries for the kernel would
contain either level 1 section entries or entries pointing to level 2
tables which would be shared between all the pgd tables. I think the
only gain is probably a memcpy of the kernel pgd into the user pgd
during process creation.

-- 
Catalin
