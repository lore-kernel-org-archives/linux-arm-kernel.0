From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 May 2010 22:37:25 +0100
Subject: [PATCH 7/8] ARM: Use the Inner Shareable I-cache and BTB opson
	ARMv7 SMP
In-Reply-To: <20100528185043.GA5189@n2100.arm.linux.org.uk>
References: <20100528185043.GA5189@n2100.arm.linux.org.uk>
Message-ID: <1275082645.26351.5.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-05-28 at 19:50 +0100, Russell King - ARM Linux wrote:
> On Tue, May 04, 2010 at 05:44:54PM +0100, Catalin Marinas wrote:
> > The standard I-cache Invalidate All (ICIALLU) and Branch Predication
> > Invalidate All (BPIALL) operations are not automatically broadcast to
> > the other CPUs in an ARMv7 MP system. The patch adds the Inner Shareable
> > variants, ICIALLUIS and BPIALLIS, if ARMv7 and SMP.
> 
> FYI, I'm considering reverting this patch; this patch is one of two
> responsible for causing a stability regression of Versatile Express
> platform.
> 
> The two commits responsible for making Versatile Express userspace
> completely unstable are:
> 
> b8349b569aae661dea9d59d7d2ee587ccea3336c
> ARM: 6112/1: Use the Inner Shareable I-cache and BTB ops on ARMv7 SMP
> 
> 7e5a69e83ba7a0d5917ad830f417cba8b8d6aa72
> ARM: 6007/1: fix highmem with VIPT cache and DMA
> 
> Most of the instability is from the second patch, but reverting just
> the second patch doesn't fully restore userspace stability.

That's a bit weird as my patch is supposed to make things better. Does
it fail in the same way with maxcpus=1? For SMP configuration, you could
also try some of the recent patches from my "proposed" branch:

http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-2.6-cm.git;a=shortlog;h=refs/heads/proposed

especially:

ARM: Use lazy cache flushing on ARMv7 SMP systems
ARM: Assume new page cache pages have dirty D-cache
ARM: Synchronise the I and D caches via set_pte_at

-- 
Catalin
