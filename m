From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 10 May 2017 15:43:55 -0700
Subject: [PATCH v2 1/5] pinctrl: qcom: Add ipq8074 pinctrl driver
In-Reply-To: <1493898841-20583-2-git-send-email-varada@codeaurora.org>
References: <1493898841-20583-1-git-send-email-varada@codeaurora.org>
 <1493898841-20583-2-git-send-email-varada@codeaurora.org>
Message-ID: <20170510224355.GE45273@Bjorns-MacBook-Pro-2.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 04 May 04:53 PDT 2017, Varadarajan Narayanan wrote:

> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for ipq8074.
> 
> Signed-off-by: Manoharan Vijaya Raghavan <mraghava@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  .../bindings/pinctrl/qcom,ipq8074-pinctrl.txt      |  187 +++
>  drivers/pinctrl/qcom/Kconfig                       |   10 +
>  drivers/pinctrl/qcom/Makefile                      |    1 +
>  drivers/pinctrl/qcom/pinctrl-ipq8074.c             | 1217 ++++++++++++++++++++
>  4 files changed, 1415 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq8074.c
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
[..]
> +- pins:
> +	Usage: required
> +	Value type: <string-array>
> +	Definition: List of gpio pins affected by the properties specified in
> +		    this subnode.  Valid pins are:
> +		    gpio0-gpio121,
> +		    sdc1_clk,
> +		    sdc1_cmd,
> +		    sdc1_data
> +		    sdc2_clk,
> +		    sdc2_cmd,
> +		    sdc2_data,
> +		    qdsd_cmd,
> +		    qdsd_data0,
> +		    qdsd_data1,
> +		    qdsd_data2,
> +		    qdsd_data3

These doesn't match the implementation.

> +
> +- function:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Specify the alternative function to be configured for the
> +		    specified pins. Functions are only valid for gpio pins.
> +		    Valid values are:
> +	gpio, qpic_pad, blsp5_i2c, blsp5_spi, wci20, blsp3_spi3,
> +	burn0, pcm_zsi0, blsp5_uart, mac12, blsp3_spi0, burn1, mac01,
> +	qdss_cti_trig_out_b0, qdss_cti_trig_in_b0, qpic_pad4,
> +	blsp4_uart0, blsp4_i2c0, blsp4_spi0, mac21,
> +	qdss_cti_trig_out_b1, qpic_pad5, qdss_cti_trig_in_b1,
> +	qpic_pad6, qpic_pad7, cxc0, mac13, qdss_cti_trig_in_a1,
> +	qdss_cti_trig_out_a1, wci22, qdss_cti_trig_in_a0, qpic_pad1,
> +	qdss_cti_trig_out_a0, qpic_pad2, qpic_pad3, qdss_traceclk_b,
> +	qpic_pad0, qdss_tracectl_b, qpic_pad8, pcm_zsi1,
> +	qdss_tracedata_b, led0, pwm04, led1, pwm14, led2, pwm24,
> +	pwm00, blsp4_uart1, blsp4_i2c1, blsp4_spi1, wci23, mac11,
> +	blsp3_spi2, pwm10, pwm20, pwm30, audio_txmclk, pwm02,
> +	audio_txbclk, pwm12, audio_txfsync, pwm22, audio_txd, pwm32,
> +	audio_rxmclk, pwm03, atest_char0, audio_rxbclk, pwm13,
> +	atest_char1, audio_rxfsync, pwm23, atest_char2, audio_rxd,
> +	pwm33, atest_char3, pcm_drx, mac10, mac00, pcm_dtx, pcm_fsync,
> +	mac20, qdss_traceclk_a, pcm_pclk, qdss_tracectl_a, atest_char,
> +	qdss_tracedata_a, blsp0_uart, blsp0_i2c, blsp0_spi,
> +	blsp1_uart, blsp1_i2c, blsp1_spi, blsp2_uart, blsp2_i2c,
> +	blsp2_spi, blsp3_uart, blsp3_i2c, blsp3_spi, pta2_0, wci21,
> +	cxc1, blsp3_spi1, pta2_1, pta2_2, pcie0_clk, dbg_out,
> +	cri_trng0, pcie0_rst, cri_trng1, pcie0_wake, cri_trng,
> +	pcie1_clk, rx2, ldo_update, pcie1_rst, ldo_en, pcie1_wake,
> +	gcc_plltest, sd_card, pwm01, pta1_1, pwm11, rx1, pta1_2,
> +	gcc_tlmm, pta1_0, pwm21, prng_rosc, sd_write, pwm31, rx0,
> +	tsens_max, mdc, mdio, NA

Please indent these to the same level as the description.

> +
[..]
> +
> +- output-high:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins are configured in output mode, driven
> +		    high.
> +		    Not valid for sdc pins.

If you don't have any sdc pins, drop this.

> +
> +- output-low:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins are configured in output mode, driven
> +		    low.
> +		    Not valid for sdc pins.

If you don't have any sdc pins, drop this.

> +
> +- drive-strength:
> +	Usage: optional
> +	Value type: <u32>
> +	Definition: Selects the drive strength for the specified pins, in mA.
> +		    Valid values are: 2, 4, 6, 8, 10, 12, 14 and 16
> +
[..]
> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq8074.c b/drivers/pinctrl/qcom/pinctrl-ipq8074.c
[..]
> +
> +enum ipq8074_functions {

Please keep these sorted alphabetically.

> +	msm_mux_gpio,
> +	msm_mux_qpic_pad,
> +	msm_mux_blsp5_i2c,
> +	msm_mux_blsp5_spi,
> +	msm_mux_wci20,

What does "20" mean here?

> +	msm_mux_blsp3_spi3,
> +	msm_mux_burn0,
> +	msm_mux_pcm_zsi0,
> +	msm_mux_blsp5_uart,
> +	msm_mux_mac12,

What does "12" mean here?

> +	msm_mux_blsp3_spi0,
> +	msm_mux_burn1,
> +	msm_mux_mac01,
> +	msm_mux_qdss_cti_trig_out_b0,
> +	msm_mux_qdss_cti_trig_in_b0,
> +	msm_mux_qpic_pad4,

What are qpic_pad and qpic_pad0 through qpic_pad8? Different functions,
alternative muxings...?

> +	msm_mux_blsp4_uart0,
> +	msm_mux_blsp4_i2c0,
> +	msm_mux_blsp4_spi0,
> +	msm_mux_mac21,
> +	msm_mux_qdss_cti_trig_out_b1,
> +	msm_mux_qpic_pad5,
> +	msm_mux_qdss_cti_trig_in_b1,
> +	msm_mux_qpic_pad6,
> +	msm_mux_qpic_pad7,
> +	msm_mux_cxc0,
> +	msm_mux_mac13,
> +	msm_mux_qdss_cti_trig_in_a1,
> +	msm_mux_qdss_cti_trig_out_a1,
> +	msm_mux_wci22,
> +	msm_mux_qdss_cti_trig_in_a0,
> +	msm_mux_qpic_pad1,
> +	msm_mux_qdss_cti_trig_out_a0,
> +	msm_mux_qpic_pad2,
> +	msm_mux_qpic_pad3,
> +	msm_mux_qdss_traceclk_b,
> +	msm_mux_qpic_pad0,
> +	msm_mux_qdss_tracectl_b,
> +	msm_mux_qpic_pad8,
> +	msm_mux_pcm_zsi1,
> +	msm_mux_qdss_tracedata_b,
> +	msm_mux_led0,
> +	msm_mux_pwm04,

What does "04" mean here?

> +	msm_mux_led1,
> +	msm_mux_pwm14,
> +	msm_mux_led2,
> +	msm_mux_pwm24,
> +	msm_mux_pwm00,
> +	msm_mux_blsp4_uart1,

Are uart0 vs uart1 alternative muxes?

[..]
> +static const struct msm_function ipq8074_functions[] = {

Please keep these sorted alphabetically too.

Regards,
Bjorn
