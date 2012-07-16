From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 16 Jul 2012 09:32:00 -0400 (EDT)
Subject: [PATCH v2 01/15] ARM: Add fixed PCI i/o mapping
In-Reply-To: <50039A02.6040507@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <1342231451-28861-2-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1207140815220.14068@xanadu.home>
 <50039A02.6040507@gmail.com>
Message-ID: <alpine.LFD.2.02.1207160925550.14068@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 15 Jul 2012, Rob Herring wrote:

> On 07/14/2012 07:22 AM, Nicolas Pitre wrote:
> > On Fri, 13 Jul 2012, Rob Herring wrote:
> 
> >> +	vm->size = size;
> >> +	vm->flags = VM_IOREMAP | VM_ARM_STATIC_MAPPING;
> >> +	vm->caller = vm_reserve_area_early;
> > 
> > This is not providing much useful information when looking at 
> > /proc/vmallocinfo anymore.  What about adding a void *caller argument to 
> > this function and initializing vm->caller with it to identify the true 
> > origin of the region?
> 
> What about just using __builtin_return_address(0)? Since pci_reserve_io
> and devicemaps_init get inlined, ultimately it shows paging_init doing that.

Using __builtin_return_address(0) doesn't prevent gcc from inlining the 
callers in their own callers and then the provided information isn't as 
useful.  They won't get inlined if you pass the address of the caller.  
Furthermore __builtin_return_address(0) provides the call site address 
and not the caller's start address which isn't as pretty.


Nicolas
