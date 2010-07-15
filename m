From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 09:55:35 +0100
Subject: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
	memory management
In-Reply-To: <20100715012958.GB2239@codeaurora.org>
References: <4C3C0032.5020702@codeaurora.org>
	<20100713150311B.fujita.tomonori@lab.ntt.co.jp>
	<20100713121420.GB4263@codeaurora.org>
	<20100714104353B.fujita.tomonori@lab.ntt.co.jp>
	<20100714201149.GA14008@codeaurora.org>
	<20100714220536.GE18138@n2100.arm.linux.org.uk>
	<20100715012958.GB2239@codeaurora.org>
Message-ID: <20100715085535.GC26212@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 06:29:58PM -0700, Zach Pfeffer wrote:
> The VCM ensures that all mappings that map a given physical buffer:
> IOMMU mappings, CPU mappings and one-to-one device mappings all map
> that buffer using the same (or compatible) attributes. At this point
> the only attribute that users can pass is CACHED. In the absence of
> CACHED all accesses go straight through to the physical memory.

So what you're saying is that if I have a buffer in kernel space
which I already have its virtual address, I can pass this to VCM and
tell it !CACHED, and it'll setup another mapping which is not cached
for me?

You are aware that multiple V:P mappings for the same physical page
with different attributes are being outlawed with ARMv6 and ARMv7
due to speculative prefetching.  The cache can be searched even for
a mapping specified as 'normal, uncached' and you can get cache hits
because the data has been speculatively loaded through a separate
cached mapping of the same physical page.

FYI, during the next merge window, I will be pushing a patch which makes
ioremap() of system RAM fail, which should be the last core code creator
of mappings with different memory types.  This behaviour has been outlawed
(as unpredictable) in the architecture specification and does cause
problems on some CPUs.

We've also the issue of multiple mappings with differing cache attributes
which needs addressing too...
