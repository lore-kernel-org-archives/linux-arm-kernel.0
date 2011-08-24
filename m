From: Ian.Jackson@eu.citrix.com (Ian Jackson)
Date: Wed, 24 Aug 2011 17:09:01 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20110824160039.GR32688@e102144-lin.cambridge.arm.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
	<20051.57876.785018.498967@mariner.uk.xensource.com>
	<20110824135109.GP32688@e102144-lin.cambridge.arm.com>
	<20053.7340.865511.561798@mariner.uk.xensource.com>
	<20110824160039.GR32688@e102144-lin.cambridge.arm.com>
Message-ID: <20053.8733.266040.189343@mariner.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> The next step is to define our interface to the HVC trampoline. I think it
> would be good if this interface could be reused by vendors who provide their
> own hypervisor layer as this would reduce the need for lots of distinct HVC
> APIs that essentially all do the same thing. It might be a good idea to
> `reserve' a high region of the HVC space for use by Linux rather than index
> the calls from 0, for example, which is likely to conflict with other
> hypervisor implementations. I think the trampoline only needs a handful of
> HVC calls (if that) anyway.
> 
> What do you reckon?

I think the trampoline needs to have one hypercall: "set HVBAR".
(And, implicitly, it needs to be specified that the resulting vectors
will run without physical-to-virtual page translation, etc.)  That is
sufficient to bootstrap all the rest of the way up - and that other
bootstrapping code would have to exist anyway.

So I'm imagining that the kvm kernel module would, when loaded,
make that "set HVBAR" once on each cpu, replacing the trampoline
hypervisor with its own set of hypercall vectors.

Ian.
