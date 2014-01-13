From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 Jan 2014 16:28:34 -0500
Subject: [PATCH] ARM: Fix incorrect FDT initrd parameter override
In-Reply-To: <52D455CE.6090306@killerwolves.net>
References: <0a923e$51mtvt@icp-osb-irony-out9.iinet.net.au>
 <20140113152851.GF19878@titan.lakedaemon.net>
 <52D455CE.6090306@killerwolves.net>
Message-ID: <20140113212834.GG19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben,

On Tue, Jan 14, 2014 at 07:08:30AM +1000, Ben Peddell wrote:
> Patch submitted with requested changes.
> 
> On Mon, 13 Jan 2014 at 10:28:51 AM -0500, Jason Cooper wrote:
> >> +	initrd_start = initrd_end = 0;
> > 
> > This line shouldn't be necessary.  Both are reset in the following hunk
> > below your change:
> > 
> 
> if (phys_initrd_size &&
>     !memblock_is_region_memory(phys_initrd_start, phys_initrd_size)) {
> 	pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region - disabling initrd\n",
> 	       (u64)phys_initrd_start, phys_initrd_size);
> 	phys_initrd_start = phys_initrd_size = 0;
> }
> if (phys_initrd_size &&
>     memblock_is_region_reserved(phys_initrd_start, phys_initrd_size)) {
> 	pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region - disabling initrd\n",
> 	       (u64)phys_initrd_start, phys_initrd_size);
> 	phys_initrd_start = phys_initrd_size = 0;
> }
> 
> > if (phys_initrd_size) {
> > 	memblock_reserve(phys_initrd_start, phys_initrd_size);
> > 
> > 	/* Now convert initrd to virtual addresses */
> > 	initrd_start = __phys_to_virt(phys_initrd_start);
> > 	initrd_end = initrd_start + phys_initrd_size;
> > }
> 
> Please note that above this a check is made to ensure that
> phys_initrd_start and phys_initrd_size are valid, and they are zeroed
> if they are not valid.  Therefore if phys_initrd_start or 
> phys_initrd_size are invalid, then initrd_start and initrd_end are not
> reset.
> 
> This means that if the initrd= address is not present or is invalid
> then the FDT address will be used anyway as initrd_start and 
> initrd_end will not have been zeroed, and if that is invalid the
> kernel will OOPS in unpack_to_rootfs():

Ahhh, ok.  Thanks for the clarification.  You kept that line in the
version you submitted to Russell's patch tracker?

thx,

Jason.
