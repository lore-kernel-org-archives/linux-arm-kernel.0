From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 17 Oct 2013 12:28:46 +0200
Subject: change_page_attr() implementation for ARM?
In-Reply-To: <20131017101325.GD23462@arm.com>
References: <20131017.080523.1821831578701162178.hdoyu@nvidia.com><20131017101325.GD23462@arm.com>
Message-ID: <20131017.132846.130167893941132236.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> wrote @ Thu, 17 Oct 2013 12:13:26 +0200:

> On Thu, Oct 17, 2013 at 06:05:23AM +0100, Hiroshi Doyu wrote:
> > I found a bit old discussion[1] about CPA support on ARM32(Cortex-A9).
> > 
> > It seesm that CPA API on ARM wasn't possible because maintaining
> > multiple pagetables under SMP is difficult. Instead currently we are
> > using precallocated memory via DMA API.
> > 
> > Is this situation still same for Cortex-A15 and ARM64? If the
> > mismatched aliasing problem doesn't happen, is CPA API feasible?
> 
> On ARMv7+LPAE and AArch64 we use separate TTBR1 for the kernel (linear)
> mapping so in theory you could implement change_page_attr(). The
> mismatched aliases restriction still exists but it is clarified on what
> is and isn't allowed (so you can have Normal non-cacheable and Normal
> cacheable aliases, as long as you take care of removing any dirty cache
> lines that could potentially corrupt your data). The DMA API already
> takes care of this.

Ok

> My (other) problem with change_page_attr() is that its not a standard
> in-kernel API. Powerpc and s390 implement change_page_attr() but with
> different arguments while x86 has change_page_attr_(set|clear).
> 
> So, is the DMA API not enough for what you need?

One of the possible usages may be to have buffers with some specific
page attributes, which could save some of cache maintenances, mainly
for better performance. For example, manipulating pagetables and some
special buffers shared by GPU.
