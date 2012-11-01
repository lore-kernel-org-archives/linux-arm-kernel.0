From: bob.beckett@gmail.com (Robert Beckett)
Date: Thu, 1 Nov 2012 17:54:48 +0000
Subject: gic_set_affinity
Message-ID: <CAOmFF10StbsQ6WU6J=MFoM87zgD+XpZqQrr2dLsJHPnW0gVang@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I was looking through the arm gic code while debugging a problem I am
having, and noticed something in gic_set_affinity.

When something comes along and setts an irq affinity mask (e.g.
through /proc/irq/<irq>/smp_affinity_mask), the calls goes like so :

...
1. irq_set_affinity : grabs the desc->lock
2. __irq_set_affinity_locked : calls chip->irq_set_affinity
3. gic_set_affinity : writes a new mask to the gic distributor

my question is, what happens if an interrupt is raised between 1 and 3?
To me, it looks like the interrupt could end up being handled on 2
cpus. When it is raised, the handler will be called and sit spinning
for desc->lock (e.g. in handle_fasteoi_irq). The mask will be set to
set the affinity to the new cpu, the new cpu will receive the
interrupt as it has not been ackd or disabled yet, and the handler
will be called on the second cpu and will wait for the same lock in
the handler. Once the affinity setting calls have finished, the lock
is released, and whichever cpu gets the lock will handle the interrupt
while still locking out the other cpu. Once it finishes, the other cpu
will try to handle it leading to an interrupt handler call for an
interrupt that no longer exists, which could lead to spurious
interrupt if it returns IRQ_NONE because it cant see that the
interrupt is raised.

Is this what will happen? If so, the interrupt should be masked across
the affinity setting so that it cant be raised on both cpus.
if I have just missed something obvious, then please let me know...

Cheers.

Bob
