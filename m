From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 May 2015 21:06:51 +0100
Subject: Versatile Express no-boot with multi-platform kernels
In-Reply-To: <20150509153537.GR2067@n2100.arm.linux.org.uk>
References: <20150509153537.GR2067@n2100.arm.linux.org.uk>
Message-ID: <20150509200651.GW2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 04:35:38PM +0100, Russell King - ARM Linux wrote:
> I've been building an OMAP4 + Versatile Express kernel in the build
> system as a check that there are no incompatibilities between the
> two creeping in.
> 
> However, a while back, Versatile Express stopped booting with this
> configuration _after_ the resolution of the L2 cache latency issue.
> 
> I've been trying to debug it today, but what I find is that if I change
> the LL_DEBUG to the Versatile Express option, and put my printascii()
> hack into kernel/printk/printk.c, it boots.
> 
> I can't say much more than that right now - I tried moving the debug
> output to one of the other ports, but it seems that the other ttyAMA
> ports aren't actually connected to the 9-pin D connectors on the
> chassis (well, the CTS signal appears to be, but not the TX/RX
> signals.)  Port 1 appears to be redirected permanently to one of the
> on-board micros.  Port 3, when set to 38400 baud, receives random
> characters with framing errors from an unknown source.  Port 2 appears
> to do nothing both in the TX and RX directions.
> 
> Having the printascii hack in place but directed to one of the other
> ports also results in a non-booting scenario.
> 
> It seems that printascii() on ttyAMA0 (the console) helps the kernel
> boot.

Okay, I've tried doing a bisect - the breakage happened between v3.19
and v4.0.  I'm running these bisects with a tag latency of <2 2 1>.

Bisect finds that the broken commit is 0be952c13be8:

commit 0be952c13be80ccdd3cb0d1ba25099de9468ac1b
Merge: 9c987a33a864 ec76f4007079
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Mar 14 09:36:10 2015 -0700

    Merge tag 'vfio-v4.0-rc4' of git://github.com/awilliam/linux-vfio

Testing (and re-resting) the three commit IDs reconfirms that individually,
both merge parents work, but the combined result does not.

I'm re-running the bisect to make absolutely sure of this result.  I
don't see how a change to the vfio code would affect this, especially
as drivers/vfio/pci/vfio_pci_intrs.c is not even built.

If it confirms it, then I'm not sure what we do...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
