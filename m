From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Aug 2011 14:51:09 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20051.57876.785018.498967@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
	<20051.57876.785018.498967@mariner.uk.xensource.com>
Message-ID: <20110824135109.GP32688@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Tue, Aug 23, 2011 at 06:23:32PM +0100, Ian Jackson wrote:
> Catalin Marinas writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> > (I'll be on holiday from tomorrow, so not able to follow up until September).
> 
> Right.  Let's try to be quick :-).

Ha, you've got enough people interested now that there's no need to rush!

> > We had some discussions both with ARM partners and Christoffer and it
> > is not clear how we go about initialising the Hyp mode. Most SoC
> > vendors would probably just run Linux in non-secure SVC mode and would
> > not touch the Hyp mode at all. Linux would issue an SMC to set the
> > HVBAR (could do HVC but I expect that there is no secure monitor
> > code). Once this is set, assuming that the Hyp MMU is disabled, Linux
> > can invoke an HVC and initialise the Hyp mode.
> 
> Well, yes.  Do SoC vendors all expect to own the secure state ?
> 
> If so then the answer is perhaps simply that they should boot Linux in
> Hyp mode (and expect Linux to drop to ordinary svc mode).

I think it's important to separate the problems of secure boot with the
problems of installing a hypervisor. Whatever happens in secure world, we can
expect to be dropped at either HYP mode or non-secure SVC mode. Sure, on a dev
board you might run directly in the secure world so there's a bit of extra
work to do to get out of that but then we can just drop into HVC mode and
forget about it.

> If we had a more functional bootloader setup (which AIUI is definitely
> planned) we could do.
> 
> > > ? (b) If started in Hyp mode:
> > > ? ? ? * Install a trivial hypervisor vector which unconditionally
> > > ? ? ? ? copies r0 to HVBAR and returns
> > > ? (c) Rest of startup.
