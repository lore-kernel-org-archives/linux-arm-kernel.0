From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Jun 2013 17:37:32 +0100
Subject: [Question] race between spin_lock and spin_unlock
In-Reply-To: <CACVXFVNgONa79n+7Bg4p4Fx568XaK6gy+L9tCrP=CmOGwKY7ig@mail.gmail.com>
References: <CACVXFVMBL5E5SGwDatn_ay0sPOhqPKTwouCbzjwrhPuRKHNDcg@mail.gmail.com>
 <20130624154357.GB25582@mudshark.cambridge.arm.com>
 <CACVXFVNgONa79n+7Bg4p4Fx568XaK6gy+L9tCrP=CmOGwKY7ig@mail.gmail.com>
Message-ID: <20130624163732.GC25582@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 05:04:37PM +0100, Ming Lei wrote:
> On Mon, Jun 24, 2013 at 11:43 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> Any comments on the problem?
> >
> > Not sure I see the problem -- the sev guaranteed by the unlock is pended on
> > the core doing the lock by setting the event register, so you can't miss it.
> > The wfe will acknowledge the event (by clearing the event register) but it
> > won't actually wait.
> 
> If so, looks I am afraid too much, :-)
> 
> Also I have another question, if two sev() comes from two cores, then the
> wfe() in one core will acknowledge both the two sev()? or one wfe() only
> acks one sev()?

Events do not compose, so you can only have one event pending at a time,
which the wfe will clear.

> If the wfe() in one core may acknowledge two sev(), the above problem
> might still exists.

You mean, if you had two CPUs spinning on a lock held by a third CPU? In
this case, the third CPU would have to release the lock, then one of the
waiters would have to acquire it, complete its critical section and finally
release it before the other waiter had executed its wfe (about three
instructions)...

I don't think we need to worry about that in practice, unless you have
another example?

Will
