From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 6 Apr 2017 11:07:02 +0100
Subject: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
In-Reply-To: <20170405183808.GB27550@leverpostej>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-10-fu.wei@linaro.org>
 <20170405183808.GB27550@leverpostej>
Message-ID: <20170406100702.GC29947@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 07:38:09PM +0100, Mark Rutland wrote:
> I tried to fix the issue that Lornzo raised, such that I could queue
> these patches. From looking at this patch in more detail however, I
> think there are further issues that need to be addressed.

Looking again, I see that I was mistaken w.r.t. the multi GT block case.

> > +int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
> > +				    int *timer_count)
> > +{
> > +	int ret;
> > +	void *platform_timer;
> > +
> > +	*timer_count = 0;
> > +	for_each_platform_timer(platform_timer) {
> > +		if (is_timer_block(platform_timer)) {
> > +			ret = gtdt_parse_timer_block(platform_timer, timer_mem);
> > +			if (ret)
> > +				return ret;
> > +			timer_mem++;
> > +			(*timer_count)++;
> > +		}
> > +	}
> 
> If we were to have multiple GT blocks, this would leave timer_mem in an
> inconsistent state. In gtdt_parse_timer_block we'll blat any existing
> timer_mem->cntctlbase, and blat some arbitrary set of frames. however,
> *some* frames may have been held over from a previous iteration.

This is not the case; I had somehow missed the timer_mem++.

Sorry for the noise.

Thanks,
Mark.
