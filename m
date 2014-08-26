From: jdl@jdl.com (Jon Loeliger)
Date: Tue, 26 Aug 2014 08:58:34 -0500
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <53FC76E8.5050009@ahsoftware.de>
References: <20140825093931.GB2399@ulmo> <E1XLu15-0002DP-6o@jdl.com>
 <20140825133714.GH4163@ulmo.nvidia.com>
 <20140826084208.AE5F0C40989@trevor.secretlab.ca>
 <20140826084922.GG17263@ulmo> <53FC566C.30904@ahsoftware.de>
 <20140826102503.GC31124@ulmo> <53FC6513.5040800@ahsoftware.de>
 <20140826110827.GA31350@ulmo> <53FC6E4A.6030407@ahsoftware.de>
 <20140826114718.GB641@ulmo> <53FC76E8.5050009@ahsoftware.de>
Message-ID: <E1XMHGc-0008TS-CQ@jdl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>
> >> Drivers don't provide that information (dependencies) in any usable way. And
> >> as you said yourself, it's already contained in phandles. So what we are
> >> discussing here about? The proposal to use phandles for that is already on
> >> the table since several month. ;)
> >>
> >> Sorry, but I don't understand what you want to propose.
> >
> > In many cases we simply don't know where phandles are stored since we
> > don't have the type information in DT. But drivers already know the type
> > of a specific phandle and where to get it from, so the proposal is to
> > make that knowledge more generally useful so that it can be used for
> > dependency resolution.
> 
> How?

Is the issue around which we are dancing here the timing of
topsort and the probing?  When the driver is probed, sure, it
touches and resolves a bunch of phandles and references other
nodes and devices.  But that is at probe time, and it only has
the context of itself then.

I think we need to do the complete topsort *before* we attempt
to do any probing.  So three steps:

    1) Graph Construction
        Add a new "emit dependencies" function to driver bindings.
        Iterate over known devices or nodes in the DT in any order.
	    Call the "emit dependencies" function.  It adds all
	    dependency edges to a global graph by knowing what
	    phandles or other pieces it will need.
	    A driver with no "emit dependencies" function can be
	    added to the graph anywhere without loss of generality.
        Add any additional edges for whatever reason.

    2) Topsort the generated driver graph

    3) Call probe for real in topsort order
      
Alexander, I don't recall the details of your patch series.
Can you please remind us if it took this approach in the kernel?

> Anyway, I'm leaving this discussion. I've already made a proposal
> which solved most mentioned problems (imho) and even offered usable
> patches

Darn.  I think you clearly have a pony in this race, and it
would be good if you still participated.  Really.

> (ok, they suffer under the "not invented here" syndrom, but ...). ;)

There isn't a single thing in the entire Linux Kernel community
that was "invented here"; every aspect of it was NIH'ed by *someone*.
That's how it gets built, changed, maintained, fixed, etc.

> But please continue this discussion, I will try to not disturb it
> anymore.

I'm sorry to hear that.

> Regards,
> Alexander Holler

HTH,
jdl
