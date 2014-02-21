From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Feb 2014 19:54:15 +0100
Subject: [PATCH v7 5/8] ARM: dts: sun7i: Add support for mmc
In-Reply-To: <530377EE.8010909@redhat.com>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100241.15040.24836.stgit@pagira.o2s.ch>
 <20140218142221.GJ3142@lukather> <530377EE.8010909@redhat.com>
Message-ID: <20140221185415.GD3931@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 04:10:38PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 02/18/2014 03:22 PM, Maxime Ripard wrote:
> >On Mon, Feb 17, 2014 at 11:02:41AM +0100, David Lanzend?rfer wrote:
> >>Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |    8 +++
> >>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |    8 +++
> >>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |   23 +++++++++
> >>  arch/arm/boot/dts/sun7i-a20.dtsi                |   61 +++++++++++++++++++++++
> >>  4 files changed, 100 insertions(+)
> >>
> >
> >I'd prefer to have three patches here:
> >    - One that add the controllers
> >    - One that add the pin muxing options
> >    - One that enable the controllers on the various boards.
> >
> >>diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> >>index 5c51cb8..ae800b6 100644
> >>--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> >>+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> >>@@ -34,6 +34,14 @@
> >>  			};
> >>  		};
> >>
> >>+		mmc0: mmc at 01c0f000 {
> >>+			pinctrl-names = "default", "default";
> >>+			pinctrl-0 = <&mmc0_pins_a>;
> >>+			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
> >
> >This can be made a single pinctrl group, you don't need the pinctrl-1
> >stuff, it only complicates the node.
> 
> Then how do we deal with boards which use a different gpio for card-detect ?
> 
> In that case we don't want to change the mux setting of the reference
> design cd pin. IOW I believe that having 2 separate pinctrl settings for
> this is the rigt thing todo. I would prefer using just mmc0_cd_pin_a instead
> of _reference_design though.
> 
> Oh wait, you're probably talking about using:
> 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> 
> Yes that would be better.

Yep, exactly :)

> >
> >>+			cd-gpios = <&pio 7 1 0>; /* PH1 */
> >>+			status = "okay";
> >>+		};
> >>+
> >>  		pinctrl at 01c20800 {
> >>  			led_pins_cubieboard2: led_pins at 0 {
> >>  				allwinner,pins = "PH20", "PH21";
> >>diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> >>index f9dcb61..370cef84 100644
> >>--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> >>+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> >>@@ -19,6 +19,14 @@
> >>  	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
> >>
> >>  	soc at 01c00000 {
> >>+		mmc0: mmc at 01c0f000 {
> >>+			pinctrl-names = "default", "default";
> >>+			pinctrl-0 = <&mmc0_pins_a>;
> >>+			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
> >>+			cd-gpios = <&pio 7 1 0>; /* PH1 */
> >>+			status = "okay";
> >>+		};
> >>+
> >>  		pinctrl at 01c20800 {
> >>  			led_pins_cubietruck: led_pins at 0 {
> >>  				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
> >>diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> >>index ead3013..685ec06 100644
> >>--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> >>+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> >>@@ -34,7 +34,30 @@
> >>  			};
> >>  		};
> >>
> >>+		mmc0: mmc at 01c0f000 {
> >>+			pinctrl-names = "default", "default";
> >>+			pinctrl-0 = <&mmc0_pins_a>;
> >>+			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
> >>+			cd-gpios = <&pio 7 1 0>; /* PH1 */
> >>+			status = "okay";
> >>+		};
> >>+
> >>+		mmc3: mmc at 01c12000 {
> >>+			pinctrl-names = "default", "default";
> >>+			pinctrl-0 = <&mmc3_pins_a>;
> >>+			pinctrl-1 = <&mmc3_cd_pin_olinuxinom>;
> >>+			cd-gpios = <&pio 7 11 0>; /* PH11 */
> >>+			status = "okay";
> >>+		};
> >>+
> >>  		pinctrl at 01c20800 {
> >>+			mmc3_cd_pin_olinuxinom: mmc3_cd_pin at 0 {
> >>+				allwinner,pins = "PH11";
> >>+				allwinner,function = "gpio_in";
> >>+				allwinner,drive = <0>;
> >>+				allwinner,pull = <1>;
> >>+			};
> >>+
> >>  			led_pins_olinuxino: led_pins at 0 {
> >>  				allwinner,pins = "PH2";
> >>  				allwinner,function = "gpio_out";
> >>diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> >>index 9ff0948..5b55414 100644
> >>--- a/arch/arm/boot/dts/sun7i-a20.dtsi
> >>+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> >>@@ -355,6 +355,46 @@
> >>  			#size-cells = <0>;
> >>  		};
> >>
> >>+		mmc0: mmc at 01c0f000 {
> >>+			compatible = "allwinner,sun5i-a13-mmc";
> >>+			reg = <0x01c0f000 0x1000>;
> >>+			clocks = <&ahb_gates 8>, <&mmc0_clk>;
> >>+			clock-names = "ahb", "mod";
> >>+			interrupts = <0 32 4>;
> >>+			bus-width = <4>;
> >
> >This belongs to the board, the controller itself is able to handle
> >several bus width.
> 
> I believe that providing some form of default in the dtsi makes sense
> here and all boards we've seen sofar always use 4 bits, we can always
> override this from the dts file itself.

There's already a documented default that is 1. Plus, I still believe
in a strict separation between what's in the SoC being in the DTSI and
what's in the board being in the DTS.

Apart from being more rigorous, it also has the advantage of being
*much* clearer whenever your read a board DTS, since you don't have to
actually open several DTS(I) to get what's going on.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140221/36901c53/attachment-0001.sig>
