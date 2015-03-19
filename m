From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 19 Mar 2015 08:58:58 -0700
Subject: [PATCH 5/5] ARM: dts: brcmstb: add nodes for SATA controller and
 PHY
In-Reply-To: <550AB40C.8060607@cogentembedded.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
 <1426728222-8197-5-git-send-email-computersforpeace@gmail.com>
 <550AB40C.8060607@cogentembedded.com>
Message-ID: <20150319155858.GB19571@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Mar 19, 2015 at 02:33:32PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 3/19/2015 4:23 AM, Brian Norris wrote:
> 
> >Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> >---
> >Light dependency on:
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331921.html
> >for the surrounding text.
> 
> >  arch/arm/boot/dts/bcm7445.dtsi | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> 
> >diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
> >index 9eaeac8dce1b..7a7c4d8c2afe 100644
> >--- a/arch/arm/boot/dts/bcm7445.dtsi
> >+++ b/arch/arm/boot/dts/bcm7445.dtsi
> >@@ -108,6 +108,42 @@
> >  			brcm,int-map-mask = <0x25c>, <0x7000000>;
> >  			brcm,int-fwd-mask = <0x70000>;
> >  		};
> >+
> >+		sata at f045a000 {
> 
>    Hm, why the <unit-address> part of the name doesn't correspond to the
> "reg" prop?

Whoops. This .dtsi file is confusing, since none of the Broadcom DTS's I deal
with have the 'ranges' property building in an 0xf0000000 offset in the
/rdb node. All our DTS's give absolute register addresses, not relative.
This discrepancy is a copy-and-paste where I fixed the functional aspect
(the 'reg' property) but overlooked the cosmetic (the name /
unit-address).

We considered just reworking the /rdb node so that it drops the
0xf0000000 offset, in order to be more consistent and to avoid
"mistakes" like this. I could either do that (and use 0xf045a000 in both
places) or just fix the unit address you pointed out.

> >+			compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
> >+			reg-names = "ahci", "top-ctrl";
> >+			reg = <0x45a000 0xa9c>, <0x458040 0x24>;
> >+			interrupts = <GIC_SPI 30 0>;
> >+			#address-cells = <1>;
> >+			#size-cells = <0>;
> [...]
> >+		sata_phy: sata-phy at f0458100 {
> 
>    Same question here...

Same answer :)

> >+			compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
> >+			reg = <0x458100 0x1e00>, <0x45804c 0x10>;
> [...]

Thanks for the review.

Brian
