From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Mar 2014 20:02:34 +0000
Subject: [arm arch] local_irq_restore() does not play well with
 local_fiq_enable()
In-Reply-To: <op.xc1dkcblfh00o9@enterprised.lan>
References: <op.xc1dkcblfh00o9@enterprised.lan>
Message-ID: <20140320200233.GC7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 07:54:02PM +0000, Jonathan Bell wrote:
> hcd_init:
> 	setup the FIQ state
> 	install the fiq handler
> 	enable_fiq(USB)
> 	local_fiq_enable()
> 	usb_add_hcd()

You're not supposed to use local_fiq_enable() to enable FIQs in a device
driver - they should already be enabled by this point.

There has been a hole in that where FIQs haven't been enabled in the
idle thread, but that's a bug which needs fixing.  Otherwise, you should
assume that FIQs are always unmasked everywhere except for any short
code sequences that are contained within a short local_fiq_disable()..
local_fiq_enable() block.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
