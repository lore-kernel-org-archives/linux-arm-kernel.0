From: treding@nvidia.com (Thierry Reding)
Date: Thu, 2 Apr 2015 15:50:05 +0200
Subject: next-20150402 build: 3 failures 18 warnings (next-20150402)
In-Reply-To: <20150402112231.GQ6023@sirena.org.uk>
References: <E1YdaYh-0000LL-D5@debutante> <20150402112231.GQ6023@sirena.org.uk>
Message-ID: <20150402135003.GA27011@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 12:22:31PM +0100, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Apr 02, 2015 at 09:33:03AM +0100, Build bot for Mark Brown wrote:
> 
> > Failed defconfigs:
> > 	arm64-allmodconfig
> 
> For the past few days -next has been failing to build an arm64
> allmodconfig due to:
> 
> | drivers/built-in.o: In function `tegra124_132_clock_init_post':
> | :(.init.text+0x285d8): undefined reference to `tegra_emc_init'
> 
> This is triggered by d035fdfa27ac124bc8 (arm64: Add Tegra132 support)
> which enables ARCH_TEGRA and ARCH_TEGRA_132_SOC for arm64 which in turn
> causes clk-tegra124 to be built on arm64.  That driver relies on
> TEGRA124_EMC but that depends on ARCH_TEGRA_124_SOC which is 32 bit
> only.

It's actually triggered by a newer patch (f8fd257fabf0 "clk: tegra: Add
EMC clock driver") which adds this new dependency.

> We either need the EMC driver for Tegra132, a stub or some ifdefs.

Tegra132 uses the same memory controller as Tegra124, so clk-emc should
work on both. I likely overlooked this when applying the patches. I also
have a local patch for this that I haven't pushed yet. Will do it right
away.

> It also looks like there's an issue if the memory controller driver is
> not enabled (which looks to be something that can be controlled by the
> user) but I've not checked properly.

I'll do some testing to see if I can break it by permutating some of the
Kconfig symbol combinations.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150402/4fd6b394/attachment.sig>
