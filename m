From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 4 Oct 2017 14:45:32 -0700
Subject: [PATCH 1/2] arm64: qcom: sbc: Name GPIO lines
In-Reply-To: <20171003091155.7138-1-linus.walleij@linaro.org>
References: <20171003091155.7138-1-linus.walleij@linaro.org>
Message-ID: <20171004214532.GZ457@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03, Linus Walleij wrote:
> This names the GPIO lines on the APQ8016 "SBC" also known
> as the DragonBoard 410c, according to the schematic. This
> is necessary for a conforming userspace looking across
> all GPIO chips for the GPIO lines named "GPIO-A" thru
> "GPIO-L".
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I don't have this hardware available, you can test it
> easily by compiling tools/gpio/* and issue "lsgpio" to
> see the GPIO line names in the console.
> 
> Please apply this even if you're not applying the second
> patch renaming the DTS files.
> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 167 +++++++++++++++++++++++++++++++

Can you add this to the apq8016-sbc.dtsi file instead? Probably
we should fold the two files together, but so far nothing goes
into the .dts file besides compatible string and model for the
board.

>  1 file changed, 167 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> index 825f489a2af7..40b0d62861bb 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> @@ -19,3 +19,170 @@
>  	model = "Qualcomm Technologies, Inc. APQ 8016 SBC";
>  	compatible = "qcom,apq8016-sbc", "qcom,apq8016", "qcom,sbc";
>  };
> +
> +/*
> + * Legend: proper name = the GPIO line is used as GPIO
> + *         NC = not connected (pin out but not routed from the chip to
> + *              anything the board)
> + *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
> + *         "" = no idea, schematic doesn't say, could be
> + *              unrouted (not connected to any external pin)

This never happens?

> + *         LSEC = Low Speed External Connector
> + *         HSEC = High Speed External Connector

This is not in the patch?

> + *
> + * Line names are taken from the schematic "DragonBoard410c"
> + * dated monday, august 31, 2015. Page 5 in particular.
> + *
> + * For the lines routed to the external connectors the
> + * lines are named after the 96Boards CE Specification 1.0,
> + * Appendix "Expansion Connector Signal Description".
> + *
> + * When the 96Board naming of a line and the schematic name of
> + * the same line are in conflict, the 96Board specification
> + * takes precedence, which means that the external UART on the
> + * LSEC is named UART0 while the schematic and SoC names this
> + * UART3. This is only for the informational lines i.e. "[FOO]",
> + * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
> + * ones actually used for GPIO.
> + */
> +&msmgpio {

And also not use phandles and put the gpio-line-names into the
node at the correct path?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
