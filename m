From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 09:01:52 +0000
Subject: [PATCH v2] ARM: vectors: use gate_vma for vectors user mapping
In-Reply-To: <alpine.LFD.2.02.1201171410250.2722@xanadu.home>
References: <1326819020-5004-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1201171410250.2722@xanadu.home>
Message-ID: <20120223090152.GI22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 02:11:14PM -0500, Nicolas Pitre wrote:
> On Tue, 17 Jan 2012, Will Deacon wrote:
> 
> > The current user mapping for the vectors page is inserted as a `horrible
> > hack vma' into each task via arch_setup_additional_pages. This causes
> > problems with the MM subsystem and vm_normal_page, as described here:
> > 
> > https://lkml.org/lkml/2012/1/14/55
> > 
> > Following the suggestion from Hugh in the above thread, this patch uses
> > the gate_vma for the vectors user mapping, therefore consolidating
> > the horrible hack VMAs into one.
> > 
> > Cc: Nicolas Pitre <nico@fluxnic.net>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Tested-by: Nicolas Pitre <nico@linaro.org>

Al Viro has spotted this patch, and commented on it last night:
| static struct vm_area_struct gate_vma;
| static int __init gate_vma_init(void)
| {
|         gate_vma.vm_start       = 0xffff0000;
|         gate_vma.vm_end         = 0xffff0000 + PAGE_SIZE;
|         gate_vma.vm_page_prot   = PAGE_READONLY_EXEC;
|         gate_vma.vm_flags       = VM_READ | VM_EXEC |
|                                   VM_MAYREAD | VM_MAYEXEC |
|                                   VM_ALWAYSDUMP;
|         return 0;
| }
| why bother with initcall?
| it's all constant, AFAICS
| IOW, why not initialize it statically and be done with that?
