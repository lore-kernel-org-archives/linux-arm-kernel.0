From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 28 Jun 2013 10:18:48 +0800
Subject: ARM pagetable setting in Linux
In-Reply-To: <20130626175430.GH2718@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D19441BF5863@CNBJMBX05.corpusers.net>
 <20130626171649.GG10333@mudshark.cambridge.arm.com>
 <20130626175430.GH2718@n2100.arm.linux.org.uk>
Message-ID: <35FD53F367049845BC99AC72306C23D19441BF5867@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear  Both,

Thanks for your reply ,

mmm...   The meaning of the first level pagetables need copy is that :

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/arch/arm/mm/fault.c?h=misc-patches

line:474   (do_translation_fault())
This happened if some kernel drivers call vmalloc / kmap / ioremap function,
It can happen  even after fork() a new process .



https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/arch/arm/mm/pgd.c?h=misc-patches

line:50 (pgd_alloc())
This just happened when fork() a new process .


Anyway, I see your concerns now , 
I will have a discussion about this .

Thank you both !


-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Thursday, June 27, 2013 1:55 AM
To: Will Deacon
Cc: Wang, Yalin; 'linux-arch at vger.kernel.org'; 'linux-kernel at vger.kernel.org'; linux-arm-kernel at lists.infradead.org
Subject: Re: ARM pagetable setting in Linux

As I don't have the original mail (because it wasn't copied to the right
list) I can't reply to the original author, so I'll do it like this instead.

On Wed, Jun 26, 2013 at 06:16:49PM +0100, Will Deacon wrote:
> [adding the ARM list -- please try and remember to do that in future]
> 
> On Wed, Jun 26, 2013 at 03:41:40AM +0100, Wang, Yalin wrote:
> > Hi  Will,
> 
> Hello,
> 
> > I have a question about  arm pagetable setting in Linux .
> > 
> > From armV6,  there is TTBR0 and TTBR1  translation base address registers  in mmu .
> > But I  found linux only use TTBR0 for translation base address , 
> > Could we use TTBR0 and TTBR1 to split user task and kernel 
> > pagetables (swapper_pg_dir)?

We don't use TTBR1 because the configurable page table splits between
TTBR0 and TTBR1 are not appropriate for Linux kernels.  The common configuration is to have 3GB of userspace and 1GB of kernel space.

However, the TTBR splits supported are 2GB, 1GB, 512MB etc.  As I had prior knowledge of ARMv6 before it was released, I raised this point with ARM Ltd because I knew that it would not be appropriate for Linux.
Unfortunately, the response was basically that they didn't want to know.
So, as the hardware provided support mismatches what we want, we don't use the feature.

It's as simple as that; had we been listened to and the architecture altered to do what we required, then we'd be using it...

> > 1. Because we don?t need copy kernel first ?level pagetables into 
> > every User task?s pagetables and flush tlb (for example fork() a new process).
> 
> Well, you still need the TLB maintenance for setting up CoW, so this 
> win is probably not very big.
> 
> > 2. And don?t need handle kernel page fault because that user task?s 
> > kernel Pagetable when it is not set up , need copy again( for 
> > example vmalloc()  ioremap()  kmap()  will change Kernel pagetables and need update to every task pagetables ) .
> 
> Is that really a fastpath?

No it isn't, because for all of the above cases we're talking about copying
L1 page table entries, not the individual L2 page table entries between threads.

Every page table above TASK_SIZE gets shared between processes, and once it's been shared to a process, any new process forked from that gets its own pointer to that 2nd level page table immediately.

So, during the initial boot there will be a number of the L1 copies, but the system will stabilize and there will be no further L1 faulted copies needed.
