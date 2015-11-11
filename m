From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Wed, 11 Nov 2015 11:55:59 -0800
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <20151111185415.GI11639@twins.programming.kicks-ass.net>
References: <56436420.9090401@iogearbox.net> <20151111162341.GN9562@arm.com>
 <20151111172659.GA86334@ast-mbp.thefacebook.com>
 <20151111.123548.1039494689070388545.davem@davemloft.net>
 <20151111175741.GR17308@twins.programming.kicks-ass.net>
 <20151111181132.GA90947@ast-mbp.thefacebook.com>
 <20151111183128.GS17308@twins.programming.kicks-ass.net>
 <20151111184427.GH11639@twins.programming.kicks-ass.net>
 <20151111185415.GI11639@twins.programming.kicks-ass.net>
Message-ID: <20151111195558.GA4173@ast-mbp.thefacebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 07:54:15PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 11, 2015 at 07:44:27PM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 11, 2015 at 07:31:28PM +0100, Peter Zijlstra wrote:
> > > > Add new one that does 'fetch_and_add' ? What is the real use case it
> > > > will be used for?
> > > 
> > > Look at all the atomic_{add,dec}_return*() users in the kernel. A typical
> > > example would be a reader-writer lock implementations. See
> > > include/asm-generic/rwsem.h for examples.
> > 
> > Maybe a better example would be refcounting, where you free on 0.
> > 
> > 	if (!fetch_add(&obj->ref, -1))
> > 		free(obj);
> 
> Urgh, too used to the atomic_add_return(), which returns post op. That
> wants to be:
> 
> 	if (fetch_add(&obj->ref, -1) == 1)
> 		free(obj);

this type of code will never be acceptable in bpf world.
If C code does cmpxchg-like things, it's clearly beyond bpf abilities.
There are no locks or support for locks in bpf design and will not be.
We don't want a program to grab a lock and then terminate automatically
because it did divide by zero.
Programs are not allowed to directly allocate/free memory either.
We don't want dangling pointers.
Therefore things like memory barriers, full set of atomics are not applicable
in bpf world.
The only goal for bpf_xadd (could have been named better, agreed) was to
do counters. Like counting packets or bytes or events. In all such cases
there is no need to do 'fetch' part.
Another reason for lack of 'fetch' part is simplifying JIT.
It's easier to emit 'atomic_add' equivalent than to emit 'atomic_add_return'.
The only shared data structure two programs can see is a map element.
They can increment counters via bpf_xadd or replace the whole map element
atomically via bpf_update_map_elem() helper. That's it.
If the program needs to grab the lock, do some writes and release it,
then probably bpf is not suitable for such use case.
The bpf programs should be "fast by design" meaning that there should
be no mechanisms in bpf architecture that would allow a program to slow
down other programs or the kernel in general.
