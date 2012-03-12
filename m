From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Mon, 12 Mar 2012 18:02:04 +0100
Subject: [PATCH] gpio/mxs: support irqs triggered by both edges
In-Reply-To: <20120312163503.AEBC73E07B0@localhost> (Grant Likely's message of
 "Mon, 12 Mar 2012 10:35:03 -0600")
References: <1329745925-7868-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <20120312163503.AEBC73E07B0@localhost>
Message-ID: <lyhaxt4usz.fsf@ensc-virt.intern.sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

>> iMX28 silicon does not support irqs triggered by both gpio edges. Patch
>> emulates this behavior by configuring such irqs as level triggered and
>> by switching polarity in the interrupt handler.
>
> That looks dodgy and hacky.  This will definitely miss interrupts if
> they come in too fast. 

Because patch calculates the trigger from the actual level, there should
not be missed more interrupts than with native edge-both support.

> I don't like this approach.  What do you need it for?

some drivers (e.g. gpio-keys, otg gpio-vbus, gpio-charger) are requesting
gpio based interrupts with IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
flags.  It is not possible to use such drivers without having EDGE_BOTH
support.


Enrico
