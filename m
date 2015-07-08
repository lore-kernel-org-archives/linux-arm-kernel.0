From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Jul 2015 14:34:03 +0100
Subject: [PATCH 5/9] locking/qrwlock: remove redundant cmpxchg barriers
 on writer slow-path
In-Reply-To: <20150708100526.GC3644@twins.programming.kicks-ass.net>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
 <1436289865-2331-6-git-send-email-will.deacon@arm.com>
 <20150708100526.GC3644@twins.programming.kicks-ass.net>
Message-ID: <20150708133343.GC9283@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 11:05:26AM +0100, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 06:24:21PM +0100, Will Deacon wrote:
> > +#ifndef cmpxchg_relaxed
> > +# define cmpxchg_relaxed	cmpxchg
> > +#endif
> 
> Should we collate this _relaxed stuff and make it 'official' instead of
> these ad-hoc/in-situ things?
> 
> There's more archs that can usefully implement them than seem to have
> implemented them atm. Of course that means someone doing a full arch/*
> sweep, but hey.. :-)

Well, in writing this series, I'm seeing a repeated need for:

  * acquire/release/relaxed variants of cmpxchg
  * acquire/relaxed atomic_add_return
  * acquire/release atomic_sub

I also suspect that if I look at getting qspinlock up and running, the
list above will grow.

So you're right, but it sounds like we need to extend the atomic APIs to
have acquire/release/relaxed variants. The easiest start would be to
extend the _return variants (+cmpxchg) to allow the new options, but
defaulting to the existing (full barrier) implementations if the arch
doesn't provide an alternative. Weird things like dec_if_positive could
be left alone (i.e. not implemented) for now.

The hard part is defining the semantics of these new flavours. Do we want
SC acquire/release (i.e. what we have on arm64) or PC acquire/release (i.e.
what we have in C11)? For architectures building these constructs out of
barrier instructions, the former requires an additional barrier following
a release operation so that it is ordered against a subsequent acquire.

Another potential problem of defining things this way is cmpxchg_acquire
potentially giving relaxed semantics if the comparison fails (different
to C11, iirc).

Anyway, clearly a separate series. Should keep me busy...

Will
