From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 25 Aug 2015 17:49:04 +0100
Subject: [PATCH v2 05/11] ARM: DT: STi: STiH407: Add c8sectpfe LinuxDVB
 DT node.
In-Reply-To: <20150817115242.4ae9a51e@recife.lan>
References: <1438276141-16902-1-git-send-email-peter.griffin@linaro.org>
 <1438276141-16902-6-git-send-email-peter.griffin@linaro.org>
 <20150817115242.4ae9a51e@recife.lan>
Message-ID: <20150825164904.GB13253@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

On Mon, 17 Aug 2015, Mauro Carvalho Chehab wrote:

> Em Thu, 30 Jul 2015 18:08:55 +0100
> Peter Griffin <peter.griffin@linaro.org> escreveu:
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
> >  / {
> >  	soc {
> >  		sbc_serial0: serial at 9530000 {
> > @@ -85,5 +89,39 @@
> >  			status = "okay";
> >  		};
> >  
> > +		c8sectpfe at 08a20000 {
> > +			compatible = "st,stih407-c8sectpfe";
> > +			status = "okay";
> > +			reg = <0x08a20000 0x10000>, <0x08a00000 0x4000>;
> > +			reg-names = "c8sectpfe", "c8sectpfe-ram";
> > +
> > +			interrupts = <0 34 0>, <0 35 0>;
> > +			interrupt-names = "c8sectpfe-error-irq",
> > +					  "c8sectpfe-idle-irq";
> > +
> > +			pinctrl-names	= "tsin0-serial", "tsin0-parallel",
> > +					  "tsin3-serial", "tsin4-serial",
> > +					  "tsin5-serial";
> > +
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
> > +				tsin-num = <0>;
> > +				serial-not-parallel;
> > +				i2c-bus = <&ssc2>;
> 
> There's no ssc2 defined at the device tree.

Whoops, I missed one patch off from the series in v2.
> 
> I'll revert this patch and mark the driver as broken until this gets
> fixed.

I just sent you another series here https://lkml.org/lkml/2015/8/25/499
which includes this patch, and also the patch which adds ssc2/3, along
with a fix to the Kconfig file spotted by Valentin Rothberg.

regards,

Peter.
