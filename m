From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Feb 2010 10:03:32 -0800
Subject: [PATCH] arm: Allow mounting root on omaps with CPU_V6 and CPU_V7
In-Reply-To: <20100219083556.GB19649@n2100.arm.linux.org.uk>
References: <20100219002748.GB21755@atomide.com>
	<20100219083556.GB19649@n2100.arm.linux.org.uk>
Message-ID: <20100219180331.GC21755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100219 00:33]:
> On Thu, Feb 18, 2010 at 04:27:48PM -0800, Tony Lindgren wrote:
> > @@ -779,5 +779,5 @@ config CACHE_XSC3L2
> >  
> >  config ARM_L1_CACHE_SHIFT
> >  	int
> > -	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
> > +	default 6 if (ARCH_OMAP3 || ARCH_S5PC1XX) && !ARCH_OMAP2
> >  	default 5
> 
> This one is definitely wrong.  Setting the L1 cache line size larger
> than it actually is should be safe; setting it smaller is definitely
> unsafe.

OK dropped that part, updated patch below. Maybe the VFPv3
code can be fixed to boot on earlier hardware too.

So I guess ARM_L1_CACHE_SHIFT should be only used for alignment, and
not for for cache operations?

If so, then what have in arch/arm/plat-omap/iommu.c seems buggy:

static void flush_iopgd_range(u32 *first, u32 *last)
{
	/* FIXME: L2 cache should be taken care of if it exists */
	do {
		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
		    : : "r" (first));
		first += L1_CACHE_BYTES / sizeof(*first);
	} while (first <= last);
}

It seems that this code should use the real cache line size instead to
avoid every other line not to flush if ARM_L1_CACHE_SHIFT is set larger
than it is.

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: v6-v7-mount-root-v2.patch
Type: text/x-diff
Size: 1374 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100219/fb979dbd/attachment.bin>
