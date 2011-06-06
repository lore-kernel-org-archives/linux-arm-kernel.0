From: zdevai@gmail.com (Zoltan Devai)
Date: Mon, 6 Jun 2011 19:17:54 +0200
Subject: kernel - userspace shared memory
Message-ID: <BANLkTikGHoBTDyPN7T7N88DfMF1F322T2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

We are having a kernel driver and a userspace application that
communicates via shared memory. The problem is, that when the userspace
application modifies some data in the shared memory, this modification
is not "visible" when the kernel driver takes a look at that memory
location (specifically this code is in a kernel timer function).
Actually, the modification is sometimes seen, sometimes not,
which suggests that we are having some kind of cache coherency issue.
The strange thing is, that AFAIK we have disabled caching on the pages
where the shared memory resides.

Below is the code that we use to create the shared memory area.

1. Do you see any problems with it?
2. As it can be seen, we are disabling caching for the user space
   mapping, maybe we need to explicitly disable it for the kernel
   mapping too? If yes, how to access the PTEs that are doing the kernel
   logical mappings and disable caching?
3. Any hints on how to debug the source of such an error?

Any help is appreciated.

Best regards,
Istvan Devai
(actually sent by Zoltan Devai, on his behalf)
----------------------------------------

Kernel initialization code (error handling is omitted for clarity, also
the code that rounds the memory to the nearest page boundary):

kmalloc_ptr = kmalloc((SHAREDMEM_PAGE_NUM) * PAGE_SIZE, GFP_KERNEL);
for (i = 0; i < SHAREDMEM_PAGE_NUM * PAGE_SIZE; i+= PAGE_SIZE) {
            SetPageReserved(virt_to_page(((unsigned long)kmalloc_ptr) + i));
    }

Kernel mmap code:

vma->vm_flags |= VM_RESERVED;
vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

/* map the whole physically contiguous area in one piece */
remap_pfn_range(vma,
                           vma->vm_start,
                           virt_to_phys((void *)kmalloc_ptr) >> PAGE_SHIFT,
                           length,
                           vma->vm_page_prot)) < 0)

Userspace mmap code:

mmap(0, len, PROT_READ|PROT_WRITE, MAP_SHARED| MAP_LOCKED, fd,
MMAP_OFFSET_SHAREDMEM)
