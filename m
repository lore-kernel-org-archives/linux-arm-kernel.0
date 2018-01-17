From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 17 Jan 2018 12:15:05 +0000
Subject: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and
 SIGFPE, SIGTRAP, SIGBUS
In-Reply-To: <20180117115708.GM17719@n2100.armlinux.org.uk>
References: <87373b6ghs.fsf@xmission.com>
 <20180112005940.23279-7-ebiederm@xmission.com>
 <20180115163028.GU22781@e103592.cambridge.arm.com>
 <87h8rnox3c.fsf@xmission.com>
 <20180116172407.GA22781@e103592.cambridge.arm.com>
 <871sipl9p9.fsf@xmission.com>
 <20180117115708.GM17719@n2100.armlinux.org.uk>
Message-ID: <20180117121505.GD22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 11:57:09AM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 16, 2018 at 04:28:50PM -0600, Eric W. Biederman wrote:
> > I will keep FPE_FIXME as a place holder until this gets sorted out.
> > 
> > There is a second issue I am looking at in this location,
> > and maybe I don't have to address it now.  But it looks like the code is
> > calling send_sig_info instead of force_sig_info for a synchronous
> > exception.  Am I reading that correctly?
> 
> VFP used to use force_sig_info(), but it seems to be really the wrong
> call to use.  force_sig_info() checks whether the program decided to
> ignore or block the signal, and if it did, replaces the signal handler
> with the default handler and unblocks the signal.
> 
> Are you really suggesting that FP all FP signals should get this
> treatment?

feenableexcept(FE_OVERFLOW) kind of means "I can't run safely past
an fp overflow exception, please signal me instead".

If the process also blocked SIGFPE, that could be taken to mean
"I can't run safely past an fp overflow exception _and_ I can't
take SIGFPE either" ... i.e., if an fp overflow happens there is
no way to proceed and it's really fatal.

What SIG_IGN ought to mean is rather more debatable, but again,
the process could be asking for two opposite things: guarantee a
SIGFPE is delivered instead of running past an fp exception, and
also guarantee that SIGFPE is _not_ delivered.

It looks like arm and arm64 are different from most other arches
(including x86) here, but I'm not sure what is considered correct, and
it looks like the answer is not standardised.  There's a possibility
that some software goes subtly wrong on arm/arm64 where on other arches
it would get terminated with SIGKILL.

Whether this matters depends on how harmless the fp exception is to
the work of the program.  I think if an exception is set to trap
via feenableexcept() then that's a strong hint the programmer thinks
that exception is not harmless.  OTOH, trapping is not always
available anyway...


Was there some particular program being broken by the force_sig_info()
here?

Cheers
---Dave
