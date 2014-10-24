From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 23 Oct 2014 19:32:36 -0700
Subject: [PATCH v13 4/5] ARM: dts: add main Thermal info to rk3288
In-Reply-To: <5449B433.5040003@rock-chips.com>
References: <1414057207-1576-1-git-send-email-caesar.wang@rock-chips.com>
 <1414057207-1576-5-git-send-email-caesar.wang@rock-chips.com>
 <20141024004625.GD9463@dtor-ws> <5449A6A4.3070608@rock-chips.com>
 <E4EEE800-5701-45E5-9E97-D3B036DC2F17@gmail.com>
 <5449B433.5040003@rock-chips.com>
Message-ID: <20141024023236.GA19910@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 10:06:43AM +0800, Caesar Wang wrote:
> 
> ? 2014/10/24 9:37, Dmitry Torokhov ??:
> >On October 23, 2014 6:08:52 PM PDT, Caesar Wang <caesar.wang@rock-chips.com> wrote:
> >>Dmitry,
> >>
> >>? 2014/10/24 8:46, Dmitry Torokhov ??:
> >>>Hi Caesar,
> >>>
> >>>On Thu, Oct 23, 2014 at 05:40:06PM +0800, Caesar Wang wrote:
> >>>>This patch is depend on rk3288-thermal.dtsi,or
> >>>>it will compile error.
> >>>>
> >>>>If the temperature over a period of time High,over 120C
> >>>>the resulting TSHUT gave CRU module,let it reset
> >>>>the entire chip,or via GPIO give PMIC.
> >>>>
> >>>>Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> >>>>---
> >>>>   arch/arm/boot/dts/rk3288.dtsi | 21 +++++++++++++++++++++
> >>>>   1 file changed, 21 insertions(+)
> >>>>
> >>>>diff --git a/arch/arm/boot/dts/rk3288.dtsi
> >>b/arch/arm/boot/dts/rk3288.dtsi
> >>>>index cb18bb4..85fc17a 100644
> >>>>--- a/arch/arm/boot/dts/rk3288.dtsi
> >>>>+++ b/arch/arm/boot/dts/rk3288.dtsi
> >>>>@@ -15,6 +15,7 @@
> >>>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>>>   #include <dt-bindings/pinctrl/rockchip.h>
> >>>>   #include <dt-bindings/clock/rk3288-cru.h>
> >>>>+#include <dt-bindings/thermal/thermal.h>
> >>>>   #include "skeleton.dtsi"
> >>>>   / {
> >>>>@@ -66,6 +67,7 @@
> >>>>   				 216000  900000
> >>>>   				 126000  900000
> >>>>   			>;
> >>>>+			#cooling-cells = <2>; /* min followed by max */
> >>>>   			clock-latency = <40000>;
> >>>>   			clocks = <&cru ARMCLK>;
> >>>>   		};
> >>>>@@ -346,6 +348,19 @@
> >>>>   		status = "disabled";
> >>>>   	};
> >>>>+	tsadc: tsadc at ff280000 {
> >>>>+		compatible = "rockchip,rk3288-tsadc";
> >>>>+		reg = <0xff280000 0x100>;
> >>>>+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> >>>>+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> >>>>+		clock-names = "tsadc", "apb_pclk";
> >>>>+		pinctrl-names = "default";
> >>>>+		pinctrl-0 = <&otp_out>;
> >>>>+		#thermal-sensor-cells = <1>;
> >>>>+		hw-shut-temp = <120000>;
> >>>I do not think this is a good value. You have (in the other DTS file)
> >>>passive trip point at 80 and critical (which should result in orderly
> >>>shutdown) at 125. But here you define hardware-controlled shutdown at
> >>>120C, which is backwards. You should have:
> >>>
> >>>passive <= critical <= hardware
> >>Hmmm....
> >>but, the system will shutdown when temperature over critial value,
> >>there is no chance of triggering the TSHUT.
> >>
> >>If the temperature over a period of time High,as we know,
> >>the resulting TSHUT gave CRU module,let it hot-reset the entire chip,
> >>or via GPIO give PMIC cold-reset the entire chip.
> >Having tshut trigger is not the goal, tshut is the measure of last resort. If we can handle thermal conditions without triggering tshut, we achieved our goal.
> >
> >Tshut triggering is " oh, crap, nothing we tried works" scenario.
> 
> I don't think so.
> 
> In general,We should have:
> passive <= hardware(reset entire chip) <= critical(shutdown)
> 
> The temperature be rising qulckly if have some other conditions,
> the "critical" will play a role.

No, I think it should be the other way around: if we are unable to cool
down the laptop under load we need to shut it down and let it cool. If
for some reason we are unable to shut it down in orderly fashion (kernel
is stuck holding a lock or similar) then hardware will reset it.

At least that's how I understand it.

Thanks.

-- 
Dmitry
