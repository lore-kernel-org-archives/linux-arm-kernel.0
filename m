From: dianders@chromium.org (Doug Anderson)
Date: Wed, 17 Oct 2018 11:24:49 -0700
Subject: [PATCH 2/2] irqchip/gic-v3: Loudly complain about the use of
 IRQ_TYPE_NONE
In-Reply-To: <20180316145511.28362-3-marc.zyngier@arm.com>
References: <20180316145511.28362-1-marc.zyngier@arm.com>
 <20180316145511.28362-3-marc.zyngier@arm.com>
Message-ID: <CAD=FV=XmiOh0Mg0f4a=W0NCH8eb--OQhP2jNAv2ZMpUBOn9n6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 16 Mar 2018 at 11:02 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> There is a huge number of broken device trees out there. Just
> grepping through the tree for the use of IRQ_TYPE_NONE in conjunction
> with the GIC is scary.
>
> People just don't realise that IRQ_TYPE_NONE just doesn't exist, and
> you just get whatever junk was there before. So let's make them aware
> of the issue.

I'm late to the party here and this patch has already landed.

I'm a bit curious.  You say "you just get whatever junk was there
before", I think you're implying that if you specify "IRQ_TYPE_NONE"
in the device tree then you'll be left with whatever the default
trigger was: either however the hardware was initted or how the
bootloader left it.

...but from my recollection that's not the case and someone from stack
overflow seems to have nicely documented how I think this works:

https://stackoverflow.com/questions/40011799/mapping-device-tree-interrupt-flags-to-devm-request-irq

Specifically it's my understanding that the irq_flags in the device
tree rarely have any impact on reality because most drivers specify
how they want the interrupt configured anyway.  The device tree flags
will only ever be used if the client code didn't specify.


Assuming my understanding is correct, then I guess it calls into
question a bit the requirement that the device tree _must_ specify the
IRQ trigger type.  For the most part the code know (and needs to know)
what the IRQ trigger type is.  In cases where the code is really
generic (like an i2c device) and needs to run on lots of platforms
where not all triggers might be available, it's nice if the trigger
type _can_ be specified in the device tree, but does it need to be
mandatory?


Downsides of forcing everyone to start specifying their trigger type
in the device tree:

* There's no double-checking.  You can totally put something bogus
there and it will have no impact on your system whatsoever.  AKA I
just changed a whole pile of defines in my device tree from
IRQ_TYPE_LEVEL_HIGH to IRQ_TYPE_LEVEL_LOW and it had no impact on my
system.  That's because the drivers all passed "IRQF_TRIGGER_HIGH" to
request_irq.

* Developers will think that they can change the value in the device
tree and it will have an effect.  It won't.


-Doug
