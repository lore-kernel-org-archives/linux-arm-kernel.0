From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 26 Aug 2015 12:44:33 +0100
Subject: [PATCH 2/3] ARM: DT: STi: STiH407: Add c8sectpfe LinuxDVB DT node.
In-Reply-To: <20150826073041.GT19409@x1>
References: <1440519730-486-1-git-send-email-peter.griffin@linaro.org>
 <1440519730-486-3-git-send-email-peter.griffin@linaro.org>
 <20150826073041.GT19409@x1>
Message-ID: <20150826114433.GB1498@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, 26 Aug 2015, Lee Jones wrote:

> On Tue, 25 Aug 2015, Peter Griffin wrote:
> 
> > This patch adds in the required DT node for the c8sectpfe
> > Linux DVB demux driver which allows the tsin channels
> > to be used on an upstream kernel.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  arch/arm/boot/dts/stihxxx-b2120.dtsi | 38 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> > index 62994ae..1bc018e 100644
> > --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> > +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> > @@ -6,6 +6,10 @@
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> >   */
> > +
> > +#include <dt-bindings/clock/stih407-clks.h>
> > +#include <dt-bindings/media/c8sectpfe.h>
> > +
> 
> Looks like some of the STi files are a little wavering on convention,
> but I suggest the extra '\n's are superfluous.

Ok I will remove them in v2.

> 
> >  / {
> >  	soc {
> >  		sbc_serial0: serial at 9530000 {
> > @@ -85,5 +89,39 @@
> >  			status = "okay";
> >  		};
> >  
> > +		c8sectpfe at 08a20000 {
> 
> This should be a device type, not a model number.
> 
> demodulator at abcdabcd {

Ok will change to demux at 08a20000 in v2

> 
> > +			compatible = "st,stih407-c8sectpfe";
> 
> To the uninitiated c8sectpfe is pretty indecipherable.

It is the name of the IP block in the datasheet. It stands
for SECurity TRansport Processor FrontEnd

> 
> How about *-c8sectpfe-demod?

That doesn't really make sense, the demod is a seperate device
typically controlled over I2C bus and connected to this IP block
via the TS pins. Also although a tsin channel is "normally" connected
to a demodulator device there is no reason it couldn't be connected
for example to another STi chipset which is doing tsout.

Also this IP block can do more than accept tsin, it can
also do tsout, and merge TS channels together (some coming from
DDR, external TS pins). Which are features we hope to add
to the driver in the future so the name needs to be very generic.

So with that in mind I would prefer to leave the compatible as
the name of the IP block from the SoC datasheet.

> 
> > +			status = "okay";
> > +			reg = <0x08a20000 0x10000>, <0x08a00000 0x4000>;
> > +			reg-names = "c8sectpfe", "c8sectpfe-ram";
> > +
> > +			interrupts = <0 34 0>, <0 35 0>;
> 
> Please use the predetermined DEFINES for the flags cell.

Will fix in V2

> 
> > +			interrupt-names = "c8sectpfe-error-irq",
> > +					  "c8sectpfe-idle-irq";
> > +
> > +			pinctrl-names	= "tsin0-serial", "tsin0-parallel",
> > +					  "tsin3-serial", "tsin4-serial",
> > +					  "tsin5-serial";
> 
> I would put *-names *under* the properties they pertain to and in the
> same format i.e. one per line in this case, for easy eye-match.

Ok will change in V2.
> 
> > +			pinctrl-0	= <&pinctrl_tsin0_serial>;
> > +			pinctrl-1	= <&pinctrl_tsin0_parallel>;
> > +			pinctrl-2	= <&pinctrl_tsin3_serial>;
> > +			pinctrl-3	= <&pinctrl_tsin4_serial_alt3>;
> > +			pinctrl-4	= <&pinctrl_tsin5_serial_alt1>;
> > +
> > +			clocks = <&clk_s_c0_flexgen CLK_PROC_STFE>;
> > +			clock-names = "c8sectpfe";
> > +
> > +			/* tsin0 is TSA on NIMA */
> > +			tsin0: port at 0 {
> > +
> 
> Why the '\n'?

Removed in v2
> 
> > +				tsin-num = <0>;
> > +				serial-not-parallel;
> > +				i2c-bus = <&ssc2>;
> 
> If you are adding this property, I would get Wolfram or one of the DT
> guys to Ack it.

This driver is actually already accepted, I just missed off one patch from
the v2 series which meant this patch broke the build when Mauro applied it,
which is the reason for re-sending it.

This binding is the same way the drm display drivers use DT via ddc-i2c-bus
property to get the i2c bus for EDID control, so I think uncontroversial.
> 
> > +				rst-gpio = <&pio15 4 0>;
> 
> Why not use the whole name "reset"?
> 
> "-gpio" should be "-gpios".
> 
> So, in full: "reset-gpios"?
> 
> Flags: GPIO_ACTIVE_HIGH ?

Doing a grep, that does seem to be "more standard". Will fix in V2 as a single
atomic commit.

regards,

Peter.
