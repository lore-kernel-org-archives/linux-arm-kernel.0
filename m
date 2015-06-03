From: robdclark@gmail.com (Rob Clark)
Date: Wed, 3 Jun 2015 17:12:39 -0400
Subject: [PATCH 00/21] On-demand device registration
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAF6AEGuOP-3sxDQcNOjVmfP4ue6LmY7KFrj9W75aHKuvZpTFMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 10:53 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> Hello,
>
> I have a problem with the panel on my Tegra Chromebook taking longer than
> expected to be ready during boot (St?phane Marchesin reported what is
> basically the same issue in [0]), and have looked into ordered probing as a
> better way of solving this than moving nodes around in the DT or playing with
> initcall levels.
>
> While reading the thread [1] that Alexander Holler started with his series to
> make probing order deterministic, it occurred to me that it should be possible
> to achieve the same by registering devices as they are referenced by other
> devices.
>
> This basically reuses the information that is already implicit in the probe()
> implementations, saving us from refactoring existing drivers or adding
> information to DTBs.
>
> Something I'm not completely happy with is that I have had to move the call to
> of_platform_populate after all platform drivers have been registered.
> Otherwise I don't see how I could register drivers on demand as we don't have
> yet each driver's compatible strings.
>
> For machs that don't move of_platform_populate() to a later point, these
> patches shouldn't cause any problems but it's not guaranteed that we'll avoid
> all the deferred probes as some drivers may not be registered yet.
>
> I have tested this on boards with Tegra, iMX.6 and Exynos SoCs, and these
> patches were enough to eliminate all the deferred probes.
>
> With this series I get the kernel to output to the panel in 0.5s, instead of 2.8s.

So, complete drive-by comment (and I won't claim to be a DT expert,
etc, etc, so take this with a few grains of salt), but why not push
the problem to the DT compiler (or a pre-process step that could be
run on existing DT blobs), which generates an optional DT node that is
the recommended probe order?  That seems like it avoids adding
complexity into the early boot code (which seems like a good thing)..

As a bonus, a bootarg (or something like that) which runs through the
recommended probe order in reverse (to continue our current state of
ensuring that EPROBE_DEFER error paths are well tested)

At any rate, for a device like a drm driver that has multiple
sub-components, and depends on various other clk/gpio/regulator/etc
drivers, the current EPROBE_DEFER situation is pretty comical, so any
solution that improves on things is very much welcome :-)

BR,
-R

> Regards,
>
> Tomeu
>
> [0] http://lists.freedesktop.org/archives/dri-devel/2014-August/066527.html
>
> [1] https://lkml.org/lkml/2014/5/12/452
>
> Tomeu Vizoso (21):
>   regulator: core: Reduce critical area in _regulator_get
>   ARM: tegra: Add gpio-ranges property
>   ARM: tegra: Register drivers before devices
>   ARM: EXYNOS: Register drivers before devices
>   ARM i.MX6q: Register drivers before devices
>   of/platform: Add of_platform_device_ensure()
>   of/platform: Ensure device registration on lookup
>   gpio: Probe GPIO drivers on demand
>   gpio: Probe pinctrl devices on demand
>   regulator: core: Probe regulators on demand
>   drm: Probe panels on demand
>   drm/tegra: Probe dpaux devices on demand
>   i2c: core: Probe i2c master devices on demand
>   pwm: Probe PWM chip devices on demand
>   backlight: Probe backlight devices on demand
>   usb: phy: Probe phy devices on demand
>   clk: Probe clk providers on demand
>   pinctrl: Probe pinctrl devices on demand
>   phy: core: Probe phy providers on demand
>   dma: of: Probe DMA controllers on demand
>   power-supply: Probe power supplies on demand
>
>  arch/arm/boot/dts/tegra124.dtsi     |  1 +
>  arch/arm/mach-exynos/exynos.c       |  4 +--
>  arch/arm/mach-imx/mach-imx6q.c      | 12 ++++-----
>  arch/arm/mach-tegra/tegra.c         | 21 ++++++---------
>  drivers/clk/clk.c                   |  3 +++
>  drivers/dma/of-dma.c                |  3 +++
>  drivers/gpio/gpiolib-of.c           |  5 ++++
>  drivers/gpu/drm/drm_panel.c         |  3 +++
>  drivers/gpu/drm/tegra/dpaux.c       |  3 +++
>  drivers/i2c/i2c-core.c              |  3 +++
>  drivers/of/platform.c               | 53 +++++++++++++++++++++++++++++++++++++
>  drivers/phy/phy-core.c              |  3 +++
>  drivers/pinctrl/devicetree.c        |  2 ++
>  drivers/power/power_supply_core.c   |  3 +++
>  drivers/pwm/core.c                  |  3 +++
>  drivers/regulator/core.c            | 45 +++++++++++++++----------------
>  drivers/usb/phy/phy.c               |  3 +++
>  drivers/video/backlight/backlight.c |  3 +++
>  include/linux/of_platform.h         |  2 ++
>  19 files changed, 130 insertions(+), 45 deletions(-)
>
> --
> 2.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
