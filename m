From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Aug 2013 11:12:14 +0100
Subject: [PATCH v7] watchdog: Add MOXA ART watchdog driver
In-Reply-To: <51FBE0D5.3070007@roeck-us.net>
References: <1375098093-8975-1-git-send-email-jonas.jensen@gmail.com>
 <1375101228-10930-1-git-send-email-jonas.jensen@gmail.com>
 <20130802114159.GK2884@e106331-lin.cambridge.arm.com>
 <51FBE0D5.3070007@roeck-us.net>
Message-ID: <20130805101214.GB7594@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 05:39:49PM +0100, Guenter Roeck wrote:
> On 08/02/2013 04:41 AM, Mark Rutland wrote:
> > On Mon, Jul 29, 2013 at 01:33:48PM +0100, Jonas Jensen wrote:
> >> Add watchdog driver for MOXA ART SoCs.
> >>
> [ ... ]
> >> +
> >> +	err = watchdog_register_device(&moxart_wdt->dev);
> >> +	if (unlikely(err))
> >> +		return err;
> >
> > This is a probe path. Is the use of unlikely() really appropriate here?
> > I suspect it doesn't make any appreciable difference, and should go.
> >
> Just wondering, for my education - why ? Is there s rule that unlikely()
> shall not be used in the probe path ? If so, I would like to know it and
> its reasoning to be able to apply it to my own reviews.

I thought there had been some discussion on LKML about likely and
unlikely being abused, but in some quick searching I couldn't find the
thread I remembered. I found a comment from Steve Rostedt [1], but
that's not necessarily canonical.

As I understand it, likely() and unlikely() should be used to tell the
compiler to optimise for very specific cases where we know the branch
likelihood far better than the compiler, and the performance gain is
significant (i.e. hot paths). Using them elsewhere may lead to
performance and/or size degradation, as we're asking the compiler to do
something other than what it believes is optimal.

Probing is far from a hot path, and it seems in this case at least that
unlikely() is only present as part of some duplicated black magic.

Thanks,
Mark.

[1] https://lkml.org/lkml/2011/1/3/135
