From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 29 Nov 2016 15:07:54 +0000
Subject: [PATCH] clocksource/arm_global_timer: reconfigure clockevents
 after cpufreq change
In-Reply-To: <BC3314B3-6504-4324-8707-C04534893DAC@gmail.com>
References: <1480421716-30782-1-git-send-email-al.kochet@gmail.com>
 <1480421716-30782-2-git-send-email-al.kochet@gmail.com>
 <alpine.DEB.2.20.1611291432290.4358@nanos>
 <763a77c2-3d19-8d20-88df-27f0b8b80b8b@arm.com>
 <alpine.DEB.2.20.1611291529520.4358@nanos>
 <BC3314B3-6504-4324-8707-C04534893DAC@gmail.com>
Message-ID: <ecede3e0-2683-9cbb-1e27-e999a06fe4d7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/11/16 14:51, Alexander Kochetkov wrote:
> 
>> 29 ????. 2016 ?., ? 17:32, Thomas Gleixner <tglx@linutronix.de> ???????(?):
>>
>> Can we just disable that global timer on affected SoCs and use something
>> else instead?
> 
> I?ve sent patch series for fixing that on rockchip SoC.
> http://lists.infradead.org/pipermail/linux-rockchip/2016-November/013217.html
> 
> But the series contain fix only for rk3188, because I don?t have another rockchip
> SoC. rk3288 and other could be easy fixed with dts files.

3288 (and probably anything newer) is irrelevant to this discussion, as
it has the arch timer interface - that may be busted in other ways (such
as not being correctly set up by firmware and not being always-on as it
should), but frequency is not one of them. This only affects
Cortex-A9/A5 based parts.

> There are a lot of other platforms what probably use shed_clock and
> clocksource form global-timer.

Presumably it's only an issue if they also have cpufreq?

> alexander at ubuntu:dts$ grep arm,cortex-a9-global-timer *
> am4372.dtsi:		compatible = "arm,cortex-a9-global-timer";
> artpec6.dtsi:		compatible = "arm,cortex-a9-global-timer";
> bcm5301x.dtsi:			compatible = "arm,cortex-a9-global-timer";
> bcm63138.dtsi:			compatible = "arm,cortex-a9-global-timer";
> bcm-cygnus.dtsi:			compatible = "arm,cortex-a9-global-timer";
> bcm-nsp.dtsi:			compatible = "arm,cortex-a9-global-timer";
> hip01.dtsi:			compatible = "arm,cortex-a9-global-timer";
> rk3xxx.dtsi:		compatible = "arm,cortex-a9-global-timer";
> stih407-family.dtsi:		compatible = "arm,cortex-a9-global-timer";
> stih41x.dtsi:		compatible = "arm,cortex-a9-global-timer";
> uniphier-common32.dtsi:			compatible = "arm,cortex-a9-global-timer";
> uniphier-ph1-sld3.dtsi:			compatible = "arm,cortex-a9-global-timer";
> vexpress-v2p-ca5s.dts:		             "arm,cortex-a9-global-timer";

I can tell you that one, for one, is never used, because it depends on
an input clock provided by the vexpress-osc driver which cannot be
probed sufficiently early.

Robin.

> vf500.dtsi:				compatible = "arm,cortex-a9-global-timer";
> zx296702.dtsi:			compatible = "arm,cortex-a9-global-timer";
> zynq-7000.dtsi:			compatible = "arm,cortex-a9-global-timer?;
> 
> Regards,
> Alexander.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
