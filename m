From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Jul 2014 23:38:15 -0700
Subject: [PATCH 00/12] Add NVIDIA Tegra FUSE driver
In-Reply-To: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140713063815.GA24843@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 02:15:59PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This series is an extension of Peter's original series to add a proper
> driver for the FUSE block on Tegra.
> 
> Patches 1 and 2 are preparatory work that cleans up include lists and
> introduces a function to query the Tegra chip ID rather than accessing
> a simple variable. This is used by subsequent patches to allow us to
> execute code when the variable is accessed to help in pin-pointing
> locations where it's accessed before the driver had a chance to
> initialize.
> 
> Patches 3 through 8 are Peter's series with a fixup patch by Stephen. I
> also moved the driver to drivers/soc/tegra/fuse as requested by Olof.
> 
> Patches 9 and 10 defer usages of the tegra_get_chip_id() function to a
> later stage (pure_initcall). This allows patch 11 to set up the early
> FUSE support code from an early initcall. This has the advantage of not
> requiring an explicit call from SoC setup code in arch/arm/mach-tegra
> and will allow the code to be shared on 64-bit variants of Tegra.
> 
> Patch 12 finally turns the PMC and powergate support code into a proper
> driver which also sets up a minimal environment from an early initcall.
> The driver isn't moved out of arch/arm/mach-tegra yet because people
> have suggested drivers/power as a good home, but that whole directory
> depends on the POWER_SUPPLY Kconfig symbol yet this driver doesn't have
> anything to do with that. Once that debate has been settled the driver
> can easily be moved out in a separate patch.
> 
> Some of the patches in this series introduce diagnostic WARN() messages
> if functions are called without setup having completed. I've booted the
> v3.16-rc1 kernel with these changes on top on Tegra20 (TrimSlice),
> Tegra30 (Beaver), Tegra114 (Dalmore) and Tegra124 (Jetson TK1) without
> encountering any of the diagnostic warnings and without noticing any
> breakage.
> 
> Olof, this series should address the concerns you expressed after
> reviewing Stephen's earlier pull request for Peter's FUSE driver series.
> It would be great if you could take another look to see if this is more
> according to your taste. I'll see if I can take this through linux-next
> for a little and if you have no objections will submit another pull
> request next week.

I haven't looked at all the patches in detail yet, but I do like
the approach in general. I've also applied and pushed them out for
build+test here, but they're queued behind a couple of other builds
so I won't have it until morning (you can poll for boot logs at
arm-soc.lixom.net/bootlogs/misc/v3.16-rc4-371-g2c9d948 if you want to
preempt me).

> Peter De Schrijver (5):
>   ARM: tegra: export apb dma readl/writel

I thought I saw a patch from Peter that moved the apbio read code to
the fuse driver since there are no other consumers. I think that's a
reasonable thing to do.


-Olof
