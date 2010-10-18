From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 18 Oct 2010 17:32:09 +0200
Subject: [PATCH 0/3] Add OMAP hardware spinlock misc driver
In-Reply-To: <tnxeibnh67q.fsf@e102109-lin.cambridge.arm.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287406015.29097.1579.camel@twins>
	<20101018133502.GA12449@n2100.arm.linux.org.uk>
	<1287409417.29097.1598.camel@twins>
	<tnxeibnh67q.fsf@e102109-lin.cambridge.arm.com>
Message-ID: <1287415929.29097.1616.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-18 at 16:27 +0100, Catalin Marinas wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, 2010-10-18 at 14:35 +0100, Russell King - ARM Linux wrote:
> >> In any case, Linux's spinlock API (or more accurately, the ARM exclusive
> >> access instructions) relies upon hardware coherency support (a piece of
> >> hardware called an exclusive monitor) which isn't present on the M3 nor
> >> DSP processors.  So there's no way to ensure that updates from the M3
> >> and DSP are atomic wrt the A9 updates.
> >
> > Right, so the problem is that there simply is no way to do atomic memory
> > access from these auxiliary processing units wrt the main CPU? Seeing as
> > they operate on the same memory space, wouldn't it make sense to have
> > them cache-coherent and thus provide atomicy guarantees through that?
> 
> With cache coherency you may get atomicity of writes or reads but
> usually not atomic modifications.

Sure, but you can 'easily' extend your coherency protocols with support
for things like ll/sc (or larger transactions).

Have ll bring the cacheline into exclusive state and tag it, then
anything that demotes the cacheline will clear the tag and make sc fail.
