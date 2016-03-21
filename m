From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 21 Mar 2016 16:52:23 +0100
Subject: [PATCH] cpufreq: rockchip: add driver
In-Reply-To: <1971421.XfIKeB8O8v@diego>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
 <56EFF610.6040402@rock-chips.com> <1971421.XfIKeB8O8v@diego>
Message-ID: <1677635.LBekym086Y@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 21. M?rz 2016, 16:13:40 schrieb Heiko St?bner:
> Hi,
> 
> Am Montag, 21. M?rz 2016, 21:24:32 schrieb Feng Xiao:
> > ? 2016/3/21 17:58, Viresh Kumar ??:
> > > On 21-03-16, 10:54, Heiko St?bner wrote:
> > >> I hadn't seen that yet ... nice that cpufreq-dt now also supports
> > >> clusters :-)
> > >> 
> > >> The other part still stands though, as we probably should register the
> > >> platform-device somewhere else and not in some new special module.
> > >> 
> > >> When everything is using cpufreq-dt now, I guess we could just add it
> > >> to
> > >> the core rockchip clk-code. Or was there some agreement where this
> > >> should be done (obviously not the devicetree itself)?
> > 
> > Of_clk_init is called early, and platform_device_register_simple should
> > be called after devices_init, it will be failed to do it from clk-code.
> > So we need add a new file or add module_init to each clock controller
> > driver(like clk-rk3368.c, clk-rk3399.c) ?
> 
> as Viresh said, it should be ok to do it like your approach creating a
> module in drivers/cpufreq. But the compatible check is necessary.
> 
> Doing it this way also makes it easier to have

Seem like I forgot the complete my sentence here. This should've been

Doing it this way also makes it easier to have everything go into cpufreq-dt 
once that whitelist appears that Viresh wrote about. So this might be better 
than to distribute this stuff around other subsystems, as I originally 
suggested.

> 
> > > Yeah, there was a discussion around creating a white or black list of
> > > platforms that want to create a platform device for cpufreq-dt. That can
> > > be done in cpufreq-dt.c or a new file, but I haven't worked out on that
> > > yet.
> > > 
> > > You can do it from clk-code or from the driver that was added in this
> > > thread. Just that you need to match your platform's compatible string
> > > before doing that.
> > 
> > Rockchip-cpufreq.c depends on ARM_ROCKCHIP_CPUFREQ, it will not be
> > compiled on non-Rockchip platforms.
> > The driver can support all Rockchip SoCs up to now, add
> > of_machine_is_compatible may be redundant ?
> 
> Please always keep multiplatform in mind. These days the kernel can be
> compiled for multiple architectures at the same time, so you can have
> support for Rockchip, Exynos, Qualcom and whatever in the same kernel
> image.
> 
> Therefore a compile-time check is not enough and you need to check the
> actually running machine as well.
> 
> 
> Heiko
