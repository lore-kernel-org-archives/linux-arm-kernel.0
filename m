From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 May 2018 13:26:52 +0100
Subject: [PATCH 1/2] arm64: signal: Report signal frame size to userspace
 via auxv
In-Reply-To: <20180508114323.GG7753@e103592.cambridge.arm.com>
References: <1525776211-28169-1-git-send-email-Dave.Martin@arm.com>
 <1525776211-28169-2-git-send-email-Dave.Martin@arm.com>
 <20180508113043.elgvfz3dud2amcif@lakrids.cambridge.arm.com>
 <20180508114323.GG7753@e103592.cambridge.arm.com>
Message-ID: <20180508122652.3zbgvpx7x2al5g5m@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2018 at 12:43:24PM +0100, Dave Martin wrote:
> On Tue, May 08, 2018 at 12:30:44PM +0100, Mark Rutland wrote:
> > On Tue, May 08, 2018 at 11:43:30AM +0100, Dave Martin wrote:
> > > +/*
> > > + * Determine the stack space required for guaranteed signal devliery.
> > > + * This function is used to populate AT_MINSIGSTKSZ at process startup.
> > > + */
> > > +int get_minsigstksz(void)
> > > +{
> > > +	static __read_mostly atomic_t minsigstksz;
> > > +
> > > +	int ret;
> > > +	struct rt_sigframe_user_layout user;
> > > +
> > > +	ret = atomic_read(&minsigstksz);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	init_user_layout(&user);
> > > +	ret = setup_sigframe_layout(&user, true);
> > > +
> > > +	if (ret) {
> > > +		WARN_ON(1);
> > > +
> > > +		ret = SIGSTKSZ;
> > > +	} else {
> > > +		ret = sigframe_size(&user) +
> > > +			round_up(sizeof(struct frame_record), 16) +
> > > +			16; /* max alignment padding */
> > > +	}
> > > +
> > > +	/*
> > > +	 * The computed value (ret) is invariant, so its value can be
> > > +	 * safely stored irrespective of whether some other racing
> > > +	 * task got there first:
> > > +	 */
> > > +	atomic_set(&minsigstksz, ret);
> > > +	return ret;
> > > +}
> > 
> > Can we set up minsigstksz at some initcall time? that way get_minstksz()
> > can return minsigstksz with no conditionality at all.
> 
> I would have preferred to do that, but I wasn't sure where to put it.
> 
> Unless arch_initcall_sync() works for this, I don't know what to
> suggest.

Perhaps have a setup_minsigstksz(), and call that at the end of
setup_cpu_features()?

Thanks,
Mark.
