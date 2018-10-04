From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Oct 2018 17:49:12 +0100
Subject: [RFC 1/2] reboot: Make restart_handler_list a blocking notifier
 chain.
In-Reply-To: <20181004162339.19493-2-nicolas.cavallari@green-communications.fr>
References: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
 <20181004162339.19493-2-nicolas.cavallari@green-communications.fr>
Message-ID: <20181004164911.GD30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 06:23:38PM +0200, Nicolas Cavallari wrote:
> Many users of restart_handlers are sleeping in their callbacks.  Some
> are doing infinite loops or calling driver code that may sleep or
> perform operation on slow busses, like i2c.
> 
> This is not allowed in an atomic notifier chain, which is what
> restart_handler_list currently is, so use a blocking notifier chain
> instead.

This isn't going to work.

For example, sysrq processing (which can happen in IRQ context) calls
emergency_restart() for the reboot sysrq.  That calls through to
machine_restart(), which then calls do_kernel_restart().

If do_kernel_restart() sleeps, then we're trying to sleep in IRQ
context, and that's a no no.  I'm afraid you can't just add an irq
enable and change the notifier list to be atomic - and, as you're
making the change in generic code, this affects everyone, not just the
architecture that happens to be in front of you (so if it were merged,
you're likely to get a lot of bug reports!)

It gets worse, because (eg) a panic() or IRQ can happen with any locks
held - and if the I2C device's locks are held when one of those events
happen, you have a deadlock situation (hence you won't reboot!)

I suppose a good first step would be for us to have our own
machine_emergency_restart() on ARM, to separate the atomic paths
from the non-atomic paths, so that those who need to talk to an I2C,
that can happen from the non-atomic path (which means things like
/sbin/reboot will work) but other stuff (eg, restart on panic, sysrq,
soft-watchdog) will fail.

This issue as come up recently surrounding PMIC issues, but the
discussions there appear to have completely dried up...

However, my conclusion is that having an I2C driver deal with reboot
is possible for the process-induced reboot cases, but it's never going
to work reliably for the emergency case.

If you want the emergency case to work, then you need to work out some
way to talk on the I2C bus without involving any locks and with the I2C
bus possibly mid-transfer - which is not an easy problem to solve.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
