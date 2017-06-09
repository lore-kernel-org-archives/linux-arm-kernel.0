From: slash.tmp@free.fr (Mason)
Date: Fri, 9 Jun 2017 17:20:18 +0200
Subject: Drivers taking different actions depending on sleep state
Message-ID: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I read the "Sleep States" documentation:
https://www.kernel.org/doc/Documentation/power/states.txt

It mentions /sys/power/mem_sleep but I don't have that in 4.9
# ll /sys/power/
-rw-r--r--    1 root     root          4096 Jan  1 00:31 pm_async
-rw-r--r--    1 root     root          4096 Jan  1 00:31 pm_freeze_timeout
-rw-r--r--    1 root     root          4096 Jan  1 00:31 state
-rw-r--r--    1 root     root          4096 Jan  1 00:31 wakeup_count

# cat /sys/power/state 
freeze mem

Currently my platform's "mem" is a true suspend-to-RAM trigger,
where drivers are supposed to save their state (register values
will be lost), then Linux hands control over to firmware which
enables RAM self-refresh and powers the chip down. When the system
resumes, drivers restore their state from their copy in memory.

One driver is responsible for loading/unloading microcode running
on the DSPs. This operation is required only when powering down
the chip, but it should be avoided for "low-latency" sleeps.

The problem is that, if I understand correctly, drivers have no way
of knowing which sleep state is being entered/exited?

How can I have the microcode driver take different decisions
based on the sleep state?

Regards.
