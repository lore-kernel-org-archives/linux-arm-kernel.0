From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Mon, 13 Jun 2011 17:11:07 +0100 (BST)
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <alpine.DEB.2.00.1106131546070.19778@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
	<20110613122601.GC12325@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>
	<20110613135649.GB8498@arm.com>
	<alpine.DEB.2.00.1106131546070.19778@localhost6.localdomain6>
Message-ID: <alpine.DEB.2.00.1106131643420.19778@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jun 2011, Frank Hofmann wrote:

[ ... ]
> So it's kind of a two-pronged attack to minimize the SoC-specific code, 
> Colin's framework to extract common code from the "outer" parts and Russell's 
> cpu_suspend/resume to extract common code from the "inner" parts.

Also, to clarify on the hibernation side:


The biggest shortfall of the hibernation support patch that I've posted is 
that it currently has no awareness of the "peripheral" side of things at 
all, i.e. all the stuff done by the platform_suspend_ops->begin/enter/end 
for the suspend-to-mem case isn't replicated sufficiently by the 
hibernation codepath.

If you like, swsusp_arch_suspend / resume are on the same level of 
complexity as are the functions in platform_suspend_ops. But the current 
hibernation patch does only parts of that. It gets away with this largely 
because it "resumes from ON" ...

As far as that is concerned, Russell really has a point, to do all this 
properly / well for the hibernation case, a hibernation-specific approach 
on the platform_ops abstraction level would be better than just to hack 
low-level generics together for the sake of hacking low-level generics 
together.


If just doing per-SoC hibernation, then the code bloat problem remains, on 
ARM there's already platform_suspend_ops per SoC; if one adds a full set 
of platform_hibernation_ops per SoC without thinking where/how to 
consolidate, it'd only create another mess. Beware the beginnings ...


I had thought the idea of using cpu_suspend / resume actually made it 
clear that my main point for all this "use generics wherever imaginable" 
is to never allow for unnecessary bloat in the first place and hence opt 
for generics even if somewhat imperfect / shoehorned for the general case.

I'd like to apologize if that didn't come over.


I'm following the work in this area; compared to where things were a year 
ago a lot of things have happened already. In a way, my hope is that part 
of all this blah of mine is helping to identify areas where code might be 
shared even if that starts out as coincidental (as is the current use of 
cpu_suspend / resume inside the hibernation patch).

FrankH.
