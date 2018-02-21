From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 21 Feb 2018 22:57:47 +0100
Subject: [PATCH 2/3] arm64: dts: rockchip: add rk3328 display nodes
In-Reply-To: <ca7e8c5d-55e3-0dc9-1132-f542cb577693@arm.com>
References: <20180216223817.2821-1-heiko@sntech.de> <2712253.IuLOJ454Fc@phil>
 <ca7e8c5d-55e3-0dc9-1132-f542cb577693@arm.com>
Message-ID: <2909171.GCRVT3W7gj@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 21. Februar 2018, 13:04:11 CET schrieb Robin Murphy:
> On 20/02/18 22:08, Heiko Stuebner wrote:
> > Hi Robin,
> > 
> > Am Dienstag, 20. Februar 2018, 14:14:31 CET schrieb Robin Murphy:
> >> On 16/02/18 22:38, Heiko Stuebner wrote:
> >>> Add the chain of display nodes from the core display-subsystem
> >>> through the one vop to the dw-hdmi output.
> >>>
> >>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >>> ---
> >>>    arch/arm64/boot/dts/rockchip/rk3328.dtsi | 56 ++++++++++++++++++++++++++++++++
> >>>    1 file changed, 56 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >>> index 1615effcc191..65b7d460a044 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >>> @@ -185,6 +185,11 @@
> >>>    		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> >>>    	};
> >>>    
> >>> +	display_subsystem: display-subsystem {
> >>> +		compatible = "rockchip,display-subsystem";
> >>> +		ports = <&vop_out>;
> >>> +	};
> >>> +
> >>>    	psci {
> >>>    		compatible = "arm,psci-1.0", "arm,psci-0.2";
> >>>    		method = "smc";
> >>> @@ -626,6 +631,28 @@
> >>>    		status = "disabled";
> >>>    	};
> >>>    
> >>> +	vop: vop at ff370000 {
> >>> +		compatible = "rockchip,rk3328-vop";
> >>> +		reg = <0x0 0xff370000 0x0 0x3efc>;
> >>> +		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH 0>;
> >>
> >> Another of those rogue trailing zero cells has snuck in here.
> > 
> > Oh great.
> > Either they are missing when needed or trailing when not needed :-) .
> > 
> > 
> >> <digression>
> >> Unfortunately, even having learned the difference between drm-next and
> >> drm-misc-next (thanks for the pointer!) so I could apply this and the
> >> other series, I only managed to get it to not-quite-work on the box I'm
> >> currently reverse-engineering a mainline DT for (Beelink A1).
> >>
> >> I've got a monitor connected via HDMI-DVI (which the stock 3.10 Android
> >> kernel *does* drive happily) - it appears to be detected, but when the
> >> virtual console tries to come up I just see a handful of timeout splats
> >> from drm_atomic_helper_wait_for_vblanks() and no signal at the monitor.
> >>
> >> Any idea where to start debugging? (I'm 99% certain I had your clk/next
> >> branch pulled in as well since it looked significant, but I'll
> >> double-check tonight)
> > 
> > I guess first interesting point would be to check if the edid of the monitor
> > got read correctly. There are a bunch of funny GRF options related to i2c
> > voltages and such that get wiggled on hotplug events and they're not
> > really documented at all. (see all the *_5V_* constants in the dw-hdmi).
> 
> Cheers, that was indeed a fruitful starting point - EDID wasn't exactly 
> the problem, but having decoded the blob dumped out of sysfs to check 
> validity it appears the only native resolution mode my ancient Iiyama is 
> advertising is 1280x1024 at 75Hz. That prompted me to go and faff with the 
> TV (the only actual HDMI endpoint I own), and sure enough a 'regular' 
> 1920x1080 at 60Hz works just fine. So, for patches 1 and 2 (fixed up to 
> avoid the DTC warning):
> 
> Tested-by: Robin Murphy <robin.murphy@arm.com>

Nice :-)

> I guess it might just be a case of the VOP and/or HDMI clocks struggling 
> to attain an appropriate pixel clock, but the failure mode is really 
> non-obvious - if the monitor is plugged in at boot I get 4 or 5 of the 
> DRM_WARNs at various points, about 160 VOP interrupts somewhere along 
> the line, and HDMI interrupts at a constant rate of around two per 
> second; plugging it in after boot, however, just seems to silently do 
> nothing (IIRC hotplugging the TV similarly did work as expected). If I 
> find the time I might go back and try forcing a 60Hz mode to narrow 
> things down a bit more.

As I only have a standard 1080p display it's hard to check those edge cases,
but the struggle for display frequencies follows us for quite some time
already.

The current default is to source the display clock from the hdmi-phy
which contains its own pll, so I guess first order of business should
probably be to determine which rate gets requested for your display
and which rate gets set - as I'm guessing that we're missing rates.

DRM_WARNS would be interesting I guess, can you post them?
As for your hdmi-interrupts, from the dw-hdmi or the hdmi-phy?
