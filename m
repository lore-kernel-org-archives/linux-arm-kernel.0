From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 12 Jul 2010 16:05:35 +0800
Subject: [RFC,PATCH 0/2] Allow late mdesc detection
In-Reply-To: <alpine.LFD.2.00.1007112334390.10598@xanadu.home>
References: <1278903792.387175.713057245098.0.gpush@pororo>
	<alpine.LFD.2.00.1007112334390.10598@xanadu.home>
Message-ID: <1278921935.9235.90.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> The fundamental problem with those patches is that we actually want to 
> move in the opposite direction for the eventual support of multiple SOCs 
> in the same kernel, i.e. rely on the machine ID -> mdesc to determine 
> the right debug addresses at run time and eventually make the addruart 
> into something that is not hardcoded at compile time.

Sure, I think that's where we're going in general, but I think the debug
stuff is an exception - we want that up as early as possible, and with
as few dependencies on other bits of code as possible.

At present we can only ever select one implementation of addruart in a
kernel build, so we just can't have a multiplatform kernel with debug
support. We *could* add other trickery to select a debug implementation
at runtime, but I think adding complexity to the debug path is a bad
idea.

I think allowing a hard-coded debug system is fine; it can be enabled
when we're debugging a specific problem, and removed to enable the true
multiplatform support. This is also what is done on powerpc - you can
select a "udbg" output method suitable for your platform at compile
time, but this doesn't affect the other parts of the kernel.

I also think it's good to only specify the debug parameters in one place
(addruart), rather than have to provide them in adduart *and* the mdesc.

Thoughts?

Cheers,


Jeremy
