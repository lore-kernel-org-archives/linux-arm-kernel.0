From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Jun 2016 23:00:26 +0100
Subject: ARM: mxs: warnings on PM resume
In-Reply-To: <1612475808.97029.eb34fc3a-2c1f-4f24-a990-897dd5df59a5.open-xchange@email.1und1.de>
References: <1713040590.199779.36789782-c361-4fe4-bc0d-b581fbce8069.open-xchange@email.1und1.de>
 <1955365225.76161.cd9a3eda-edc7-4bae-96f3-bdddccbb0478.open-xchange@email.1und1.de>
 <2607020.0FcLMf1DX6@vostro.rjw.lan>
 <908847370.85504.d47d66b7-356b-4e07-9e1d-807a299ea337.open-xchange@email.1und1.de>
 <20160612135428.GR1041@n2100.armlinux.org.uk>
 <1612475808.97029.eb34fc3a-2c1f-4f24-a990-897dd5df59a5.open-xchange@email.1und1.de>
Message-ID: <20160612220026.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 11:45:50PM +0200, Stefan Wahren wrote:
> Hi,
> 
> > Russell King - ARM Linux <linux@armlinux.org.uk> hat am 12. Juni 2016 um 15:54
> > geschrieben:
> > 
> > This isn't about the state of the interrupt controller.  It's about
> > the state of the IRQ mask bit in the CPUs CPSR.
> > 
> > irq_disabled() returns true when the I bit in CPSR is set, false
> > otherwise.
> > 
> > What it's pointing towards is some driver being unreasonable, and
> > clearing the CPUs CPSR I bit after the core PM code has set it.  Causes
> > can be using spin_lock_irq()/spin_unlock_irq()/local_irq_enable() etc
> > inappropriately, rather than using the irqsave/irqrestore versions.
> 
> i finally found the reason for the warning: clk_get_sys was called inside of
> mxs_suspend_enter.
> After moving it into the init function the issue disappear.

Hmm.  I suspect a faster way to have found that issue would be to build
your development kernels with more debugging options enabled - eg,
check that you have DEBUG_ATOMIC_SLEEP enabled.

That should have caught the attempt to take a mutex in an IRQs-disabled
region.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
