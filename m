From: mathieu.desnoyers@polymtl.ca (Mathieu Desnoyers)
Date: Thu, 18 Mar 2010 22:12:22 -0400
Subject: [PATCH 1/1] [RFC] arm: add half-word __xchg
In-Reply-To: <20100319014906.GC14108@shareable.org>
References: <20100318123223.GA6855@Krystal>
	<1268919221-2748-1-git-send-email-virtuoso@slind.org>
	<20100318135008.GA11800@Krystal>
	<20100319014906.GC14108@shareable.org>
Message-ID: <20100319021222.GA17388@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jamie Lokier (jamie at shareable.org) wrote:
> Mathieu Desnoyers wrote:
> > But.. thinking about it. It's bad to have a 2-byte xchg primitive that
> > only works on UP and breaks the build on SMP. We should instead
> > implement a workaround based on __cmpxchg4 to perform the 2-byte xchg().
> 
> This exposes why there should be __cmpxchg_bool() versions, which do
> not loop, preferably in the generic kernel API, because the workaround
> using __cmpxchg4 has to add yet another pointless loop nesting to all
> cmpxchg users.

The workaround I propose is to use __cmpxchg4 in a loop for 2-byte xchg()
fallback on arm; it is not related to cmpxchg() in any way. I don't
think one single use-case justifies the creation of a __cmpxchg_bool()
across all architectures.

Also, I've never seen where having a cmpxchg primitive returning a
boolean is more efficient than returning the value read, ever. If we
have to loop, then we can re-use the value that has been read by
cmpxchg, while the version returning a boolean would need a read to
re-read the next value.

So.. I am afraid I am probably missing your point entirely, because I
don't see how this can improve anything.

Thanks,

Mathieu

> 
> --- Jamie

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
