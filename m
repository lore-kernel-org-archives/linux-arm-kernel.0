From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 May 2015 16:33:06 +0100
Subject: [PATCH 3/6] arm64: tegra: Add Tegra210 support
In-Reply-To: <20150522150514.GD19922@ulmo.nvidia.com>
References: <1431529065-20128-1-git-send-email-thierry.reding@gmail.com>
 <1431529065-20128-3-git-send-email-thierry.reding@gmail.com>
 <20150513171114.GA18655@e104818-lin.cambridge.arm.com>
 <20150515101913.GA20474@ulmo.nvidia.com>
 <20150519145211.GX21251@e104818-lin.cambridge.arm.com>
 <20150519151740.GA28161@ulmo.nvidia.com>
 <20150522133800.GY29424@e104818-lin.cambridge.arm.com>
 <20150522150514.GD19922@ulmo.nvidia.com>
Message-ID: <20150522153306.GA29424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 05:05:16PM +0200, Thierry Reding wrote:
> On Fri, May 22, 2015 at 02:38:00PM +0100, Catalin Marinas wrote:
> > So if you do it properly from the beginning with per-driver Kconfig
> > entry, I no longer see the point of an ARCH_TEGRA_*_SOC option. It may
> > be more convenient for people building end products but they should know
> > better what components are required, defconfig is rarely meant for them.
> 
> Your proposal also means that we'll have to go and add separate Kconfig
> entries for each SoC generation that a driver supports so that the SoC
> specific bits can be disabled.
> 
> So in order to get rid of one per-SoC Kconfig entry you'd prefer us to
> add per-SoC options per driver? Don't you think that's going to make
> things worse rather than improve them?
> 
> There are currently three drivers (off the top of my head) where we do
> this and each of them supports five existing generations plus the new
> Tegra210. So rather than having six symbols to select SoC generation
> support we'd be needing 18, and that's only counting existing drivers.

That's not what I meant. For example, you have a clk-tegra124.c file
built for two SoCs already and there may be more coming. Instead of
multiple obj-y of the same file, just add the entry below to
drivers/clk/tegra/Kconfig:

config CLK_TEGRA124
	bool "NVIDIA Tegra 124 clock"
	depends on ARCH_TEGRA_124_SOC || (ARM64 && ARCH_TEGRA)
	default y
	help
	  Used on Tegra 124, 132 etc.
	  ...

Note that I preserved the 124_SOC dependency for the 32-bit arm case.
But for arm64, just make it dependent on ARCH_TEGRA.

Once done, the Makefile only needs a single entry:

obj-$(CONFIG_TEGRA124) += clk-tegra124.o

-- 
Catalin
