From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Jan 2012 15:27:10 +0000
Subject: [PATCH] ARM: ux500: Initialize irq affinity
In-Reply-To: <20120122125411.GA27821@mudshark.cambridge.arm.com>
References: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
 <20120120130310.GO1068@n2100.arm.linux.org.uk>
 <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
 <20120120174456.GB11845@n2100.arm.linux.org.uk>
 <20120122125411.GA27821@mudshark.cambridge.arm.com>
Message-ID: <20120122152710.GT1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2012 at 12:54:11PM +0000, Will Deacon wrote:
> I think this *could* be a problem if, as in Linus's case, some interrupts
> have a hardcoded affinity enforced by the hardware (i.e. there are sticky bits
> in the GIC distributor CPU targets registers). If we boot on a CPU that is
> different from the hardcoded affinity, we could end up initialising an
> interrupt with multiple targets. I suspect this will just lead to spurious
> interrupts at the end of the day, but there's a potential performance impact
> too.

If we boot on a CPU which is incapable of receiving interrupts from
attached devices, we have a much larger problem than just affinity.
We potentially can't initialize those devices until their dependent
CPU comes online - we certainly can't start to use those devices until
that happens.

That's something we just don't deal with - and as far as userspace goes,
trying to set an affinity to just the offline CPU will return an error
code.

So, if you have interrupts which can only be serviced by a group of CPUs,
at least one of those CPUs must remain online at all times that those
dependent devices could produce an interrupt.

I think what we want instead is for the IRQ subsystem to record on a
per-IRQ basis which CPUs the interrupt /can/ be routed to, and if:

	affinity & cpus_online & allowable_cpus

becomes empty, the attempt to set the affinity is failed.  Also, a callback
in the hotplug code to error out if

	cpus_online & allowable_cpus & ~offlining_cpu

would become an empty set.
