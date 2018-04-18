From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Apr 2018 14:44:25 +0100
Subject: [PATCH] arm64: signal: don't force known signals to SIGKILL
In-Reply-To: <20180418133331.GJ16308@e103592.cambridge.arm.com>
References: <20180416154501.56872-1-mark.rutland@arm.com>
 <20180417144630.GG16308@e103592.cambridge.arm.com>
 <20180418113652.vvlopeqvlk4vwmnf@lakrids.cambridge.arm.com>
 <20180418133331.GJ16308@e103592.cambridge.arm.com>
Message-ID: <20180418134425.wmqmxlsphedf36d5@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 02:33:32PM +0100, Dave Martin wrote:
> On Wed, Apr 18, 2018 at 12:36:52PM +0100, Mark Rutland wrote:
> > On Tue, Apr 17, 2018 at 03:46:31PM +0100, Dave Martin wrote:
> > > On Mon, Apr 16, 2018 at 04:45:01PM +0100, Mark Rutland wrote:
> > > > -	if (WARN_ON(signal != SIGKILL ||
> > > > +	if (WARN_ON(signal != SIGKILL &&
> > > >  		    siginfo_layout(signal, code) != SIL_FAULT)) {
> > > >  		signal = SIGKILL;
> > 
> > Do you have a concern with the logical change here, or can I ask for
> > your ack? ;)
> 
> No concern, I just wanted to make sure I'd understood the background
> right.  The commit message for this patch doesn't fully explain why the
> original code was wrong and why the new code is right, and my memory of
> the context for this was a bit fuzzy.
> 
> I should probably have followed the Fixes tag for context, but I was
> lazy :P
> 

> Anyway, FWIW
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers!

Catalin, are you happy to queue this as a fix for v4.17-rc2?

> Out of interest, what were you seeing in userspace prior to this fix?
> Please don't tell me systemd is functionally reliant on SIGILL :(

I spotted this with a pointer authentication test case I wrote, which I
expected to receive SIGILL when using an instruction trapped and UNDEF'd
by EL2.

Thanks,
Mark.
