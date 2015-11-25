From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2015 18:37:28 +0000
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151125160937.GJ14338@lunn.ch>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <20151125160937.GJ14338@lunn.ch>
Message-ID: <20151125183728.GO8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 05:09:37PM +0100, Andrew Lunn wrote:
> Russell, you are the last known user of mach-dove. What are your
> plans? You keep saying you have given up trying to mainline your Cubox
> patches. Have you really given up? Can we remove mach-dove?

Right now, I'm developing etnaviv in spare time on the Cubox[*], which
is still primarily running a non-DT kernel.

It's actually a kernel that I've hacked which is capable of booting
both DT and non-DT, but even when booted in DT mode, I still require
much of the arch/arm/mach-dove infrastructure to get things like
armada-drm, etnaviv and other drivers running.  Especially because
we're missing things like the high-speed clocks (the stuff above the
tclk domain.)  I've not even started to work out how to get that
into mainline, or how to integrate that with CCF.  Quite what can be
done with the audio patches, I've no idea, that remains a bone of
contention and stalemate, and currently isn't DT-able.  See the list
of patches at the end of this message...

It feels today like I'm the only one working on improving Dove support,
and so it's going to take a _long_ time to move things forward - it's
likely to take years.  I have many demands on my time and I have to
divide it up between the various aspects.

Eg, it's taken me a whole year to get the second batch of patches for
the component helper out the door... most of the time I can't see the
trees for all the patches I'm carrying.

* - I'm fed up with waiting for etnaviv to mature; I've been waiting
two years so far in the hope that others will do the work and finally
provide everyone with a solution to the closed source userspace blob.
Consequently, I don't have much time to push Dove stuff forwards right
now - though it can be argued that etnaviv _is_ pushing Dove forwards.
Omitting historical galcore and current etnaviv patch sets, I have 115
patches for Cubox support outstanding.

Note: some of those 115 patches have been merged during the 4.4 merge
window (eg, the tda998x changes and armada drm changes) though I won't
be in a position to know what the new state of affairs are until after
4.4 has been released - where upon I will (as normal) rebase my entire
cubox patch set on the next released kernel.

Patch list (merges omitted)

ARM: orion: implement ARM delay timer
orion clock build fix
clk-si5351 build fix
tda998x: add cec support
cec: add tda9950 driver
cec: add HDMI CEC input driver
cec: add HDMI CEC core driver
ARM: dove: cubox-setup: add gpio table for tda998x calibration
ARM: dove: more clock cleanups
misc updates
Revert "cma debugging"
cma debugging
drm/armada: allow the primary plane to be disabled
drm: tda998x: legacy IRQ handling
enable pm domain debug
rtc: debugging
pmu: debugging
dtbsinstall: don't move target directory out of the way
mmc: hack around broken probe cleanup
ARM: add trivial IRQ handler timing debug
ARM: cubox: dt updates
ASoC: sound fixes
ARM: dove: cubox: add DT booting support
ARM: dove: cubox: add legacy Armada DRM device
ARM: dove: add Etnaviv/DRM support
ARM: dove: add VMeta support
ARM: dove: add BMM support
ARM: dove: move hwmon initialisation into PMU driver
ARM: dt: cubox: add LCD controller and TDA998x configuration
ARM: dove: add DT VMeta support
ASoC: kirkwood: cobble together audio support when DT is enabled
ASoC: kirkwood-i2s: align with mainline
ASoC: kirkwood: cobble together audio support when DT is enabled
ASoC: kirkwood: add DPCM support
ASoC: kirkwood: add spdif driver
ASoC: kirkwood: add SPDIF controls
ASoC: kirkwood: shut down external clock when not required
ARM: cubox: ensure that we indicate full regulator constraints
ARM: l2c: tauros2: fix OF-enabled non-DT boot
ARM: mvebu: allow mvebu/dove to be enabled
ARM: dove: sil clock driver build patch
ARM: dove: remove silab* files
ARM: enable SG_CHAIN for Dove
ARM: cubox: fix flash type
ARM: dove: remove cubox_extclk device
ARM: dove: clock improvements
ARM: dove: drop old vmeta power handling
ARM: dove: fix dove clock support to recalculate the actual rates
ARM: dove: cleanup dove clock support
ARM: dove: fix clock name
ARM: dove: no need for empty clock enable/disable methods
ARM: dove: remove unused clock declarations
ARM: dove: fix 'addr' types in dove clock.c
HWMON: dove: fix use if S_IRWXUGO in dove hwmon driver
HWMON: move dove hwmon module to drivers/hwmon and add MODULE_ALIAS
HWMON: dove: fix mask writes
HWMON: dove: move current_mode and warning_flag into dovetemp_data
HWMON: dove: push dovetemp_data down into functions
HWMON: dove: move timer to dovetherm_data structure
HWMON: dove: add driver private data
HWMON: dove: use module_platform_driver in dove hwmon driver
HWMON: dove: fix monitoring printks
Revert "Allow ioremap_nocache on PJ4 processor that is in Dove."
ARM: dove: convert legacy dove to PMU support
dt-bindings: add Marvell PMU documentation
VMeta: add miscdevice VMeta driver
drm/i2c: tda998x: add temporary audio configuration
drm/i2c: tda998x: add debug
drm: ensure fbdev helper arrays are appropriately dimensioned
drm/armada: start of MMP2/MMP3 support
ARM: imx6: add power domains to Vivante GPU nodes
ARM: imx6: add Vivante GPU nodes
drm/armada: move frame wait wakeup into plane work
drm/armada: convert overlay plane vbl worker to a armada plane worker
drm/armada: move CRTC flip work to primary plane work
drm/armada: move frame wait into armada_frame
drm/armada: move the locking for armada_drm_vbl_event_remove()
drm/armada: move the update of dplane->ctrl0 out of spinlock
drm/armada: move write to dma_ctrl0 to armada_drm_crtc_plane_disable()
drm/armada: provide a common helper to disable a plane
drm/armada: allocate primary plane ourselves
drm/armada: add primary plane creation
drm/armada: introduce generic armada_plane struct
drm/armada: update armada overlay to use drm_universal_plane_init()66377efa3fd4 drm/armada: use xchg() to atomically update dplane->old_fb
drm/i2c: tda998x: clean up after struct tda998x_priv2 removal
drm/i2c: tda998x: kill struct tda998x_priv2
drm/i2c: tda998x: move connector into struct tda998x_priv
drm/i2c: tda998x: remove encoder pointer
drm/i2c: tda998x: remove DRM slave encoder support
drm/armada: factor out retirement of old fb
drm/armada: rename overlay identifiers
drm/armada: redo locking and atomics for armada_drm_crtc_complete_frame_work()
drm/armada: disable CRTC clock during DPMS
drm/armada: use drm_plane_force_disable() to disable the overlay plane
drm/armada: move vbl code into armada_crtc
drm/armada: remove non-component support
drm/i2c: tda998x: use more HDMI helpers
drm/i2c: tda998x: handle all outstanding interrupts
drm/i2c: tda998x: convert to u8/u16/u32 types
drm/i2c: tda998x: re-implement "Fix EDID read timeout on HDMI connect"
drm/i2c: tda998x: report whether we actually handled the IRQ
drm/i2c: tda998x: remove useless NULL checks
of: Add vendor prefix for Vivante Corporation
misc: bmm: update for v4.1 dma_buf API changes
misc: bmm: update for v3.17 dma_buf API changes
misc: add bmm_dmabuf allocator

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
