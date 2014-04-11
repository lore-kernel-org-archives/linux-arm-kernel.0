From: steve.ulrich@broadcom.com (Steve (Steven) Ulrich)
Date: Fri, 11 Apr 2014 02:49:46 +0000
Subject: Increasing PAGE_SIZE to 64K - corresponding changes to ELF
 alignment also required?
Message-ID: <2E04E1E197F7C940977E5203F2F1978220F63031@SJEXCHMB06.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I am in the process of porting a set of kernel patches from a customized 3.2.26 kernel to a 3.6.5 kernel, to change the default page size from 4K to 64K.  I've got the kernel booting through its own initialization, and have reached the point where the kernel is trying to load init.  I'm encountering errors that I suspect are due to text and data segment alignment issues, and would appreciate some feedback/thoughts/comments.

In  fs/binfmt_elf.c, the following logic is present:

static unsigned long elf_map(struct file *filep, unsigned long addr,
                struct elf_phdr *eppnt, int prot, int type,
                unsigned long total_size)
{
        unsigned long map_addr;
        unsigned long size = eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr);  /*  ELF_PAGEOFFSET() gets the 0xffff bits of the p_vaddr from the ELF header */
        unsigned long off = eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr);

        addr = ELF_PAGESTART(addr);
        size = ELF_PAGEALIGN(size);

These values are subsequently used in a call to vm_mmap(), which is failing due to issues with the computed offset.  From my read of this code, it appears that the code is assuming that the various segments of the ELF file are alignable to the kernel's page size.  My (relatively unmodified) toolchain is using the typical "0x8000" alignment for the start of the text segment, and I suspect that this is the underlying problem.  This value is a multiple of the standard 4K page size, but won't work for my new 64K pages. 

I am experimenting with using "-Ttext-segment 0x10000 -z max-page-size=0x10000" to coerce the my ELF file segments to 64K boundaries, but feel like this might be a less-than-ideal solution.  

For those more familiar with ARM ELF and page alignment issues, does it seem that I'll need to align my ELF segments to 64K boundaries in order to get successful vm_mmap() operations?  Or, are there other strategies that can give me correct ELF loading, but without changing the default alignments of the toolchain?

Thanks in advance,
Steve Ulrich
