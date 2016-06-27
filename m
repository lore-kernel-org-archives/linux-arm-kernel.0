From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jun 2016 12:46:21 +0100
Subject: BUG?: kernel does not (re)set irq smp_affinity to reboot_cpu
In-Reply-To: <20160627113143.GF1041@n2100.armlinux.org.uk>
References: <4dc8bd4c-8456-9f94-b7eb-c5d227ddc673@redhat.com>
 <5770EE21.90103@arm.com>
 <20160627094552.GE1041@n2100.armlinux.org.uk>
 <d3a266d3-2cfc-81c7-25a6-b39c8012bcf0@redhat.com>
 <20160627113143.GF1041@n2100.armlinux.org.uk>
Message-ID: <20160627114621.GG1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 12:31:43PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 27, 2016 at 12:55:26PM +0200, Hans de Goede wrote:
> > Hi Russel,

Btw, please take note of how my name is spelt.  Thanks.

> Only if we accept that pm_power_off() should be called with IRQs
> enabled, which we haven't ascertained yet.
> 
> Even on x86, pm_power_off() is generally called with IRQs disabled,
> and more - the APICs are disabled along with the system IOMMU in the
> case of x86_64.  These are only avoided if the reboot mode is set to
> "force" (reboot_force).
> 
> Now, we could do as you are suggesting, and route IRQs to the
> remaining CPU via all shutdown paths, but that would be papering over
> the fundamental bug here: if a function is called with IRQs disabled,
> it (or any called function) has no business re-enabling IRQs.

More to that, the I2C core layer is setup to allow i2c_transfer() to
be called from non-schedulable contexts:

                if (in_atomic() || irqs_disabled()) {
                        ret = adap->trylock_bus(adap, I2C_LOCK_SEGMENT);
                        if (!ret)
                                /* I2C activity is ongoing. */
                                return -EAGAIN;

prior to calling into the adapters ->master_xfer() function.  This
acknowledges that, if i2c_transfer() is called in a context which
is not schedulable or IRQs are disabled, the adapters ->master_xfer()
needs to handle this situation.  This was added by this commit:

commit cea443a81c9c6257bf2d00f1392f7d1d4ce03b75
Author: Mike Rapoport <mike@compulab.co.il>
Date:   Sun Jan 27 18:14:50 2008 +0100

    i2c: Support i2c_transfer in atomic contexts

    Allow i2c_transfer to be called in contexts where sleeping is not allowed.
    It is the reponsability of the caller to ensure that the underlying i2c bus
    driver will not sleep either.

    Signed-off-by: Mike Rapoport <mike@compulab.co.il>
    Signed-off-by: Jean Delvare <khali@linux-fr.org>

So... I wonder if you have CONFIG_DEBUG_ATOMIC_SLEEP set in your kernel
configuration - if not, I suspect if you do enable it, you'll get a
warning from the kernel when trying to power off, pointing out that
there's a problem in the I2C driver sleeping in an invalid context.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
