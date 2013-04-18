From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Apr 2013 14:51:04 +0100
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130418114016.GG27197@titan.lakedaemon.net>
References: <1349609352-6408-1-git-send-email-gmbnomis@gmail.com>
 <1349609352-6408-3-git-send-email-gmbnomis@gmail.com>
 <20121008174428.GB3204@arm.com>
 <20121008200216.GA14167@schnuecks.de>
 <20121008202040.GC4625@n2100.arm.linux.org.uk>
 <20121008230733.GA17819@schnuecks.de>
 <20121118211005.GW22106@titan.lakedaemon.net>
 <20130418111608.GF27197@titan.lakedaemon.net>
 <20130418112201.GQ14496@n2100.arm.linux.org.uk>
 <20130418114016.GG27197@titan.lakedaemon.net>
Message-ID: <20130418135104.GA18616@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:40:16PM +0100, Jason Cooper wrote:
> Ok, got it.  I should have been more explicit.  LVM doesn't work on ARM.
> iirc, Simon had a demo of dm-crypt also faulting on ARM.  This patch was
> not the correct approach.  Is there an interest (particularly Simon) in
> fixing the problem?

I think fixing this for ARM is useful but I don't have any time to
allocate. I think I acked the first patch in the series but I don't
fully remember the details behind the second one.

As Russell said, flush_kernel_dcache_page() is not the right API.
flush_dcache_page() is not supposed to be used on anonymous pages. What
we have for such pages is flush_anon_page() which is a no-op for VIPT
non-aliasing pages. I can see that __get_user_pages() calls both
flush_anon_page() flush_dcache_page().

Is the problem that you have related to I-D cache coherency? Is
flush_anon_page() the right place for this?

-- 
Catalin
