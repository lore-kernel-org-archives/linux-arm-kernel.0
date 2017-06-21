From: ifqqfi@gmail.com (ifq)
Date: Wed, 21 Jun 2017 22:27:36 +0800
Subject: how to make kernel page table into 4kb maping
Message-ID: <CAGnkeyMszGDUOEwvuJiUd+9gXdJBLtvm7JiuD3km3V2L=y2rMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, everyone

I want to find a way to let kernel page table do 4kb mapping, instead
of 1MB section mapping.
Is there any patch for this?

In alloc_init_pmd
if (type->prot_sect &&
((addr | next | phys) & ~SECTION_MASK) == 0) {
__map_init_section(pmd, addr, next, phys, type, ng);
} else {
alloc_init_pte(pmd, addr, next,
       __phys_to_pfn(phys), type, alloc, ng);
}

It use prot_sect to decide go section or pte. I try to force it go
alloc_init_pte, the result is immediate crash when kernel booting.

I also tried to init most of kernel memory with 1MB section page
table, only 4MB with 4k page. But it depends on where the 4MB I
choose.
for example, 0x8f000000 ~ 0x8f400000 is ok, but 0x8f400000 ~
0x8f800000 will fail.

I think kernel choose 1MB section for less TLB missing, but I need to
make it small to help me locate other issue.
btw, the platform is arm cortex-a7.  kernel version: 3.14.43.

-- 
Regards.

JT.
