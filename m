From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jul 2018 16:52:01 +0100
Subject: [PATCH v4 1/6] driver core: allow stopping deferred probe after
 init
In-Reply-To: <20180709154153.15742-2-robh@kernel.org>
References: <20180709154153.15742-1-robh@kernel.org>
 <20180709154153.15742-2-robh@kernel.org>
Message-ID: <20180709155201.GG17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 09:41:48AM -0600, Rob Herring wrote:
> Deferred probe will currently wait forever on dependent devices to probe,
> but sometimes a driver will never exist. It's also not always critical for
> a driver to exist. Platforms can rely on default configuration from the
> bootloader or reset defaults for things such as pinctrl and power domains.
> This is often the case with initial platform support until various drivers
> get enabled. There's at least 2 scenarios where deferred probe can render
> a platform broken. Both involve using a DT which has more devices and
> dependencies than the kernel supports. The 1st case is a driver may be
> disabled in the kernel config. The 2nd case is the kernel version may
> simply not have the dependent driver. This can happen if using a newer DT
> (provided by firmware perhaps) with a stable kernel version. Deferred
> probe issues can be difficult to debug especially if the console has
> dependencies or userspace fails to boot to a shell.
> 
> There are also cases like IOMMUs where only built-in drivers are
> supported, so deferring probe after initcalls is not needed. The IOMMU
> subsystem implemented its own mechanism to handle this using OF_DECLARE
> linker sections.
> 
> This commit adds makes ending deferred probe conditional on initcalls
> being completed or a debug timeout. Subsystems or drivers may opt-in by
> calling driver_deferred_probe_check_init_done() instead of
> unconditionally returning -EPROBE_DEFER. They may use additional
> information from DT or kernel's config to decide whether to continue to
> defer probe or not.
> 
> The timeout mechanism is intended for debug purposes and WARNs loudly.
> The remaining deferred probe pending list will also be dumped after the
> timeout. Not that this timeout won't work for the console which needs
> to be enabled before userspace starts. However, if the console's
> dependencies are resolved, then the kernel log will be printed (as
> opposed to no output).

So what happens if we have a set of modules which use deferred probing
in order to work?

For example, with sound stuff built as modules, and auto-loaded in
parallel by udev, the modules get added in a random order.  The
modules have non-udev obvious dependencies between them (resource
dependencies) which result in deferred probing being necessary to
bring the device up.

Eg,

snd_soc_kirkwood_spdif module declares the ASoC card.
snd_soc_spdif_tx is a codec as a loadable module.
snd_soc_kirkwood is the CPU digital audio interface module.

What I commonly see is this module load order:

snd_soc_kirkwood_spdif, then snd_soc_kirkwood and then snd_soc_spdif_tx.

This results at boot in:

kirkwood-spdif-audio audio-subsystem: ASoC: CPU DAI kirkwood-fe not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CPU DAI kirkwood-fe not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CPU DAI kirkwood-fe not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CPU DAI kirkwood-fe not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CPU DAI kirkwood-fe not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CODEC DAI dit-hifi not registered
kirkwood-spdif-audio audio-subsystem: ASoC: CODEC DAI dit-hifi not registered
kirkwood-spdif-audio audio-subsystem: snd-soc-dummy-dai <-> kirkwood-fe mapping ok
kirkwood-spdif-audio audio-subsystem: multicodec <-> kirkwood-spdif mapping ok

at boot, where most of these are deferred probe attempts.

So, disabling deferred probing after all the kernel-internal initcalls
are run is wrong.  You can have deferred probing required due to
external modules, and this can kick in at any time (think about
hot-pluggable hardware with a driver that's somehow componentised,
like an audio device...)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
