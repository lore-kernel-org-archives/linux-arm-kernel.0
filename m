From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 14 Nov 2018 14:17:14 +0100
Subject: [PATCH v2 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
In-Reply-To: <20181114131627.17766-1-narmstrong@baylibre.com>
References: <20181114131627.17766-1-narmstrong@baylibre.com>
Message-ID: <75ca31ca-82f4-c9e9-0d73-29fde405c47c@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/2018 14:16, Neil Armstrong wrote:
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clocks frequencyies.
> The precision is determined by stepping into the divider until the counter
> overflows.
> The debugfs slows a pretty summary and each clock can be measured
> individually aswell.
> 
> Thsi patchset includes the dt-bindings, driver and the DT node added to the
> meson-gx dtsi.
> 
> Changes since v1 at [1]:
> - fixed clock names
> - added summary in debugfs and moved indivudual clocks into a subdirectory
> - added the GX table to the match data
> 
> Neil Armstrong (3):
>   dt-bindings: amlogic: Add Internal Clock Measurer bindings
>   soc: amlogic: Add Meson GX Clock Measure driver
>   ARM64: dts: meson-gx: Add Internal Clock Measurer node
> 
>  .../bindings/soc/amlogic/clk-measure.txt      |  15 +
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   5 +
>  drivers/soc/amlogic/Kconfig                   |   8 +
>  drivers/soc/amlogic/Makefile                  |   1 +
>  drivers/soc/amlogic/meson-gx-clk-measure.c    | 293 ++++++++++++++++++
>  5 files changed, 322 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
> 

For example, the debugfs summary looks like :

# cat /sys/kernel/debug/meson-clk-msr/measure_summary
  clock                     rate    precision
---------------------------------------------
 ring_osc_out_ee_0             0    +/-3125Hz
 ring_osc_out_ee_1             0    +/-3125Hz
 ring_osc_out_ee_2             0    +/-3125Hz
 a53_ring_osc                  0    +/-3125Hz
 gp0_pll                       0    +/-3125Hz
 enci                   26998438    +/-3125Hz
 clk81                 166661458    +/-5208Hz
 encp                          0    +/-3125Hz
 encl                          0    +/-3125Hz
 vdac                   26998438    +/-3125Hz
 rgmii_tx                      0    +/-3125Hz
 pdm                           0    +/-3125Hz
 amclk                         0    +/-3125Hz
 fec_0                         0    +/-3125Hz
 fec_1                         0    +/-3125Hz
 fec_2                         0    +/-3125Hz
 sys_pll_div16                 0    +/-3125Hz
 sys_cpu_div16                 0    +/-3125Hz
 hdmitx_sys             24000000    +/-3125Hz
 rtc_osc_out               32813    +/-3125Hz
 i2s_in_src0                   0    +/-3125Hz
 eth_phy_ref                   0    +/-3125Hz
 hdmi_todig                    0    +/-3125Hz
 sc_int                        0    +/-3125Hz
 sar_adc                 1195313    +/-3125Hz
 mpll_test_out                 0    +/-3125Hz
 vdec                          0    +/-3125Hz
 mali                          0    +/-3125Hz
 hdmi_tx_pixel                 0    +/-3125Hz
 i958                          0    +/-3125Hz
 vdin_meas            1484656250    +/-62500Hz
 pcm_sclk                      0    +/-3125Hz
 pcm_mclk                      0    +/-3125Hz
 eth_rx_or_rmii         50000000    +/-3125Hz
 mp0_out                       0    +/-3125Hz
 fclk_div5                     0    +/-3125Hz
 pwm_b                  24000000    +/-3125Hz
 pwm_a                         0    +/-3125Hz
 vpu                   666625000    +/-20833Hz
 ddr_dpll_pt                   0    +/-3125Hz
 mp1_out                       0    +/-3125Hz
 mp2_out                       0    +/-3125Hz
 mp3_out                       0    +/-3125Hz
 nand_core              24000000    +/-3125Hz
 sd_emmc_b                     0    +/-3125Hz
 sd_emmc_a                     0    +/-3125Hz
 vid_pll_div_out      1484843750    +/-62500Hz
 cci                           0    +/-3125Hz
 wave420l_c                    0    +/-3125Hz
 wave420l_b                    0    +/-3125Hz
 hcodec                        0    +/-3125Hz
 alt_32k                       0    +/-3125Hz
 gpio_msr                      0    +/-3125Hz
 hevc                          0    +/-3125Hz
 vid_lock                      0    +/-3125Hz
 pwm_f                         0    +/-3125Hz
 pwm_e                         0    +/-3125Hz
 pwm_d                  23984375    +/-3125Hz
 pwm_c                         0    +/-3125Hz
 aoclkx2_int                   0    +/-3125Hz
 aoclk_int                     0    +/-3125Hz
 rng_ring_osc_0         66746875    +/-3125Hz
 rng_ring_osc_1         58442188    +/-3125Hz
 rng_ring_osc_2         52098438    +/-3125Hz
 rng_ring_osc_3         46662500    +/-3125Hz
 vapb                  249996094    +/-7812Hz
 ge2d                  249992188    +/-7812Hz

On the AML-S905X-CC board.

Neil
