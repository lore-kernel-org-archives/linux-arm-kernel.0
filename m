From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 02 Mar 2010 15:11:01 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267441814.23333.65.camel@e102109-lin.cambridge.arm.com>
References: <1266979632.23523.1668.camel@pasglop>
	<1267201521.14703.50.camel@e102109-lin.cambridge.arm.com>
	<1267220429.23523.1811.camel@pasglop>
	<20100226214908.GD23933@n2100.arm.linux.org.uk>
	<1267316647.23523.1852.camel@pasglop>
	<1267441814.23333.65.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1267503061.2173.4.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-03-01 at 11:10 +0000, Catalin Marinas wrote:
> 
> 
> Yes. That could be solved at set_pte_at() level using IPIs.

Well, set_pte_at() itself is called with the PTE lock held, so you have
to be careful with IPIs at that point. You need the flush to happen
-before- the PTE is visible and you cannot synchronously send an IPI.

> > For that case, I see two options. One is a big hammer but would make
> > existing code work to "most" extent: Don't allow a page to be both
> > writable and executable. Ping-pong the page permission lazily and
> flush
> > when transitioning from write to exec.
> 
> Are you referring to the SMP and non-broadcasting cache maintenance
> issue? The same pte could be shared between multiple CPUs, so once you
> make it executable on one it becomes executable on the others.

Right, you would have to play the ping-pong trick globally. That's what
I do on ppc 440 for bluegene though that code isn't upstream.

Cheers,
Ben.
