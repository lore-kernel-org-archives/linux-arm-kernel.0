From: broonie@kernel.org (Mark Brown)
Date: Thu, 2 Apr 2015 12:22:31 +0100
Subject: next-20150402 build: 3 failures 18 warnings (next-20150402)
In-Reply-To: <E1YdaYh-0000LL-D5@debutante>
References: <E1YdaYh-0000LL-D5@debutante>
Message-ID: <20150402112231.GQ6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 09:33:03AM +0100, Build bot for Mark Brown wrote:

> Failed defconfigs:
> 	arm64-allmodconfig

For the past few days -next has been failing to build an arm64
allmodconfig due to:

| drivers/built-in.o: In function `tegra124_132_clock_init_post':
| :(.init.text+0x285d8): undefined reference to `tegra_emc_init'

This is triggered by d035fdfa27ac124bc8 (arm64: Add Tegra132 support)
which enables ARCH_TEGRA and ARCH_TEGRA_132_SOC for arm64 which in turn
causes clk-tegra124 to be built on arm64.  That driver relies on
TEGRA124_EMC but that depends on ARCH_TEGRA_124_SOC which is 32 bit
only.

We either need the EMC driver for Tegra132, a stub or some ifdefs.

It also looks like there's an issue if the memory controller driver is
not enabled (which looks to be something that can be controlled by the
user) but I've not checked properly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150402/51438d1a/attachment.sig>
