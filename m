From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 14 Aug 2014 16:12:01 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA0LzRdIEFSTTogZHRzOiBrZXlzdG9uZS1rMmhrOiBhZGQg?=
 =?UTF-8?B?ZHNwIGdwaW8gY29udHJvbGxlcnMgbm9kZXM=?=
In-Reply-To: <53ECA7F3.7030702@ti.com>
References: <1407946582-20927-1-git-send-email-grygorii.strashko@ti.com>
 <1407945984.545232249@f170.i.mail.ru> <53ECA7F3.7030702@ti.com>
Message-ID: <1408018321.928492982@f270.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thu, 14 Aug 2014 15:13:39 +0300 ?? Grygorii Strashko <grygorii.strashko@ti.com>:
> Hi Alexander,
> 
> On 08/13/2014 07:06 PM, Alexander Shiyan wrote:
> > Wed, 13 Aug 2014 19:16:22 +0300 ?? Grygorii Strashko <grygorii.strashko@ti.com>:
> >> Add Keystone 2 DSP GPIO nodes.
> >> DSP GPIO banks 0-7 correspond to DSP0-DSP7
> >>
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >> ---
> >>   arch/arm/boot/dts/k2hk.dtsi |   56 +++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 56 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/k2hk.dtsi b/arch/arm/boot/dts/k2hk.dtsi
> >> index 321ba2f..009e180 100644
> >> --- a/arch/arm/boot/dts/k2hk.dtsi
> >> +++ b/arch/arm/boot/dts/k2hk.dtsi
> >> @@ -50,5 +50,61 @@
> >>   			#interrupt-cells = <1>;
> >>   			ti,syscon-dev = <&devctrl 0x2a0>;
> >>   		};
> >> +
> >> +		dspgpio0: keystone_dsp_gpio at 02620240 {
> >> +			compatible = "ti,keystone-mctrl-gpio";
> >> +			gpio-controller;
> >> +			#gpio-cells = <2>;
> >> +			gpio,syscon-dev = <&devctrl 0x240>;
> >> +		};
> >> +
> >> +		dspgpio1: keystone_dsp_gpio at 2620244 {
> >> +			compatible = "ti,keystone-mctrl-gpio";
> >> +			gpio-controller;
> >> +			#gpio-cells = <2>;
> >> +			gpio,syscon-dev = <&devctrl 0x244>;
> >> +		};
> > ...
> >> +		dspgpio7: keystone_dsp_gpio at 262025C {
> >> +			compatible = "ti,keystone-mctrl-gpio";
> >> +			gpio-controller;
> >> +			#gpio-cells = <2>;
> >> +			gpio,syscon-dev = <&devctrl 0x25c>;
> >> +		};
> > 
> > So, devctrl is a syscon device and this DTS introduce several
> > identical GPIO descriptions?
> > 
> > On my opinion this should be placed in the gpio-syscon.c,
> > where you can add support for ti,keystone-dsp0{..7}-gpio.
> > Such change will avoid parts 2 and 3 of this patch.
> > 
> > static const struct syscon_gpio_data ti_keystone_dsp0_gpio = {
> >    .compatible = "ti,keystone-syscon",
> >    .dat_bit_offset = 0x240 * 8,
> >    ...
> >    .set = etc...
> > };
> 
> So, if I understand you right, you propose to add 8 additional compatible
> strings just to encode different register offsets. Is it?
> 1) add "ti,keystone-mctrl-gpio0"..."ti,keystone-mctrl-gpio7"

Yes, but replace "mctrl" with "dsp" since mctrl is not applicable here.

> 2) add 8 structures keystone_mctrl_gpio0..keystone_mctrl_gpio7 in gpio-syscon.c
>    (which will have only different values of field - .dat_bit_offset = 0x2yy * 8,)
> 
> 3) add 8 additional items in array syscon_gpio_ids
> 	{
> 		.compatible	= "ti,keystone-mctrl-gpio0",
> 		.data		= &keystone_mctrl_gpio0,
> 	}, ...
> 
> I can do it if you strictly insist, BUT I don't like it :(
> - just imagine how your driver will look look like if 5 or 6 SoCs will re-use it ;)
> - as I mentioned in cover letter and commit messages even each SoC revision can have
>   different Syscon implementation with different registers offsets and with different
>   number of Syscon register ranges (for example for Keystone 2 we already have two
>   Syscon devices defined in DT).

The initial version of this driver contains addresses and offsets in, but this approach has
been criticized by DT maintainers.

"different Syscon with different registers" - is OK, since we use compatible string in definition.
If you have two identical syscon, just append an unique additional string and use it in this driver.

> Now we already have 3 Keystone 2 SoC revisions (K2HK, K2L, K2E)  and there are no guarantee
> that the next revision k2X will have the same register offset for GPIO0.

Then use more exact string for syscon-gpio, like ti,keystone-k2hk-dsp-gpio0.

---
