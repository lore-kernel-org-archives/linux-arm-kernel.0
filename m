From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Jul 2010 18:21:34 +0100
Subject: [patch 2/2] arm: Implement l2x0 cache disable function
In-Reply-To: <1278087010.10162.271.camel@e102109-lin.cambridge.arm.com>
References: <alpine.LFD.2.00.1007021658300.2525@localhost.localdomain>
	<1278087010.10162.271.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100702172134.GA2978@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 02, 2010 at 05:10:10PM +0100, Catalin Marinas wrote:
> On Fri, 2010-07-02 at 16:29 +0100, Thomas Gleixner wrote:
> > True, but that's an implementation detail. What's more important is to
> > make a decision how to solve the problem as kexec is completely
> > unusable for all L2 systems right now.
> 
> My view is that we should try to find why cache flushing doesn't work
> but unfortunately I don't have any spare time to look into this (would
> need to use tools like ICE debugging/tracing).

It's quite simple.  If you leave the L2 cache enabled, then the
decompressor needs to have L2 cache support in it, since it re-enables
the cache.  We really don't want to go down that route.

Moreover, boot loaders will not expect L2 cache to be enabled when we
re-enter them for soft-reboot via their reset vector.

So, I agree with Thomas - we have to preserve the already stated
requirements in the kernel booting document(s) which stipulate that
caches must be disabled when the kernel is called.
