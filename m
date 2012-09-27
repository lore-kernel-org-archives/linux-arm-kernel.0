From: gmbnomis@gmail.com (Simon Baatz)
Date: Thu, 27 Sep 2012 19:35:43 +0200
Subject: [PATCH 2/2] ARM: remove unnecessary flush of anon pages in
 flush(_kernel)_dcache_page()
In-Reply-To: <20120927122327.GA26188@arm.com>
References: <1348695659-27603-1-git-send-email-gmbnomis@gmail.com>
 <1348695659-27603-3-git-send-email-gmbnomis@gmail.com>
 <20120927122327.GA26188@arm.com>
Message-ID: <20120927173543.GA20442@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Thu, Sep 27, 2012 at 01:23:28PM +0100, Catalin Marinas wrote:
> On Wed, Sep 26, 2012 at 10:40:59PM +0100, Simon Baatz wrote:
> > On non-aliasing VIPT D-caches, there is no need to flush the kernel
> > mapping of anon pages in flush_kernel_dcache_page() and
> > flush_dcache_page() directly.  If the page is mapped as executable
> > later, the necessary D/I-cache flush will be done in
> > __sync_icache_dcache().
> > 
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> I would suggest you make this patch the first one rather than
> introducing __flush_kernel_dcache_page() and subsequently replacing its
> code.

The reason for this structure is that I did not want to mix the bug
fix (which may qualify for stable) with the improvement.  If I do the
patches the other way around and only the bug fix patch will be
picked for stable, flush_dcache_page() and flush_kernel_dcache_page()
will have different logic in which cases to flush.  We know that the
current logic is solid, we don't have much evidence for the logic of
the proposed improvement.

>From this point of view, I find the current structure cleaner, but I
have no strong opinion about this.  If we can't apply that particular
patch for stable anyway or you still think it is better the other way
around, I can change that of course.

- Simon
