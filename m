From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Fri, 3 Dec 2010 14:56:18 +0100
Subject: mpcore watchdogs questions
Message-ID: <4CF8F702.1070502@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have some questions regarding the ARM mpcore watchdogs and the kernel
watchdog API in the case of a Cortex-A9. These local watchdogs
have two properties which appear to make them less well-suited to the
existing framework:

1) Their clocking is tied to that of the cores, in the sense that the WDs are
   unclocked if the interrupt controller is. There's nothing we can do
   about this, but it does mean that they can't be used to watch over a
   sleeping system and therefore that we don't want the user space kicker to
   be driven by a timer which will cause a wake-up - not when power
   management is an issue. In the kernel there are deferred timers to use
   for these cases, but the kicker doesn't live there.

2) They are local to each core, which gives us at least these alternatives:

    * Use only one of them and...
        - set the affinity of the user space kicker to the corresponding core, or
        - let the kicker migrate, but get the message to the correct core in
          kernel space through IPI

    * Use all of them and...
        - One user space kicker per core, or
        - One user space kicker, but with "cyclic affinity", or
        - One user-space kicker, but each kick causes all
          the cores to get the message in kernel space,
          again using IPIs

All of the above assumes these local watchdogs should be shoe-horned into the
existing framework in the first place. Should they? Another alternative is to
somehow use them to watch over the lockup detectors in

    kernel/{softlockup,watchdog}.c

Maybe there are other options as well.

Regards,
Per Fransson
