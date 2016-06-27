From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jun 2016 10:45:52 +0100
Subject: BUG?: kernel does not (re)set irq smp_affinity to reboot_cpu
In-Reply-To: <5770EE21.90103@arm.com>
References: <4dc8bd4c-8456-9f94-b7eb-c5d227ddc673@redhat.com>
 <5770EE21.90103@arm.com>
Message-ID: <20160627094552.GE1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 10:13:05AM +0100, Marc Zyngier wrote:
> I'm wondering if that's not an effect of this patch:
> 
> https://lkml.org/lkml/2015/9/24/138
> 
> missing on the ARM side (the corresponding arm64 patch is 217d453d473c).

No, because we don't take the other CPUs offline through CPU hotplug at
reboot - we stop them.  That's because CPU hotplug involves scheduling,
and a reboot can't be scheduled as it can happen from IRQ contexts.

For a long time, we have not supported IRQs on any CPU after the system
has gone down for halt/reboot/poweroff etc:

ipi_cpu_stop() disables IRQs and FIQs before entering an infinite loop.
machine_{halt,power_off,restart}() in arch/arm/kernel/reboot.c disables
IRQs on the requesting CPU.

So, IRQs get disabled on _all_ CPUs.  Code after this point should not
re-enable IRQs to be able to use drivers, which it sounds like what's
happening in Hans scenario.  Remember, as I've said above, these paths
should not even be scheduling, and should never be reliant on receiving
interrupts.  *Especially* as they can themselves be called from IRQ
context.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
