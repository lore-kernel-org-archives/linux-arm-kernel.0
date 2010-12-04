From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 4 Dec 2010 03:28:49 +0200
Subject: [PATCH v3 0/4] Introduce hardware spinlock framework
In-Reply-To: <4CF98B6F.5050308@caviumnetworks.com>
References: <1291420247-18171-1-git-send-email-ohad@wizery.com>
	<4CF98B6F.5050308@caviumnetworks.com>
Message-ID: <AANLkTinw5KDThsSw+2PJMdrPBq1=rMJNVYgF4z5mEJTM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 4, 2010 at 2:29 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> Does anything other than OMAP4 have one of these things?

I'm not aware of any, but David Brownell had some ideas about it in
our previous v2 discussion (see
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg39413.html).

Btw, you might want to read throughout that entire discussion with
David, since it was touching the same questions you raise here.

> And are there any
> devices that are commonly encountered across more than one platform that
> might have these hardware spinlocks, thus making it advantageous to have a
> common framework?

Such devices are just multiple processors that have no alternative
mechanism to accomplish synchronization.

OMAP4 has a few non-coherent heterogeneous processors that do not
support fancy synchronization primitives, so it needs this hwspinlock
peripheral.

Otherwise, I don't know how common that is (/might become), and I'd
hate speculating, but I suspect that OMAP is not going to be the only
platform with multiple coprocessors, that have no other means of
achieving synchronization, and with which inter-processor
communications is desired.

>
> If not why a general purpose framework for a very chip specific feature?

We started out with an omap-specific driver (see first iteration at
http://lwn.net/Articles/410375/), but were asked to make it a
platform-agnostic framework, in order to keep the IPC drivers that
will use it generic (and assuming that more users will show up for
such framework).

To me it sounds reasonable, but again, I prefer not to speculate how
many users will show up for this, if any.

Both ways (framework / omap-specific driver) will work for us just fine.

>
> There are chips with hardware atomic memory, but the only time it makes
> sense to use it is in conjunction with specialize on-chip devices. ?So the
> implementation details are kept in the drivers rather than creating a
> general purpose hwatomic (with its hwatomic_add() et al.) type.

This case is a bit different IMHO: some of the potential users of
hwspinlocks are just generic IPC drivers that are by no means
platform-specific. It's not a special on-chip device: it's just one
processor, trying to achieve mutual exclusion with another processor,
before manipulating some shared data structure.
