From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Sep 2013 18:19:47 -0400 (EDT)
Subject: [PATCH] ARM: MCPM: don't explode if invoked without being
 initialized first
In-Reply-To: <20130924220341.GA23730@e102568-lin.cambridge.arm.com>
References: <alpine.LFD.2.03.1309231522470.312@syhkavp.arg>
 <20130924085101.GA25927@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1309241136540.312@syhkavp.arg>
 <20130924220341.GA23730@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1309241807000.312@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Sep 2013, Lorenzo Pieralisi wrote:

> On Tue, Sep 24, 2013 at 04:49:17PM +0100, Nicolas Pitre wrote:
> > @@ -98,8 +101,11 @@ void mcpm_cpu_power_down(void);
> >   *
> >   * This must be called with interrupts disabled.
> >   *
> > - * This does not return.  Re-entry in the kernel is expected via
> > - * mcpm_entry_point.
> > + * On success this does not return.  Re-entry in the kernel is expected
> > + * via mcpm_entry_point.
> > + *
> > + * This will return if mcpm_platform_register() has not been called
> > + * previously in which case the caller should take appropriate action.
> >   */
> >  void mcpm_cpu_suspend(u64 expected_residency);
> 
> Ok, it is fine as it is, but at the risk of sounding pedantic, I thought
> about it and I reckon that it would be nicer to return an error value
> instead of just returning. In the bigger picture we might not want
> to always resume from the reset entry point, I think that adding a
> return value is worth the hassle, given that it is a trivial change.

And given it is trivial, this can be postponed until there is a clear 
meaning for a return value.  Right now there would be none.

> Resuming through the reset vector implies a successful cpu_suspend
> call (even if eg TC2 wfi is skipped), we may want for instance to monitor
> aborted shutdowns or the like.

OTOH, adding a return value now is on the verge of over engineering.

> Again, a return value gives us flexibility and it costs nothing, you
> can postpone it till the API is refactored though (residency parameter, etc).

Absolutely.  Until there is clear semantics for those return values, I 
don't see the point of having any.  The flexibility Linux gives us is 
not in the existence of a return value, but rather in the ability to add 
one when we really need it.  And right now we don't.

So unless there is a fundamental objection to this patch I'll submit it 
as is and we can augment the code with return values later.


Nicolas
