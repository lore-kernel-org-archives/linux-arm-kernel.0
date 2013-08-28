From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 28 Aug 2013 12:33:52 -0700
Subject: [PATCH v4 1/4] lib: Introduce atomic MMIO modify
In-Reply-To: <20130828102422.GA2348@localhost>
References: <1377358532-23802-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377358532-23802-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827133709.64b4743950b911d6dfe7fab8@linux-foundation.org>
 <20130828102422.GA2348@localhost>
Message-ID: <20130828123352.b9beff5237dfde2571a5779e@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Aug 2013 07:24:23 -0300 Ezequiel Garcia <ezequiel.garcia@free-electrons.com> wrote:

> On Tue, Aug 27, 2013 at 01:37:09PM -0700, Andrew Morton wrote:
> > On Sat, 24 Aug 2013 12:35:29 -0300 Ezequiel Garcia <ezequiel.garcia@free-electrons.com> wrote:
> > 
> > > Some platforms have MMIO regions that are shared across orthogonal
> > > subsystems. This commit implements a possible solution for the
> > > thread-safe access of such regions through a spinlock-protected API.
> > 
> > Seem sensible.  Perhaps.
> > 
> > It only works if both subsystems agree to use atomic_io_modify().  And
> > if they're both capable of doing that, they are both capable of
> > implementing an agreed-upon internal locking scheme, so why bother?
> > 
> 
> One of the scenarios where this could be helpful and an agreed-upon
> lock seemed difficult to design is this: a watchdog driver that shares
> some control register with *two* different clocksource drivers.
> 
> So, one first solution is to have a function in the two clocksource
> drivers (with matching prototype) and have the watchdog access
> the register through it.
> 
> However, because of multiplatform builds, both these clocksource drivers
> could be built at the same time. Therefore we would have a symbol
> collision, doubly-defined, in each driver.
> 
> How would that work? What other internal locking scheme could we
> implement?

I guess the locking would need to be in a standalone module which the
various driver modules would then depend upon.  I'm not really
advocating doing this - I'm just making noise.

> [..]
> > 
> > I disagree with the presence of the ifndef.  If
> > __HAVE_ARCH_ATOMIC_IO_MODIFY is undefined, the architecture must still
> > implement the identical function signature.  The best way to ensure that
> > is to use the same prototype in both cases.
> > 
> 
> I agree, but how can this be done?

Just remove the ifndefs.  Then remove the identical function prototype
from the arm header.
