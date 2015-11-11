From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 11 Nov 2015 19:54:15 +0100
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <20151111184427.GH11639@twins.programming.kicks-ass.net>
References: <56436420.9090401@iogearbox.net> <20151111162341.GN9562@arm.com>
 <20151111172659.GA86334@ast-mbp.thefacebook.com>
 <20151111.123548.1039494689070388545.davem@davemloft.net>
 <20151111175741.GR17308@twins.programming.kicks-ass.net>
 <20151111181132.GA90947@ast-mbp.thefacebook.com>
 <20151111183128.GS17308@twins.programming.kicks-ass.net>
 <20151111184427.GH11639@twins.programming.kicks-ass.net>
Message-ID: <20151111185415.GI11639@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 07:44:27PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 11, 2015 at 07:31:28PM +0100, Peter Zijlstra wrote:
> > > Add new one that does 'fetch_and_add' ? What is the real use case it
> > > will be used for?
> > 
> > Look at all the atomic_{add,dec}_return*() users in the kernel. A typical
> > example would be a reader-writer lock implementations. See
> > include/asm-generic/rwsem.h for examples.
> 
> Maybe a better example would be refcounting, where you free on 0.
> 
> 	if (!fetch_add(&obj->ref, -1))
> 		free(obj);

Urgh, too used to the atomic_add_return(), which returns post op. That
wants to be:

	if (fetch_add(&obj->ref, -1) == 1)
		free(obj);

Note that I would very much recommend _against_ encoding the post-op
thing in instructions. It works for reversible operations (like add) but
is pointless for irreversible operations (like or).

That is, given or_return(), you cannot reconstruct the state
prior to the operation, so or_return() provides less information than
fetch_or().
