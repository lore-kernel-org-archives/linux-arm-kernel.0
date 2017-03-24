From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 24 Mar 2017 15:25:15 +0800
Subject: [PATCH 05/12] ARM: dts: imx6ul-isiot-common: Add touchscreen node
In-Reply-To: <CAMty3ZBfdjrbvL7F9CbhfD_Wdowr4zM_Rdot=TGKMxq0JPyHjg@mail.gmail.com>
References: <1490204897-14525-1-git-send-email-jagan@openedev.com>
 <1490204897-14525-6-git-send-email-jagan@openedev.com>
 <20170324051632.GD30608@dragon>
 <CAMty3ZBfdjrbvL7F9CbhfD_Wdowr4zM_Rdot=TGKMxq0JPyHjg@mail.gmail.com>
Message-ID: <20170324072513.GL30608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 12:29:49PM +0530, Jagan Teki wrote:
> On Fri, Mar 24, 2017 at 10:46 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Wed, Mar 22, 2017 at 11:18:10PM +0530, Jagan Teki wrote:
> >> From: Jagan Teki <jagan@amarulasolutions.com>
> >>
> >> Add touchscreen node as i2c1 slave device on Engicam Is.IoT MX6UL
> >> modules, the touchscreen controlled 'st,stmpe-ts' connected via
> >> i2c with st,stmpe811 mfb interface.
> >
> > s/mfb/mfd?
> >
> >>
> >> Cc: Shawn Guo <shawnguo@kernel.org>
> >> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> >> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >> ---
> >>  arch/arm/boot/dts/imx6ul-isiot-common.dtsi | 34 ++++++++++++++++++++++++++++++
> >>  1 file changed, 34 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
> >> index 9660e20..b149b5e 100644
> >> --- a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
> >> +++ b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
> >> @@ -40,6 +40,34 @@
> >>   *     OTHER DEALINGS IN THE SOFTWARE.
> >>   */
> >>
> >> +&i2c1 {
> >> +     touch: stmpe811 at 44 {
> >
> > Label a MFD device 'touch'?  Also, the node name should be generic.  Not
> > sure what should be used for MFD device though.
> 
> May be I can use stmpe811 at 41 the existing imx6qdl-apalis.dtsi using
> the similar notation.

Per application notes of stmpe811 below, I would suggest you name it
gpio-expander.

www.st.com/resource/zh/datasheet/CD00186725.pdf

> 
> >
> >> +             compatible = "st,stmpe811";
> >> +             reg = <0x44>;
> >> +             #address-cells = <1>;
> >> +             #size-cells = <0>;
> >> +             pinctrl-names = "default";
> >> +             pinctrl-0 = <&pinctrl_stmpe_ts>;
> >
> > If this is for stmpe-ts, shouldn't be put into touchscreen child node?
> 
> Actually this is interrupt pad, for the touch controller via stmpe so
> I can rename pinctrl_touch_int.

Or just pinctrl_stmpe.

> 
> >
> >> +             interrupt-parent = <&gpio1>;
> >> +             interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
> >> +             interrupt-controller;
> >> +             #interrupt-cells = <2>;
> >> +
> >> +             stmpe_touchscreen {
> >
> > 'stmpe: touchscreen {' might be better.
> 
> stmpe_touchscreen {
> 
> This is also compatible with existing dtsi files

We do not need to keep compatibility with something not good.

Shawn
