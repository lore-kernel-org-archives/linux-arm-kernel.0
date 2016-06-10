From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 10 Jun 2016 15:13:36 +0200
Subject: [PATCH v2 3/3] arm64: spinlock: use lock->owner to optimise
 spin_unlock_wait
In-Reply-To: <20160610124623.GG15668@arm.com>
References: <1465403139-21054-1-git-send-email-will.deacon@arm.com>
 <1465403139-21054-3-git-send-email-will.deacon@arm.com>
 <20160610122520.GC30154@twins.programming.kicks-ass.net>
 <20160610124623.GG15668@arm.com>
Message-ID: <20160610131336.GD30154@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 01:46:23PM +0100, Will Deacon wrote:
> On Fri, Jun 10, 2016 at 02:25:20PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 08, 2016 at 05:25:39PM +0100, Will Deacon wrote:
> > > Rather than wait until we observe the lock being free, we can also
> > > return from spin_unlock_wait if we observe that the lock is now held
> > > by somebody else, which implies that it was unlocked but we just missed
> > > seeing it in that state.
> > > 
> > > Furthermore, in such a scenario there is no longer a need to write back
> > > the value that we loaded, since we know that there has been a lock
> > > hand-off, which is sufficient to publish any stores prior to the
> > > unlock_wait.
> > 
> > You might want a few words on _why_ here. It took me a little while to
> > figure that out.
> 
> How about "... because the ARM architecture ensures that a Store-Release
> is multi-copy-atomic when observed by a Load-Acquire instruction"?

Yep, that works.

> > Also; human readable arguments to support the thing below go a long way
> > into validating the test is indeed correct. Because as you've shown,
> > even the validators cannot be trusted ;-)
> 
> Well, I didn't actually provide the output of a model here. I'm just
> capturing the rationale in a non-ambiguous form.

the litmus tests captures the problem statement, not the rationale for
the outcome.

> > > The litmus test is something like:
> > > 
> > > AArch64
> > > {
> > > 0:X1=x; 0:X3=y;
> > > 1:X1=y;
> > > 2:X1=y; 2:X3=x;
> > > }
> > >  P0          | P1           | P2           ;
> > >  MOV W0,#1   | MOV W0,#1    | LDAR W0,[X1] ;
> > >  STR W0,[X1] | STLR W0,[X1] | LDR W2,[X3]  ;
> > >  DMB SY      |              |              ;
> > >  LDR W2,[X3] |              |              ;
> > > exists
> > > (0:X2=0 /\ 2:X0=1 /\ 2:X2=0)
> > > 
> > > where P0 is doing spin_unlock_wait, P1 is doing spin_unlock and P2 is
> > > doing spin_lock.
> > 
> > I still have a hard time deciphering these things..
> 
> I'll nail you down at LPC and share the kool-aid :)

hehe; so I can more or less parse them, its just that it doesn't come
natural to me, and I keep forgetting ARM asm which doesn't help.
