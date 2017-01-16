From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Jan 2017 14:36:02 +0000
Subject: [Question] A question about arm64 pte
In-Reply-To: <6b7a9bd2-37af-40cd-b723-9e648fbbc7c8@huawei.com>
References: <d284f510-f025-db84-f21e-a5b167d4bcd2@huawei.com>
 <20170116115606.GA6832@e104818-lin.cambridge.arm.com>
 <6b7a9bd2-37af-40cd-b723-9e648fbbc7c8@huawei.com>
Message-ID: <20170116143601.GB6832@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 08:39:56PM +0800, Yisheng Xie wrote:
> On 2017/1/16 19:56, Catalin Marinas wrote:
> > On Mon, Jan 16, 2017 at 06:08:47PM +0800, Yisheng Xie wrote:
> >> I have question about arm64 pte.
> > 
> > I assume the context is ARMv8.0 (without hardware DBM support).
> 
> Yes.
> > 
> >> For arm64, PTE_WRITE?== PTE_DBM? is to mark whether the page is writable,
> >> and PTE_DIRTY is to mark whether the page is dirty.
> >> However, PTE_RDONLY is only cleared when both PTE_WRITE and PTE_DIRTY are set.
> > 
> > That's what set_pte_at() does.
> > 
> 
> So if we mmap a memory region use /dev/mem like:
>    fildes = open("/dev/mem", O_RDWR | O_CREAT, 0777);
>    addr = mmap(NULL, LEN, PROT_READ | PROT_WRITE, MAP_SHARED, fildes, offset);
> 
> The PTE_RDONLY will be set? Right ?

Possibly, I haven't checked mmap_mem(). However, that's what you would
get with an anonymous mmap() as well.

> However?when use memset to write the region it still works well, and
> the bit PTE_RDONLY is also cleared. Is there anywhere clear the
> PTE_RDONLY before write that page ?

See handle_pte_fault(). On the first access to a writable+clean page
(PTE_WRITE set, PTE_RDONLY set, PTE_DIRTY cleared), the kernel traps it
and, if pte_write() is true (your case), it calls pte_mkdirty(). The
subsequently called ptep_set_access_flags() function would clear
PTE_RDONLY, giving you a writable mapping.

-- 
Catalin
