From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 24 Sep 2018 14:16:51 -0700
Subject: [PATCH] arm64: dts: sdm630 SoC and Sony Pioneer (Xperia XA2)
 support
In-Reply-To: <18147804-E195-4A4F-B215-77E8E4FF7C88@gmail.com>
References: <20180811162549.12312-1-ctatlor97@gmail.com>
 <20180924191929.GQ1367@tuxbook-pro>
 <18147804-E195-4A4F-B215-77E8E4FF7C88@gmail.com>
Message-ID: <20180924211650.GH2523@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 24 Sep 13:42 PDT 2018, Craig wrote:
> On 24 September 2018 20:19:29 BST, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> >On Sat 11 Aug 09:25 PDT 2018, Craig Tatlor wrote:
> >
> >> Initial device tree support for Qualcomm SDM630 SoC and
> >> Sony Pioneer (Xperia XA2).
> >> 
> >> SDM630 is based off of the SDM660 soc and all SDM660 specific drivers
> >are
> >> compatible with it. SDM660 is also based off of MSM8998 so it uses
> >some
> >> of its drivers aswell.
> >
> >Consider adding both sdm630 and sdm660 compatibles to the bindings and
> >drivers and use the right one in the dts, in case we find details that
> >differs in the future.
> 
> This includes pinctrl and GCC?

Yes

> >
> >> 
> >> The device tree is based on the CAF 4.4 kernel tree.
> >> 
> >> The device can be booted into the initrd with a shell over UART.
> >> 
> >> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> >[..]
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
> >b/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
> >> new file mode 100644
> >> index 000000000000..78b79c1076f1
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
> >> @@ -0,0 +1,17 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Copyright (c) 2018, Craig Tatlor. */
> >> +
> >> +&tlmm {
> >> +	blsp1_uart1_default: blsp1_uart1_default {
> >> +		pinmux {
> >> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> >> +			function = "gpio";
> >
> >Please put these in the sdm630.dtsi directly, rather than spreading the
> >pins out in a separate file.
> >
> Okay, just followed what 8996 did

I have started to rework that based on the last year's discussions, but
haven't posted any patches yet.

> >> +		};
> >> +
> >> +		pinconf {
> >> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> >> +			drive-strength = <2>;
> >> +			bias-disable;
> >
> >Please extend &blsp1_uart1_default in the pioneer dtsi with these
> >"electrical properties".
> Are you meaning to put this in the pioneer DTS or just drive strength and bias?

The drive-strength and bias are board-specific properties, so we want to
keep those in the board file, so I mean push the pinconf part into the
board dtsi.

[..]
> >> +		gcc: clock-controller at 100000 {
> >> +			compatible = "qcom,gcc-sdm660";
> >> +			#clock-cells = <1>;
> >> +			#reset-cells = <1>;
> >> +			#power-domain-cells = <1>;
> >> +			reg = <0x100000 0x94000>;
> >
> >Please 0-pad addresses in "reg", makes it easier to sort them as well
> >(but keep the @address after the node name unpadded)
> Sure, how much should I pad up to?

reg = <0x00100000 0xb0000>;

Regards,
Bjorn
