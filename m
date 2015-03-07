From: gradator@gradator.net (Sylvain Rochet)
Date: Sat, 7 Mar 2015 11:20:56 +0100
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <20150307091846.GN23367@worktop.ger.corp.intel.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
 <20150305105308.GA13617@leverpostej>
 <20150305121723.1da0d016@bbrezillon>
 <20150305115307.GA14093@leverpostej>
 <20150307091846.GN23367@worktop.ger.corp.intel.com>
Message-ID: <20150307102056.GA28436@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Mar 07, 2015 at 10:18:46AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 05, 2015 at 11:53:08AM +0000, Mark Rutland wrote:
> > If everyone else is happy with this using IRQF_NO_SUSPEND for now then
> > don't let my comments above block this patch.
> 
> Yeah, I'm really not happy with NO_SUSPEND + enable_irq_wake().
> 
> I really want that combo to BUG/WARN -- esp. since there's so much cargo
> culted crap out there.
> 
> We should make robust interfaces, not randomly toggle flags until it
> mostly works by accident rather than by design -- which is what this
> feels like.
> 
> And while I appreciate the watchdog use-case; I think the easiest
> solution for now is to simply disable the wathdog over suspend until
> we've come up with something that makes sense.
> 
> As it is, you need to 'suspend' the watchdog at some point anyhow; you
> don't want that thing to wake you from whatever suspend state you're in.

The Atmel watchdog can't be stopped once it's started. This is actually 
very useful so we can reset if suspend or resume failed, the only 
drawback is that you have to wake up from time to time (e.g. by using 
the RTC/RTT) to clear the watchdog and then go back to sleep ASAP.

I am working on safety products and keeping the watchdog running 
whatever the state is almost mandatory, one of the test on those 
products is about unsoldering all the crystals live from your product 
and the product should detect the general fault and power on a buzzer 
and a yellow fault LED. This is usually done with a watchdog clocked 
from an internal RC of the ?C/SoC (so it can't be unsoldered ;-) and a 
GPIO with a reset state in input/pull-up, the device clamps the GPIO to 
ground, if the watchdog resets the system the GPIO is going to switch 
back to input therefore changing its state.

This can of course be done with an external watchdog circuitry, but it 
costs more and will consume much more than using ? 1 ?A RC 
oscillator/watchdog already present in the ?C/SoC.

Sylvain
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150307/f820bc1a/attachment-0001.sig>
