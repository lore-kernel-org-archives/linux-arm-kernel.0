From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Jan 2012 14:14:18 +0000
Subject: [PATCH] ARM: ioremap: fix boundary check when reusing static
 mapping
In-Reply-To: <CAGhQ9VwKoVz36EQJ1c2yTTY7NZjsJ9O-nQk-mTWW5nY4pZdMTA@mail.gmail.com>
References: <1327515419-14097-1-git-send-email-pawel.moll@arm.com>
 <alpine.LFD.2.02.1201251333230.2759@xanadu.home>
 <1327574142.2355.30.camel@hornet.cambridge.arm.com>
 <CAGhQ9Vzx9K3qvkEFv-YVsUAdMF4SC0t2dvuYaqfj2QtibBem7g@mail.gmail.com>
 <20120129001136.GB15455@n2100.arm.linux.org.uk>
 <CAGhQ9VxzFZ32P08RPx8us4fE8xO3prXpM-fdWcsWWjWub4eC=w@mail.gmail.com>
 <20120129131411.GC15455@n2100.arm.linux.org.uk>
 <CAGhQ9VwKoVz36EQJ1c2yTTY7NZjsJ9O-nQk-mTWW5nY4pZdMTA@mail.gmail.com>
Message-ID: <20120129141418.GD15455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2012 at 02:22:17PM +0100, Joachim Eastwood wrote:
> On Sun, Jan 29, 2012 at 2:14 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sun, Jan 29, 2012 at 02:10:34PM +0100, Joachim Eastwood wrote:
> >> On Sun, Jan 29, 2012 at 1:11 AM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Sat, Jan 28, 2012 at 11:55:19PM +0100, Joachim Eastwood wrote:
> >> >> "ARM: 7304/1: ioremap: fix boundary check when reusing static mapping"
> >> >> Commit: 3c424f359898aff48c3d5bed608ac706f8a528c3 in Linus master
> >> >>
> >> >> Breaks booting on my custom AT91RM9200 board.
> >> >> There isn't any error messages or anything that indicates what goes
> >> >> wrong it just stops after; Uncompressing Linux... done, booting the
> >> >> kernel.
> >> >
> >> > Your best way of finding out what's going on is to enable:
> >> >
> >> > DEBUG_KERNEL
> >> > DEBUG_LL
> >> > EARLY_PRINTK
> >> >
> >> > and select the appropriate kernel low-level debugging port. ?That should
> >> > show you what's going on.
> >>
> >> Sadly, it doesn't make a difference. Still no output.
> >
> > Sorry, I missed that you also need 'earlyprintk' or something like that
> > on the command line. ?Alternatively, use the following patch, which IMHO
> > is a lot less error prone:
> 
> <snip patch>
> 
> The patch did the job. Thanks.

Thanks - digging through the AT91 code I can't see how this has happened.
So, one more patch to add please:

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ba15937..d2514fb 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -217,6 +217,8 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 	 * Try to reuse one of the static mapping whenever possible.
 	 */
 	read_lock(&vmlist_lock);
+printk("ioremap: pfn=%lx phys=%lx offset=%lx size=%lx\n",
+	pfn, __pfn_to_phys(pfn), offset, size);
 	for (area = vmlist; area; area = area->next) {
 		if (!size || (sizeof(phys_addr_t) == 4 && pfn >= 0x100000))
 			break;
@@ -224,6 +226,8 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 			continue;
 		if ((area->flags & VM_ARM_MTYPE_MASK) != VM_ARM_MTYPE(mtype))
 			continue;
+printk("ioremap: area %p: phys_addr=%lx pfn=%lx size=%lx\n", area,
+	area->phys_addr, __phys_to_pfn(area->phys_addr), area->size);
 		if (__phys_to_pfn(area->phys_addr) > pfn ||
 		    __pfn_to_phys(pfn) + offset + size-1 >
 		    area->phys_addr + area->size-1)
@@ -232,6 +236,7 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 		read_unlock(&vmlist_lock);
 		addr = (unsigned long)area->addr;
 		addr += __pfn_to_phys(pfn) - area->phys_addr;
+printk("ioremap: found: addr %p => %lx => %lx\n", area->addr, addr, offset + addr);
 		return (void __iomem *) (offset + addr);
 	}
 	read_unlock(&vmlist_lock);
