From: will.deacon@arm.com (Will Deacon)
Date: Sun, 22 Jan 2012 12:54:11 +0000
Subject: [PATCH] ARM: ux500: Initialize irq affinity
In-Reply-To: <20120120174456.GB11845@n2100.arm.linux.org.uk>
References: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
 <20120120130310.GO1068@n2100.arm.linux.org.uk>
 <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
 <20120120174456.GB11845@n2100.arm.linux.org.uk>
Message-ID: <20120122125411.GA27821@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jan 20, 2012 at 05:44:57PM +0000, Russell King - ARM Linux wrote:
> | So, we have to choose a CPU to route the IRQ to from the mask being
> | requested - and the requested mask may contain anything from a single CPU
> | to multiple CPUs.
> | 
> | We choose to route it to the first online CPU in the set.  That fits with
> | the model, and does not require us to report back which CPU it's currently
> | routed to.  Indeed, architectures such as x86 can't tell you which CPU
> | the next interrupt will hit.
> | 
> | So we shouldn't even try to do this on ARM.  Yes, we end up with all IRQs
> | targetting CPU0 at boot, and with the masks showing 'all CPUs' but that's
> | not a problem.  Really not a problem.

I think this *could* be a problem if, as in Linus's case, some interrupts
have a hardcoded affinity enforced by the hardware (i.e. there are sticky bits
in the GIC distributor CPU targets registers). If we boot on a CPU that is
different from the hardcoded affinity, we could end up initialising an
interrupt with multiple targets. I suspect this will just lead to spurious
interrupts at the end of the day, but there's a potential performance impact
too.

So we could change gic_dist_init to ignore interrupts with sticky bits when
setting up the targets (assuming that the hardcoded target is limited to a
single CPU...) although we also need a way to prevent those interrupts being
moved later on.

For the time being we can just limit ux500 to booting on (physical) CPU 0
and wait and see if anybody hardcodes their targets to point at secondary
CPUs in the future.

Will
