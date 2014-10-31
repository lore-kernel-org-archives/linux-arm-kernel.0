From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 31 Oct 2014 11:32:13 -0700
Subject: [PATCH v7 0/3] ARM: rk3288 : Add PM Domain support
In-Reply-To: <CAD=FV=UzgS2JtNhUB+0gbMvpW76C=12=y+ij0p6Xpbk_vAs0ww@mail.gmail.com>
References: <1414135761-3406-1-git-send-email-jinkun.hong@rock-chips.com>
 <CAD=FV=UzgS2JtNhUB+0gbMvpW76C=12=y+ij0p6Xpbk_vAs0ww@mail.gmail.com>
Message-ID: <20141031183213.GF32331@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 11:03:46AM -0700, Doug Anderson wrote:
> Jinkun,
> 
> On Fri, Oct 24, 2014 at 12:29 AM, jinkun.hong
> <jinkun.hong@rock-chips.com> wrote:
> > From: "jinkun.hong" <jinkun.hong@rock-chips.com>
> >
> > Add power domain drivers based on generic power domain for Rockchip platform,
> > and support RK3288.
> >
> > https://chromium-review.googlesource.com/#/c/220253/9
> > This is the GPU driver, add the following information in DT,
> > and it can support the PMDOMAIN.
> >
> > gpu: gpu at ffa30000 {
> >         compatible = "arm,malit764",
> >                      "arm,malit76x",
> >                      "arm,malit7xx",
> >                      "arm,mali-midgard";
> >         reg = <0xffa30000 0x10000>;
> >         interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> >         interrupt-names = "JOB", "MMU", "GPU";
> >         clocks = <&cru ACLK_GPU>;
> >         clock-names = "aclk_gpu";
> >         operating-points = <
> >                 /* KHz uV */
> >                 100000 800000
> >                 200000 850000
> >                 300000 950000
> >                 400000 1000000
> >                 600000 1150000
> >         >;
> >         power-domains = <&gpu_power>;
> >         status = "disabled";
> > };
> >
> > Based on:
> > - [PATCH v1 1/4] PM / clock_ops: Add pm_clk_add_clk()
> >   http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg735599.html
> >
> > Changes in v7:
> > - Delete unused variables
> >
> > Changes in v6:
> > - delete pmu_lock
> > - modify dev_lock using mutex
> > - pm_clk_resume(pd->dev) change to pm_clk_resume(ed->dev)
> > - pm_clk_suspend(pd->dev) change to pm_clk_suspend(ed->dev)
> > - add devm_kfree(pd->dev, de) in rockchip_pm_domain_detach_dev
> >
> > Changes in v5:
> > - delete idle_lock
> > - add timeout in rockchip_pmu_set_idle_request()
> >
> > Changes in v4:
> > - use list storage dev
> >
> > Changes in v3:
> > - change use pm_clk_resume() and pm_clk_suspend()
> > - DT structure has changed
> > - Decomposition power-controller, changed to multiple controller
> >    (gpu-power-controller, hevc-power-controller)
> >
> > Changes in v2:
> > - remove the "pd->pd.of_node = np"
> > - move clocks to "optional"
> > - make pd_vio clocks all one entry per line and alphabetize.
> > - power: power-controller move back to pinctrl: pinctrl.
> >
> > jinkun.hong (3):
> >   power-domain: add power domain drivers for Rockchip platform
> >   dt-bindings: add document of Rockchip power domain
> >   ARM: dts: add rk3288 power-domain node
> >
> >  .../bindings/arm/rockchip/power_domain.txt         |   46 +++
> >  arch/arm/boot/dts/rk3288.dtsi                      |   24 ++
> >  arch/arm/mach-rockchip/Kconfig                     |    1 +
> >  arch/arm/mach-rockchip/Makefile                    |    1 +
> >  arch/arm/mach-rockchip/pm_domains.c                |  355 ++++++++++++++++++++
> >  5 files changed, 427 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/rockchip/power_domain.txt
> >  create mode 100644 arch/arm/mach-rockchip/pm_domains.c
> 
> I haven't been following all of the changes here, but I'll say that I
> just spent a bunch of time figuring out why my system wasn't properly
> going into suspend using your patchset after I picked up Kever's patch
> to disable unused clocks
> (https://patchwork.kernel.org/patch/5202291/).
> 
> It turns out that if I go back to patch v2 of your series that suspend
> works great.  ...but not with v7.
> 
> I got to this point because I started bisecting clocks.  I realized
> that I needed to leave on "aclk_vepu", "aclk_vdpu", "aclk_rga_pre",
> "sclk_rga", "aclk_hevc", ..., ...  As I kept finding more clocks they
> kept looking more and more like your list from the v2 dtsi and it
> became obvious.
> 
> 
> I guess that things are not properly being turned off properly due to
> the reason you stated in <https://lkml.org/lkml/2014/10/28/1279>.
> Specifically we need all the relevant clocks on in order to power
> things on and off.

I guess since the platform requirement is to have all clocks on during
power domain power transitions the easiest way is indeed to list all
relevant clocks in power domain description instead of trying to fetch
them from devices that compose power domain. I believe it is more
correct because:

1. Placing a device into power domain is done at probe time so
inherently not all clocks are enumerated when first device is being
probed and we trun the power to the domain.

2. We may not have drivers for all devices enabled on a given product
and so not all device will not be bound to a driver which cause them be
detached from their power domain.

Thanks.

-- 
Dmitry
