From: Ian.Jackson@eu.citrix.com (Ian Jackson)
Date: Tue, 23 Aug 2011 18:23:32 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
Message-ID: <20051.57876.785018.498967@mariner.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> (I'll be on holiday from tomorrow, so not able to follow up until September).

Right.  Let's try to be quick :-).

> We had some discussions both with ARM partners and Christoffer and it
> is not clear how we go about initialising the Hyp mode. Most SoC
> vendors would probably just run Linux in non-secure SVC mode and would
> not touch the Hyp mode at all. Linux would issue an SMC to set the
> HVBAR (could do HVC but I expect that there is no secure monitor
> code). Once this is set, assuming that the Hyp MMU is disabled, Linux
> can invoke an HVC and initialise the Hyp mode.

Well, yes.  Do SoC vendors all expect to own the secure state ?

If so then the answer is perhaps simply that they should boot Linux in
Hyp mode (and expect Linux to drop to ordinary svc mode).

> The problem is that the SMC API is specific to a secure monitor
> implementation. An alternative would be to ask the vendors to get some
> simple Hyp code which would trap access to HVBAR for example and set
> it with that value.

That's seems to be extending the range of ways in which the firmware
can make things go wrong, and broadening the interface to the
firmware.

> From the above, I would just allow (iii). As Dave pointed out, we
> don't have the ELF information at this point.

If we had a more functional bootloader setup (which AIUI is definitely
planned) we could do.

> > ? (b) If started in Hyp mode:
> > ? ? ? * Install a trivial hypervisor vector which unconditionally
> > ? ? ? ? copies r0 to HVBAR and returns
> > ? (c) Rest of startup.
> 
> Maybe we could allow (b) if SoC vendors don't provide a different API
> to set the HVBAR. But it means that kernels not aware of this feature
> would fail.

It turns out that at least your kernel boots just fine if started in
Hyp mode :-).

Ian.
