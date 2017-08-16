From: briannorris@chromium.org (Brian Norris)
Date: Wed, 16 Aug 2017 09:43:44 -0700
Subject: [RFC PATCH 3/3] arm64: dts: rockchip: Handle pcie wake in pcie
 driver for Gru
In-Reply-To: <3bd2600e-6e5d-6179-6b9b-6989e1f65b7d@rock-chips.com>
References: <20170816075224.31734-1-jeffy.chen@rock-chips.com>
 <20170816075224.31734-4-jeffy.chen@rock-chips.com>
 <3bd2600e-6e5d-6179-6b9b-6989e1f65b7d@rock-chips.com>
Message-ID: <20170816164343.GA99323@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Aug 16, 2017 at 04:33:38PM +0800, Shawn Lin wrote:
> On 2017/8/16 15:52, Jeffy Chen wrote:
> >Currently we are handling pcie wake irq in mrvl wifi driver.
> >Move it to rockchip pcie driver for Gru boards.
> >
> >Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> >---
> >
> >  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> >diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> >index d48e98b62d09..7a5e1517a496 100644
> >--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> >+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> >@@ -712,11 +712,21 @@ ap_i2c_audio: &i2c8 {
> >  	ep-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
> >  	pinctrl-names = "default";
> >-	pinctrl-0 = <&pcie_clkreqn_cpm>, <&wifi_perst_l>;
> >+	pinctrl-0 = <&pcie_clkreqn_cpm>, <&wlan_host_wake_l>, <&wifi_perst_l>;
> >+
> >+	interrupts-extended = <&gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
> >+			      <&gic GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
> >+			      <&gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>,
> >+			      <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
> >+	interrupt-names = "sys", "legacy", "client", "wake";
> >+	/delete-property/ interrupts;
> >+
> 
> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> says "Nodes that describe devices which generate interrupts must contain
> an "interrupts" property, an "interrupts-extended" property, or both. If
> both are present, the latter should take precedence;"

I added that language, and as the text notes, it's just for
compatibility in case some software doesn't understand the 'extended'
property. It's occasionally useful, but not extremely often. (In my case
at that time: we actually had the DTB stuck in the bootloader, and so
would support various combinations of old/new DTBs/kernels which may or
may not understand 'interrupts-extended'.)

> But it doesn't seem real as drivers/of/irq.c actually says "Try the
> new-style interrupts-extended first"

How is that not real? That follows exactly what the binding says; "the
latter" (i.e., the new-style interrupts-extended) is taking precedence.

> Anyway, it seems you could safely add interrupts-extended and don't need
> to delete "interrupts".

You could do this, yes. Unless you really need the compatibility (and
are prepared for such a system to ignore the "wake" interrupt in that
case), I'm not sure the value in that though, as it would just make
things more confusing.

Brian
