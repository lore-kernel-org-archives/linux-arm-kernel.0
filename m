From: andrey.warkentin@gmail.com (Andrei E. Warkentin)
Date: Wed, 31 Jul 2013 16:19:13 -0400
Subject: AArch64 arch_spin_unlock not signaling global event?
Message-ID: <CANz0V+6-yk9jWZ1y9zidKFJAhDof9qQR1uAHzsvhwswApMbxUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hiya,

I've noticed the AArch64 arch_spin_unlock is implemented with the
'stlr' instruction.

Shouldn't that be followed by a 'sev'?

The AArch64 ISA doc says this about 'sev' - "A memory transaction
which clears a processor?s global exclusive monitor also implicitly
generates an event for that processor, as held in the Event register
and used by the WFE instruction."

...but 'stlr' is not an exclusive function. So an 'stlr' would not
generate the event. This means that a arch_spin_lock sitting inside
the 'wfe' would not unblock.

I ran into this doing some kernel-less SMP experiments with the
Foundation Model, where two cpus would play 'ping-pong' acquiring the
same lock and releasing it after a delay, letting the other CPU
acquire it. In the case of the Linux kernel, the core running
arch_spin_unlock likely manipulates a dozen other locks afterwards or
performs other activities which result in a global event (clrex, wfe),
or the other core gets an event because of an interrupt (or timer used
as wfe source). This is why I'm guessing no one has run into this yet.

Cheers,
-- 
A
