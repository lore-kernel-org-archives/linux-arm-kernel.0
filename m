From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Apr 2018 12:36:52 +0100
Subject: [PATCH] arm64: signal: don't force known signals to SIGKILL
In-Reply-To: <20180417144630.GG16308@e103592.cambridge.arm.com>
References: <20180416154501.56872-1-mark.rutland@arm.com>
 <20180417144630.GG16308@e103592.cambridge.arm.com>
Message-ID: <20180418113652.vvlopeqvlk4vwmnf@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 03:46:31PM +0100, Dave Martin wrote:
> On Mon, Apr 16, 2018 at 04:45:01PM +0100, Mark Rutland wrote:
> > Since commit:
> > 
> >   a7e6f1ca90354a31 ("arm64: signal: Force SIGKILL for unknown signals in force_signal_inject")
> > 
> > ... any signal which is not SIGKILL will be upgraded to a SIGKILL be
> > force_signal_inject(). This includes signals we do expect, such as
> > SIGILL triggered by do_undefinstr().
> > 
> > Fix the check to use a logical AND rather than a logical OR, permitting
> > signals whose layout is SIL_FAULT.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Fixes: a7e6f1ca90354a31 ("arm64: signal: Force SIGKILL for unknown signals in force_signal_inject")
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Dave Martin <dave.martin@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/traps.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index ba964da31a25..1cb2749a72bf 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -366,7 +366,7 @@ void force_signal_inject(int signal, int code, unsigned long address)
> >  	}
> >  
> >  	/* Force signals we don't understand to SIGKILL */
> 
> Is it worth updating the comment here?
> 
> What's the rationale for this check?

Per the commit log for a7e6f1ca90354a31:

----
arm64: signal: Force SIGKILL for unknown signals in force_signal_inject

For signals other than SIGKILL or those with siginfo_layout(signal, code)
== SIL_FAULT then force_signal_inject does not initialise the siginfo_t
properly. Since the signal number is determined solely by the caller,
simply WARN on unknown signals and force to SIGKILL.

Reported-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
----

> 
> IIRC the purpose of this is to ensure that any siginfo delivered to
> userspace through this path is initialised correctly: so, either the
> signal must be a SIL_FAULT signal (since that's what the subsequent code
> initialises for) or SIGKILL (since userspace can't inspect the siginfo
> post-mortem, so the initialisation doesn't matter in that case).

Per the commit log and code, that seems to be the case, yes.

> Maybe moving this check before the switch() would make the logic
> clearer.  Not sure though.

I don't have a strong feeling either way, but I think that can be punted
to a separate cleanup.

> 
> > -	if (WARN_ON(signal != SIGKILL ||
> > +	if (WARN_ON(signal != SIGKILL &&
> >  		    siginfo_layout(signal, code) != SIL_FAULT)) {
> >  		signal = SIGKILL;

Do you have a concern with the logical change here, or can I ask for
your ack? ;)

Thanks,
Mark.
