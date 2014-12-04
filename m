From: stefan@agner.ch (Stefan Agner)
Date: Thu, 04 Dec 2014 14:35:25 +0100
Subject: [PATCH 03/12] irqchip: gic: define =?UTF-8?Q?register=5Frouta?=
 =?UTF-8?Q?ble=5Fdomain=5Fops=20conditional?=
In-Reply-To: <547F5EBD.6040705@arm.com>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-4-git-send-email-stefan@agner.ch>
 <5174649.NxPq80uDz8@wuerfel> <alpine.DEB.2.11.1412031303000.16275@nanos>
 <8eccedc781df2636a132dae449cbe774@agner.ch> <547F5EBD.6040705@arm.com>
Message-ID: <a62b856866915f6939da79bdbcdabb39@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-12-03 20:04, Marc Zyngier wrote:
<snip>
>> What do you mean by the shared state in the drawing above? Currently, I
>> check whether a interrupt is already used by the other core by reading
>> the register (do this configuration register reflect the "shared state"
>> in your drawing?).
> 
> I think that is basically it. It should only be the register that
> decides on the actual routing. BTW, how do you arbitrate between
> concurrent accesses to this register? Or is only the A5 allowed to
> change it?
 
No arbitration so far... The whole Vybrid on M4 stuff is quite a hack
right now. For instance also the concurrent access to the clock
registers is not handled. Currently, I start the M4 from a booted A5
Linux. To avoid half of the clocks get turned of by the M4 clock driver,
I need to specify clk_ignore_unused. Beside that, peripherals have to be
enabled/disabled in a non conflicting manor in the device trees...

For the interrupt router in MSCM, it would be nice if the access could
be done an atomic way, which would avoid the use of a lock mechanism.
But I guess this is not possible, since peripherals only support
standard ldr/str...?

There is the SEMA4 module which provides hardware semaphores. I'm aware
of the hardware spinlock drivers (drivers/hwspinlock/), I started to
implement such a driver for Vybrid. But so far a grep through the kernel
does not show one usage of that framework... I guess we could add dt
support for that, so we can assign the locks to individual drivers.

I also plan to have a deeper look into remoteproc/rpmsg, not sure if
locking of shared peripherals is part (or planned to be part) of that
framework.

For the clock stuff, the problem is more complex: I guess the would need
some kind of master/slave definition, where we disallow the change of
the shared clocks for the slave.

If you are aware of patches/solutions, I'm happy to hear it...

--
Stefan


<snip>
