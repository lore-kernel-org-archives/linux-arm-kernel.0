From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Mar 2011 18:44:19 -0000
Subject: [PATCH] ARM: perf: ensure overflows aren't missed due to IRQ
	latency
In-Reply-To: <4D8A3D6A.1000409@codeaurora.org>
References: <1300895525-10800-1-git-send-email-will.deacon@arm.com>	<20110323181302.GF2795@pulham.picochip.com>
	<AANLkTimOKgtuAwYOrnx7anW1__wzQg-rPhqqRmC=qJcY@mail.gmail.com>
	<4D8A3D6A.1000409@codeaurora.org>
Message-ID: <003501cbe98a$51c00b10$f5402130$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 03/23/2011 02:28 PM, Jamie Iles wrote:
> > Hmm, I'm not really sure I follow that and see how it works for an
> > overflow when new < prev.  Why doesn't the naive:
> >
> >        new_raw_count &= armpmu->max_period;
> >        prev_raw_count &= armpmu->max_period;
> >        if (overflow)
> >                delta = (armpmu->max_period - prev_raw_count) +
> >                        new_raw_count
> >        else
> >                delta = new_raw_count - prev_raw_count;
> >
> > work?  I'm sure I'm missing something here!
> >
> > Jamie
> 
> When new < prev, delta will be greater than 2^32. So we'll have accounted for the overflow condition
> anyway.
> 
> The naive solution you mention above is what we discussed earlier and works too.

Yup, they both work but I think Jamie's version is easier to read so
I'll roll another patch...

> I guess the additional:
> 
> >        new_raw_count &= armpmu->max_period;
> >        prev_raw_count &= armpmu->max_period;
> 
> just makes it cleaner than the shifting to upper 32bits, subtracting and then shifting back again.

... but I'm having second thoughts about using max_period as the
mask. If the period was anything other than 0xffffffff then it
wouldn't work. I'll add another field to the PMU structure in
case somebody in the future has counters with strange period
constraints.

Will
