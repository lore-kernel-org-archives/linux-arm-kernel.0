From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Feb 2016 21:25:51 +0000
Subject: [arm:for-next 24/31] arch/arm/kernel/hyp-stub.S:168: Error:
 selected processor does not support ARM mode `ubfx r7,r7,#28,#4'
In-Reply-To: <20160217195127.GA4566@e106794-lin.cambridge.arm.com>
References: <201602180044.PcvJbrb9%fengguang.wu@intel.com>
 <20160217195127.GA4566@e106794-lin.cambridge.arm.com>
Message-ID: <20160217212551.GJ19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 07:51:28PM +0000, Jean-Philippe Brucker wrote:
> On Thu, Feb 18, 2016 at 12:26:46AM +0800, kbuild test robot wrote:
> > tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git for-next
> > head:   5aeac3b523644cbc300f17d67c8fce73df9060c0
> > commit: e59941b9b3817c9b1dd6662d903150fe3f3c3b0b [24/31] ARM: 8527/1: virt: enable GICv3 system registers
> > config: arm-allmodconfig (attached as .config)
> > reproduce:
> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout e59941b9b3817c9b1dd6662d903150fe3f3c3b0b
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=arm 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    arch/arm/kernel/hyp-stub.S: Assembler messages:
> > >> arch/arm/kernel/hyp-stub.S:168: Error: selected processor does not support ARM mode `ubfx r7,r7,#28,#4'
> > >> arch/arm/kernel/hyp-stub.S:176: Error: selected processor does not support ARM mode `isb'
> 
> Selected processor being arm1136j-s, it doesn't make sense to build
> hyp-stub.S at all, in my opinion. We should select ARM_VIRT_EXT only
> when CPU_32v6 and lower are deselected (as with LPAE). I realize such a
> change might be too invasive for a fix, so I attached a version of my
> patch that builds for older architectures. If there is no objection, it
> will supersede the previous one.

Well, in order to get to the ubfx instruction, you need the CPU to be
in HYP mode, which these older CPUs aren't going to be.  So, it's safe
to use ubfx here.

The solution to this is to add:

AFLAGS_hyp-stub.o		:=-Wa,-march=armv7

to the makefile so the toolchain will build it for ARMv7 even though
older CPUs are selected.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
