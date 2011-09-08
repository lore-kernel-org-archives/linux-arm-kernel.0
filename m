From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 08 Sep 2011 17:12:17 +0100
Subject: [PATCH v11 0/4] Consolidating GIC per-cpu interrupts
In-Reply-To: <alpine.LFD.2.02.1109081339120.2723@ionos>
References: <1312883802-15022-1-git-send-email-marc.zyngier@arm.com>
	<20110815121312.GF26827@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1109081339120.2723@ionos>
Message-ID: <4E68E961.8050309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On 08/09/11 14:14, Thomas Gleixner wrote:

> Another thing, which sticks out compared to other percpu interrupt
> users in arch/* is that you provide the ability to assign different
> handlers on different CPUs to a given PPI interrupt number. Most other
> percpu implementations setup the interrupt with a unique percpu aware
> handler and just enable/disable it per core in the low level
> setup/shutdown code. Is running different handlers on different cores
> a real requirement or just a nice feature with no usecase?

At the moment, it sort of falls into the second category. MSM has
"asymmetric" timers (each core has its private timer on a different
PPI), but that doesn't mandate having separate handlers per core, unless
someone decides to connect something on another CPU, using the same
PPI... The architecture would probably allow it.

But a clear requirement we have is that the handler has to be called
with a per-cpu dev_id pointer (we use this to obtain the
clock_event_device in the timer handler, for example). Which makes
having something similar to request_irq() quite the natural thing.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
