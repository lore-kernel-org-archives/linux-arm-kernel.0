From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Aug 2011 17:00:39 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20053.7340.865511.561798@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
	<20051.57876.785018.498967@mariner.uk.xensource.com>
	<20110824135109.GP32688@e102144-lin.cambridge.arm.com>
	<20053.7340.865511.561798@mariner.uk.xensource.com>
Message-ID: <20110824160039.GR32688@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 04:45:48PM +0100, Ian Jackson wrote:
> Will Deacon writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> >   After the system has taken care of whatever secure initialisation was
> >   required, it moves into HYP mode. At this point there are two things that
> >   can happen:
> > 
> >   1.0: HYP mode boot loader (uboot, UEFI) runs and installs Linux at the
> >        same privilege level
> >   1.1: Raw Linux boots, and detects HYP mode
> >   1.2: Sets up basic init, with HVC trampoline for installing KVM/Xen later
> >   1.3: Switch to SVC mode
> >   1.4: Continue booting Linux as normal
> 
> Since we have discovered that this approach will work fine with
> existing kernels, even ones which are completely unaware of Hyp mode,
> I think this is the right approach.  It can be implemented by boot
> loaders etc. right away.

It's certainly the simplest method from our point of view, but there is
still the necessity to support the other situation I described rather than
retrofit it when hardware that does it turns up [which it will].

The next step is to define our interface to the HVC trampoline. I think it
would be good if this interface could be reused by vendors who provide their
own hypervisor layer as this would reduce the need for lots of distinct HVC
APIs that essentially all do the same thing. It might be a good idea to
`reserve' a high region of the HVC space for use by Linux rather than index
the calls from 0, for example, which is likely to conflict with other
hypervisor implementations. I think the trampoline only needs a handful of
HVC calls (if that) anyway.

What do you reckon?

Will
