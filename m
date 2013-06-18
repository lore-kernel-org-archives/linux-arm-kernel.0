From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jun 2013 19:34:24 +0100
Subject: OMAP4430 failure to boot
Message-ID: <20130618183424.GD2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So... the boot and build system last night managed to build its kernels
after I dropped a couple of patches from my kernel, but we've gone from
having both the 3430LDP and 4430SDP booting to only the 3430LDP.

Something has broken 4430SDP during the last week, and so far I've no
idea what.  The 4430 seems to be utterly immune to any kind of debugging.
It:

(a) doesn't produce any decompressor output because its part of the
multiplatform kernel.  This means I've no idea if the decompressor is
working or not.

(b) doesn't produce any output from the kernel via the use of printch()
in the early assembly, nor via adding printascii() into printk().

Will has tested v3.10-rc6, and that works.  Will tested v3.10-rc6 plus
arm-soc for-next, and got:

	Error: unrecognized/unsupported machine ID (r1 = 0x00000ae7).

I've just tested Linus' tip plus my tip, and that failed.  Tried Linus'
tip.  Failed.  Removed the printch()/printascii() hooks, that got Linus'
tip working.  I guess CONFIG_DEBUG_OMAP2UART1 is the wrong option.

And yes, Linus plus my tip also works without printascii.  So that leaves
the questionable case of Linus tip+my tip+arm-soc tip not being bootable
on OMAP4430 but is on OMAP3430.
