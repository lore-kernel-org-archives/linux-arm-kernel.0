From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jun 2013 09:36:30 +0100
Subject: OMAP4430 failure to boot
In-Reply-To: <20130619064307.GV5523@atomide.com>
References: <20130618183424.GD2718@n2100.arm.linux.org.uk>
 <20130619064307.GV5523@atomide.com>
Message-ID: <20130619083630.GI2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 11:43:07PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [130618 11:40]:
> > So... the boot and build system last night managed to build its kernels
> > after I dropped a couple of patches from my kernel, but we've gone from
> > having both the 3430LDP and 4430SDP booting to only the 3430LDP.
> > 
> > Something has broken 4430SDP during the last week, and so far I've no
> > idea what.  The 4430 seems to be utterly immune to any kind of debugging.
> > It:
> > 
> > (a) doesn't produce any decompressor output because its part of the
> > multiplatform kernel.  This means I've no idea if the decompressor is
> > working or not.
> > 
> > (b) doesn't produce any output from the kernel via the use of printch()
> > in the early assembly, nor via adding printascii() into printk().
> > 
> > Will has tested v3.10-rc6, and that works.  Will tested v3.10-rc6 plus
> > arm-soc for-next, and got:
> > 
> > 	Error: unrecognized/unsupported machine ID (r1 = 0x00000ae7).
> 
> It's because it's DT only. I guess we could have some minimal generic
> file handling that machine ID to produce an error to avoid having
> to debug things?
> 
> If you have arm-soc for-next, omap4 is now DT only. So you have to
> have CONFIG_ARM_APPENDED_DTB=y, CONFIG_ARM_ATAG_DTB_COMPAT=y and
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y and append the .dtb to
> zImage to boot. Or you can also update u-boot to pass the .dtb.
> There are more accurate instructions in arm-soc commit b42b9181.
> 
> Moving omap4 to be DT only has been about 5900 lines of reduced data
> and code so far, so that's a good reason for doing it. Most things
> should work as earlier, except for the pandaboard EHCI is still missing
> a fix for adding a clock alias for the auxclk. If there are things not
> working, they should be quite easy to fix.

Right, so as I said I'm taking OMAP4 out of the build/boot test system,
which can't currently cope with jumping through the hoops to get DT to
work.

And since no one tells me anything about where to get updated uboots from
for TI's boards, I'm not about to play boot loader roulette trying to
build my own.
