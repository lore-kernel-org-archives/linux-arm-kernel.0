From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 22 Apr 2013 00:06:30 +0200
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130418135104.GA18616@arm.com>
References: <1349609352-6408-3-git-send-email-gmbnomis@gmail.com>
 <20121008174428.GB3204@arm.com>
 <20121008200216.GA14167@schnuecks.de>
 <20121008202040.GC4625@n2100.arm.linux.org.uk>
 <20121008230733.GA17819@schnuecks.de>
 <20121118211005.GW22106@titan.lakedaemon.net>
 <20130418111608.GF27197@titan.lakedaemon.net>
 <20130418112201.GQ14496@n2100.arm.linux.org.uk>
 <20130418114016.GG27197@titan.lakedaemon.net>
 <20130418135104.GA18616@arm.com>
Message-ID: <20130421220629.GA25571@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Catalin,

On Thu, Apr 18, 2013 at 02:51:04PM +0100, Catalin Marinas wrote:
> On Thu, Apr 18, 2013 at 12:40:16PM +0100, Jason Cooper wrote:
> > Ok, got it.  I should have been more explicit.  LVM doesn't work on ARM.
> > iirc, Simon had a demo of dm-crypt also faulting on ARM.  This patch was
> > not the correct approach.  Is there an interest (particularly Simon) in
> > fixing the problem?
> 
> I think fixing this for ARM is useful but I don't have any time to
> allocate. I think I acked the first patch in the series but I don't
> fully remember the details behind the second one.
> 
> As Russell said, flush_kernel_dcache_page() is not the right API.

It is not the driver itself which is using the API, it is the
generic scatterlist memory iterator. And I don't think that this is
wrong, as I have tried to explain in [1].


> flush_dcache_page() is not supposed to be used on anonymous pages. What
> we have for such pages is flush_anon_page() which is a no-op for VIPT
> non-aliasing pages. I can see that __get_user_pages() calls both
> flush_anon_page() flush_dcache_page().

Yes. But I think that is not relevant here. Although the naming
suggest that the function is just a light-weight version of
flush_dcache_page(), both the documentation and the commit text say
that flush_kernel_dcache_page() has to handle pages that were
obtained through get_user_pages, which includes anon pages.


Btw. many drivers which modify pages via the kernel mapping currently
use flush_dcache_page() instead.  This is not supposed to work in
e.g.  the direct I/O case where a driver sees anon pages.  This works
just because flush_dcache_page() flushes the kernel mapping also for
anon pages.  Something is is clearly not supposed to do according to
documentation.

> Is the problem that you have related to I-D cache coherency? Is
> flush_anon_page() the right place for this?

This particular problem is not related to I/D cache coherency. 
However, as far as I know, flush_dcache_page() is expected to ensure
also I/D cache coherency.  Also, we flush the I-cache in certain
situations in this function.  As said in my response to Russel, I
don't know whether this is expected from flush_kernel_dcache_page()
as well.  I would say yes, but I also have posted a version that only
flushes the D-cache kernel mapping.

- Simon

[1] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/181703
