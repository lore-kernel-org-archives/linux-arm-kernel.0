From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 16 Jul 2018 11:54:27 +0200
Subject: [PATCH v2 2/2] pinctrl: meson-g12a: add pinctrl driver support
In-Reply-To: <4182fb4b-5ddb-cde6-7508-f1f1c52a4776@amlogic.com>
References: <20180714232754.5402-1-yixun.lan@amlogic.com>
 <20180714232754.5402-3-yixun.lan@amlogic.com>
 <1531671413.2708.223.camel@baylibre.com>
 <4182fb4b-5ddb-cde6-7508-f1f1c52a4776@amlogic.com>
Message-ID: <1531734867.12853.45.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > +/* uart_ao_a_ee */
> > > +static const unsigned int uart_ao_rx_a_c2_pins[]    = { GPIOC_2 };
> > > +static const unsigned int uart_ao_tx_a_c3_pins[]    = { GPIOC_3 };
> > 
> > Same comment as Martin about naming consistency ... drop c2 and c3 here.
> > 
> 
> there is already uart_ao_rx_a_pins[]  uart_ao_tx_a_pins[] , see
> 
>  794 static const unsigned int uart_ao_tx_a_pins[]           = {
> GPIOAO_0 };
>  795 static const unsigned int uart_ao_rx_a_pins[]           = {
> GPIOAO_1 };
> 
> in the G12A ASIC design, some AO device (from function perspective)
> route the pin to EE domain, for maximize pin mux utilization.
> 
> if you don't like this naming scheme, I could rename it into
>   uart_ao_rx_a_ee_pins[]
>   uart_ao_tx_a_ee_pins[]
> 

What we are asking when requesting consistency is to respect a scheme.

1) If the pin function is available only once:
    ${FUNCTION}_${PINFUNC}
2) If the pin function is available on the several banks
    ${FUNCTION}_${PINFUNC}_${BANK}
3)  If the pin function is available on the several pins of the same bank
    ${FUNCTION}_${PINfFUNC}_${BANK}${PINNUN}

Either your function is uart_ao_a_ee and it is available only once then
you should drop  c2 and c3

uart_ao_a_ee_rx and uart_ao_a_ee_tx

or the function is uart_ao_a which is available on ao and c bank then name
should be 

uart_ao_a_rx_c, uart_ao_a_tx_c,


> which mean uart_ao rx pin at port A route to EE domain's physical pin.
> 

[...]

> 
> > > c const unsigned int pwm_f_h_pins[]            = { GPIOH_5 };
> > > +
> > > +/* cec_ao_ee */
> > > +static const unsigned int cec_ao_a_ee_pins[]                = { GPIOH_3 };
> > > +static const unsigned int cec_ao_b_ee_pins[]                = { GPIOH_3 };
> > 
> > Naming consistency : cec_ao_ee_a ? cec_ao_ee_b ?
> > 
> 
> I'd prefer the original version, which mean cec_ao controller at port a
> route to EE domain's physical pin.
> 
> I would check this driver to see if there is inconsistency.

Then the function is CEC_AO not CEC_AO_EE.

Either the function is cec_ao_ee of cell A and B then name should be 

cec_ao_ee_a and cec_ao_ee_b

or function is cec_ao on bank H (also available on bank ao)

Then name should be cec_ao_a_h, cec_ao_b_h

Please choose.

> 
> 
> > > +
> > > +/* jtag_b */
> > > +static const unsigned int jtag_b_tdo_pins[]         = { GPIOC_0 };
> > > +static const unsigned int jtag_b_tdi_pins[]         = { GPIOC_1 };
> > > +static const unsigned int jtag_b_clk_pins[]         = { GPIOC_4 };
> > > +static const unsigned int jtag_b_tms_pins[]         = { GPIOC_5 };
> > > +
> > > +/* bt565 */
> > > +static const unsigned int bt565_a_vs_pins[]         = { GPIOZ_0 };
> > > +static const unsigned int bt565_a_hs_pins[]         = { GPIOZ_1 };
> > > +static const unsigned int bt565_a_clk_pins[]                = { GPIOZ_3 };
> > > +static const unsigned int bt565_a_din0_pins[]               = { GPIOZ_4 };
> > > +static const unsigned int bt565_a_din1_pins[]               = { GPIOZ_5 };
> > > +static const unsigned int bt565_a_din2_pins[]               = { GPIOZ_6 };
> > > +static const unsigned int bt565_a_din3_pins[]               = { GPIOZ_7 };
> > > +static const unsigned int bt565_a_din4_pins[]               = { GPIOZ_8 };
> > > +static const unsigned int bt565_a_din5_pins[]               = { GPIOZ_9 };
> > > +static const unsigned int bt565_a_din6_pins[]               = { GPIOZ_10 };
> > > +static const unsigned int bt565_a_din7_pins[]               = { GPIOZ_11 };
> > 
> > Why bt565_a and no bt565 only ?
> > 
> 
> After talking to Xingyu, this naming is actually taken from the pin mux
> documentation, it's BT565_A there.
> 
> I'm not sure if you insist to drop the _a suffix, personally I'd just
> leave it as it is, for better consistence with documentation.

Then function name should be bt565_a

> 
> 
> > > +
> > > +/* tsin_a */
> > > +static const unsigned int tsin_a_valid_pins[]               = { GPIOX_2 };
> > > +static const unsigned int tsin_a_sop_pins[]         = { GPIOX_1 };
> > > +static const unsigned int tsin_a_din0_pins[]                = { GPIOX_0 };
> > > +static const unsigned int tsin_a_clk_pins[]         = { GPIOX_3 };
> > > +
> > > +/* tsin_b */
> > > +static const unsigned int tsin_b_valid_x_pins[]             = { GPIOX_9 };
> > > +static const unsigned int tsin_b_sop_x_pins[]               = { GPIOX_8 };
> > > +static const unsigned int tsin_b_din0_x_pins[]              = { GPIOX_10 };
> > > +static const unsigned int tsin_b_clk_x_pins[]               = { GPIOX_11 };
> > > +
> > > +static const unsigned int tsin_b_valid_z_pins[]             = { GPIOZ_2 };
> > > +static const unsigned int tsin_b_sop_z_pins[]               = { GPIOZ_3 };
> > > +static const unsigned int tsin_b_din0_z_pins[]              = { GPIOZ_4 };
> > > +static const unsigned int tsin_b_clk_z_pins[]               = { GPIOZ_5 };
> > > +
> > > +static const unsigned int tsin_b_fail_pins[]                = { GPIOZ_6 };
> > > +static const unsigned int tsin_b_din1_pins[]                = { GPIOZ_7 };
> > > +static const unsigned int tsin_b_din2_pins[]                = { GPIOZ_8 };
> > > +static const unsigned int tsin_b_din3_pins[]                = { GPIOZ_9 };
> > > +static const unsigned int tsin_b_din4_pins[]                = { GPIOZ_10 };
> > > +static const unsigned int tsin_b_din5_pins[]                = { GPIOZ_11 };
> > > +static const unsigned int tsin_b_din6_pins[]                = { GPIOZ_12 };
> > > +static const unsigned int tsin_b_din7_pins[]                = { GPIOZ_13 };
> > > +
> > > +/* hdmitx */
> > > +static const unsigned int hdmitx_sda_pins[]         = { GPIOH_0 };
> > > +static const unsigned int hdmitx_sck_pins[]         = { GPIOH_1 };
> > > +static const unsigned int hdmitx_hpd_in_pins[]              = { GPIOH_2 };
> > > +
> > > +/* pdm */
> > > +static const unsigned int pdm_din0_c_pins[]         = { GPIOC_0 };
> > > +static const unsigned int pdm_din1_c_pins[]         = { GPIOC_1 };
> > > +static const unsigned int pdm_din2_c_pins[]         = { GPIOC_2 };
> > > +static const unsigned int pdm_din3_c_pins[]         = { GPIOC_3 };
> > > +static const unsigned int pdm_dclk_c_pins[]         = { GPIOC_4 };
> > > +
> > > +static const unsigned int pdm_din0_x_pins[]         = { GPIOX_0 };
> > > +static const unsigned int pdm_din1_x_pins[]         = { GPIOX_1 };
> > > +static const unsigned int pdm_din2_x_pins[]         = { GPIOX_2 };
> > > +static const unsigned int pdm_din3_x_pins[]         = { GPIOX_3 };
> > > +static const unsigned int pdm_dclk_x_pins[]         = { GPIOX_4 };
> > > +
> > > +static const unsigned int pdm_din0_z_pins[]         = { GPIOZ_2 };
> > > +static const unsigned int pdm_din1_z_pins[]         = { GPIOZ_3 };
> > > +static const unsigned int pdm_din2_z_pins[]         = { GPIOZ_4 };
> > > +static const unsigned int pdm_din3_z_pins[]         = { GPIOZ_5 };
> > > +static const unsigned int pdm_dclk_z_pins[]         = { GPIOZ_6 };
> > > +
> > > +static const unsigned int pdm_din0_a_pins[]         = { GPIOA_8 };
> > > +static const unsigned int pdm_din1_a_pins[]         = { GPIOA_9 };
> > > +static const unsigned int pdm_din2_a_pins[]         = { GPIOA_6 };
> > > +static const unsigned int pdm_din3_a_pins[]         = { GPIOA_5 };
> > > +static const unsigned int pdm_dclk_a_pins[]         = { GPIOA_7 };
> > > +
> > > +/* spdif_in */
> > > +static const unsigned int spdif_in_h_pins[]         = { GPIOH_5 };
> > > +static const unsigned int spdif_in_a10_pins[]               = { GPIOA_10 };
> > > +static const unsigned int spdif_in_a12_pins[]               = { GPIOA_12 };
> > > +
> > > +/* spdif_out */
> > > +static const unsigned int spdif_out_h_pins[]                = { GPIOH_4 };
> > > +static const unsigned int spdif_out_a11_pins[]              = { GPIOA_11 };
> > > +static const unsigned int spdif_out_a13_pins[]              = { GPIOA_13 };
> > > +
> > > +/* mclk0 */
> > > +static const unsigned int mclk0_a_pins[]            = { GPIOA_0 };
> > > +
> > > +/* mclk1 */
> > > +static const unsigned int mclk1_x_pins[]            = { GPIOX_5 };
> > > +static const unsigned int mclk1_z_pins[]            = { GPIOZ_8 };
> > > +static const unsigned int mclk1_a_pins[]            = { GPIOA_11 };
> > > +
> > > +/* tdma_in */
> > > +static const unsigned int tdma_slv_sclk_pins[]              = { GPIOX_11 };
> > > +static const unsigned int tdma_slv_fs_pins[]                = { GPIOX_10 };
> > > +static const unsigned int tdma_din0_pins[]          = { GPIOX_9 };
> > > +static const unsigned int tdma_din1_pins[]          = { GPIOX_8 };
> > > +
> > > +/* tdma_out */
> > > +static const unsigned int tdma_sclk_pins[]          = { GPIOX_11 };
> > > +static const unsigned int tdma_fs_pins[]            = { GPIOX_10 };
> > > +static const unsigned int tdma_dout0_pins[]         = { GPIOX_9 };
> > > +static const unsigned int tdma_dout1_pins[]         = { GPIOX_8 };
> > > +
> > > +/* tdmb_in */
> > > +static const unsigned int tdmb_slv_sclk_pins[]              = { GPIOA_1 };
> > > +static const unsigned int tdmb_slv_fs_pins[]                = { GPIOA_2 };
> > 
> > tdm slave and master don't belong in a tdmin group or tdmout group.
> > Both tdmin and tdmout use this clock. You should have only one function (tdm)
> > and not two 
> > 
> 
> there are a few comments relate to tdm iteam, let me rephase as
> following, see if it's correct
> 
> we could divide tdm funtion into four part (same in pinctrl driver):
> a) tdm clk
> b) tdm data out
> c) tdm clk slv
> d) tdm data in
> 
> the combination can be like this from the use case perspective:
> a + b, a + d, c + b, c + d
> 
> so in this patch, we could write as
> tdm_ao_b_clk_groups[]
> tdm_ao_b_clk_slv_groups[]
> tdm_ao_b_data_in_groups[]
> tdm_ao_b_data_out_groups[]
> 
> look into the pin mux documentation, the tdm_ao_b clock function is set
> by value=5, while tdm_ao_b clock_slv functioin is set by value=6.

I'm sorry but I don't agree with this.
When you create your sound DAI driver, your going to need all the pins. They
provide the TDM interface function. Data input pins of the TDM without the
clocks are useless. PDM is exactly the same and you've done it correctly.

Looks how it is done in the AXG.

> 
> > > +static const unsigned int tdmb_din0_pins[]          = { GPIOA_3 };
> > > +static const unsigned int tdmb_din1_pins[]          = { GPIOA_4 };
> > > +static const unsigned int tdmb_din2_pins[]          = { GPIOA_5 };
> > > +static const unsigned int tdmb_din3_a_pins[]                = { GPIOA_6 };
> > > +static const unsigned int tdmb_din3_h_pins[]                = { GPIOH_5 };
> > > +
> > > 

[...]

> > > +
> > > +/* uart_ao_a */
> > > +static const unsigned int uart_ao_tx_a_pins[]               = { GPIOAO_0 };
> > > +static const unsigned int uart_ao_rx_a_pins[]               = { GPIOAO_1 };
> > > +static const unsigned int uart_ao_cts_a_pins[]              = { GPIOE_0 };
> > > +static const unsigned int uart_ao_rts_a_pins[]              = { GPIOE_1 };
> > > +
> > 
> > consistency please: uart_ao_a_{tx,rx,cts,rts}
> 
> I'm confused here, just checked the naming scheme, previous
> in gxbb, gxl, we use:
>   drivers/pinctrl/meson/pinctrl-meson-gxbb.c
>   line 267: uart_tx_ao_a_pins[]
> 
> in axg (code I pushed), use:
>   drivers/pinctrl/meson/pinctrl-meson-axg.c
>   line 225: uart_ao_tx_b_z_pins[]
> 
> I do not against to change the naming scheme, so long as we could reach
> a agreement first, and if we do the change, should we fix the old code?
> (which will cause the DT change)

My bad. I was wrong about that one.
