From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 12 Sep 2016 15:28:52 -0700
Subject: [PATCH 4/5] ARM: dts: exynos: add support for ISP power domain
 to exynos4x12 clocks device
In-Reply-To: <f340cca5-6cd6-6bd1-3b9a-ccd58cbc0091@samsung.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
 <1472737551-15272-5-git-send-email-m.szyprowski@samsung.com>
 <20160908002254.GD13062@codeaurora.org>
 <CGME20160912102332eucas1p145e79669788329b44343da62dcbe50ca@eucas1p1.samsung.com>
 <f340cca5-6cd6-6bd1-3b9a-ccd58cbc0091@samsung.com>
Message-ID: <20160912222852.GH7243@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12, Marek Szyprowski wrote:
> Hi Stephen,
> 
> 
> On 2016-09-08 02:22, Stephen Boyd wrote:
> >On 09/01, Marek Szyprowski wrote:
> >>Exynos4412 clock controller contains some additional clocks for FIMC-ISP
> >>(Camera ISP) subsystem. Registers for those clocks are partially located
> >>in the SOC area, which belongs to ISP power domain.
> >>
> >>This patch extends clock controller node with ISP clock sub-node and link
> >>(phandle) to ISP power domain.
> >>
> >>Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>---
> >>  arch/arm/boot/dts/exynos4x12.dtsi | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >>diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> >>index 3394bdcf10ae..4daea67546b9 100644
> >>--- a/arch/arm/boot/dts/exynos4x12.dtsi
> >>+++ b/arch/arm/boot/dts/exynos4x12.dtsi
> >>@@ -74,6 +74,11 @@
> >>  		compatible = "samsung,exynos4412-clock";
> >>  		reg = <0x10030000 0x20000>;
> >>  		#clock-cells = <1>;
> >>+
> >>+		isp-clock-controller {
> >>+			compatible = "samsung,exynos4412-isp-clock";
> >>+			power-domains = <&pd_isp>;
> >>+		};
> >Why can't we extend support in power domains code to have
> >multiple domains for a single device node? i.e. power-domains =
> ><&pd_isp>, <&pd_foo>, <&pd_bar>, and then pick the right one with
> >power-domain-names or something like that? Making a subnode
> >(which seems to turn into a child platform device?) seems like a
> >quick solution for larger problems.
> 
> The larger problem here is the fact that clock controller is
> partially located
> in different power areas of SoC. Majority of the clock controllers
> is located
> in the area which is typically always powered (besides system sleep case),
> while a few Camera ISP registers are located in the ISP block, which have
> separate power domain. Having a separate nodes for sub-parts of the
> device is
> rather common approach, already practices by some more complex devices.
> 
> I see some serious design problems with multiple entries in power domains
> property. First how to show that some part of the device IS NOT in
> any domain?

Is that even possible? Every device should be in some power
domain, even if it's just an "always on" power domain that we
don't really control from software.

> The question is how the automated assignment to domains would be handled for
> such case?

I don't get this part. Do you mean how we indicate to the driver
which power domain to use at the right time?

> 
> The second is related to Linux kernel internals. Right now device
> drivers are
> not aware of the power domains - there are no direct calls to power domains
> code, everything is hidden behind runtime pm which does all the hard work.

Right. Runtime PM will need to be improved to allow this case.

> 
> Similar situation is on Exynos 542x/5800, which will look more or less like
> this:
> 
>         clock: clock-controller at 10010000 {
>              compatible = "samsung,exynos5420-clock";
>              reg = <0x10010000 0x30000>;
>              #clock-cells = <1>;
> +
> +            gsc-clock-controller {
> +                 compatible = "samsung,exynos5420-gsc-clock";
> +                 power-domains = <&gsc_pd>;
> +            };
> +
> +            isp-clock-controller {
> +                 compatible = "samsung,exynos5420-isp-clock";
> +                 power-domains = <&isp_pd>;
> +            };
> +
> +            mfc-clock-controller {
> +                 compatible = "samsung,exynos5420-mfc-clock";
> +                 power-domains = <&mfc_pd>;
> +            };
> +
> +            msc-clock-controller {
> +                 compatible = "samsung,exynos5420-msc-clock";
> +                 power-domains = <&msc_pd>;
> +            };
> +
> +            disp-clock-controller {
> +                 compatible = "samsung,exynos5420-disp-clock";
> +                 power-domains = <&disp_pd>;
> +            };
>          };
> 
> The patch is not yet ready, so I didn't include it in this patchset.

Ok. From a DT perspective the sub-nodes seem to be a workaround
for how the linux device model is mapped to power domains. I'm
not sure we want to make subnodes in the clk controller just to
make sub devices that we can target from the clk registration
path. Those sub nodes aren't devices at all. I understand why
it's being done this way, I just don't see how it fits into DT
design methodologies.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
