From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 13:02:33 +0200
Subject: "mm: introduce dump_vma fix 2" still broken
Message-ID: <2815658.dHHBXc7oHP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I saw this commit today in linux-next, which fixes a build error, but introduces
a new warning:

commit a60224c708f880dd937b352b7461cbf14e93012d
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon Sep 8 19:41:54 2014 +1000

    mm: introduce dump_vma fix 2
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb510c08073b..0de60769bcf6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6739,7 +6739,7 @@ void dump_vma(const struct vm_area_struct *vma)
                "prot %lx anon_vma %p vm_ops %p\n"
                "pgoff %lx file %p private_data %p\n",
                vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_next,
-               vma->vm_prev, vma->vm_mm, vma->vm_page_prot.pgprot,
+               vma->vm_prev, vma->vm_mm, pgprot_val(vma->vm_page_prot),
                vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
                vma->vm_file, vma->vm_private_data);
        dump_flags(vma->vm_flags, vmaflags_names, ARRAY_SIZE(vmaflags_names));


/git/arm-soc/mm/page_alloc.c: In function 'dump_vma':
/git/arm-soc/mm/page_alloc.c:6744:3: warning: format '%lx' expects argument of type 'long unsigned int', but argument 8 has type 'pgprot_t' [-Wformat=]
   vma->vm_file, vma->vm_private_data);
   ^

This happens on machines that use ARM LPAE, where pgprot_t is in fact
a 64-bit integer. The simplest fix I see would be add a cast to u64
and always print this as a 64bit value.

	Arnd
