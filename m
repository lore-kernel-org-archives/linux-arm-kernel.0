From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Aug 2017 14:10:24 +0100
Subject: [PATCH 05/14] arm64: clean up THREAD_* definitions
In-Reply-To: <20170814115958.dqg2xrobls4jcgx3@armageddon.cambridge.arm.com>
References: <1502130965-18710-1-git-send-email-mark.rutland@arm.com>
 <1502130965-18710-6-git-send-email-mark.rutland@arm.com>
 <20170814115958.dqg2xrobls4jcgx3@armageddon.cambridge.arm.com>
Message-ID: <20170814131023.GA23428@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 12:59:59PM +0100, Catalin Marinas wrote:
> On Mon, Aug 07, 2017 at 07:35:56PM +0100, Mark Rutland wrote:
> > Currently we define THREAD_SIZE and THREAD_SIZE order separately, with
> 
> s/THREAD_SIZE order/THREAD_SIZE_ORDER/

Whoops; I'll fix that up now.

> > +#define THREAD_SHIFT		14
> > +
> > +#if THREAD_SHIFT >= PAGE_SHIFT
> > +#define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
> > +#endif
> > +
> > +#define THREAD_SIZE		(UL(1) << THREAD_SHIFT)
> 
> I haven't tried the series to this patch but it seems to me that
> THREAD_SIZE_ORDER is undefined for a PAGE_SHIFT of 16. 

That is already the case without these patches, as we have:

#ifdef CONFIG_ARM64_4K_PAGES
#define THREAD_SIZE_ORDER       2
#elif defined(CONFIG_ARM64_16K_PAGES)
#define THREAD_SIZE_ORDER       0
#endif

... this is also deliberate, as we'd need an order of -2 with 16K stacks and
64K pages, and this doesn't make sense.

THREAD_SIZE_ORDER only matters if THREAD_SIZE >= PAGE_SIZE (or if we're using a
VMAP'd stack). For 64K pages && VMAP_STACK, we'll use a 64K stack, avoiding the
problem.

Thanks,
Mark.
