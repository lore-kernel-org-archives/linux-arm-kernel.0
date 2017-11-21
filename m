From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 21 Nov 2017 10:51:47 -0800
Subject: [PATCH v2 18/18] arm64: select ARCH_SUPPORTS_LTO_CLANG
In-Reply-To: <1f19a8816278495f997f4331ef0e015e@AcuMS.aculab.com>
References: <20171116174830.GX3624@linux.vnet.ibm.com>
 <CAKwvOdkDz1yRo=Skt_mWxs0uucK+adXx8kFQksMbTE3ofnpUMQ@mail.gmail.com>
 <20171116183950.GA3624@linux.vnet.ibm.com>
 <20171116184508.GC21898@arm.com>
 <20171116191307.GC3624@linux.vnet.ibm.com>
 <20171116201701.GA143965@samitolvanen.mtv.corp.google.com>
 <20171120180554.GM32488@arm.com>
 <20171120193256.e6fnn2arwqc5wqkp@hirez.programming.kicks-ass.net>
 <20171120205350.GZ3624@linux.vnet.ibm.com>
 <1f19a8816278495f997f4331ef0e015e@AcuMS.aculab.com>
Message-ID: <20171121185147.GN3624@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 05:23:52PM +0000, David Laight wrote:
> From: Paul E. McKenney
> > Sent: 20 November 2017 20:54
> > 
> > On Mon, Nov 20, 2017 at 08:32:56PM +0100, Peter Zijlstra wrote:
> > > On Mon, Nov 20, 2017 at 06:05:55PM +0000, Will Deacon wrote:
> > > > Although the current direction of the C++ committee is to prefer
> > > > that dependencies are explicitly "marked", this is not deemed to be
> > > > acceptable for the kernel (in other words, everything is always considered
> > > > "marked").
> > >
> > > Yeah, that is an attitude not compatible with existing code. Much like
> > > the proposal to allow temporary/wide stores on everything not explicitly
> > > declared atomic. Such stuff instantly breaks all extant code that does
> > > multi-threading with no recourse.
> > 
> > If someone suggests temporary/wide stores, even on non-atomics, tell
> > them that the standard does not permit them to introduce data races.
> 
> The C standard doesn't say anything about multi-threading.

Actually, recent versions of the C standard really do cover
multi-threading, and have for some years.  For example, the June 2010
draft has this to say in section 5.1.2.4:

	Under a hosted implementation, a program can have more than one
	thread of execution (or thread) running concurrently.

Later, in paragraph 25 of this same section:

	The execution of a program contains a data race if it contains
	two conflicting actions in different threads, at least one of
	which is not atomic, and neither happens before the other. Any
	such data race results in undefined behavior.

Because the compiler is not allowed to introduce undefined behavior in a
program that does not already contain undefined behavior, the compiler
is absolutely forbidden from inventing stores unless it can prove that
doing so does not introduce a data race.

One (painful and annoying) case in which it can prove this is just before
a normal (non-volatile and non-atomic) store.

> The x86 bis (bit set) family are well known for being problematic
> because they always do a 32bit wide rmw cycle.

If the compiler is careful, it can invent atomic read-modify-write cycles
to uninvolved variables.  Here "is careful" includes ensuring that any
read from or write to one of those uninvolved variables acts just as it
would in the absence of the atomic read-modify-write cycle.

But I did say "store" above, not atomic read-modify-write operation.  ;-)

							Thanx, Paul
