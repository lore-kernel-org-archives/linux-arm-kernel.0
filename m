From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 13 May 2013 14:07:02 +0300
Subject: [PATCH 3/6] ARM: tegra30: create a DT header defining CLK IDs
In-Reply-To: <1368443225-16978-1-git-send-email-hdoyu@nvidia.com>
References: <1368443225-16978-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1368443225-16978-4-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To replace magic number in tegra_car:

-               clocks = <&tegra_car 28>;
+               clocks = <&tegra_car CLK_HOST1X>;

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 .../bindings/clock/nvidia,tegra30-car.txt          | 209 +---------------
 include/dt-bindings/clk/tegra30-car.h              | 265 +++++++++++++++++++++
 2 files changed, 268 insertions(+), 206 deletions(-)
 create mode 100644 include/dt-bindings/clk/tegra30-car.h

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt
index f3da3be..10e1700 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt
@@ -3,6 +3,8 @@ NVIDIA Tegra30 Clock And Reset Controller
 This binding uses the common clock binding:
 Documentation/devicetree/bindings/clock/clock-bindings.txt
 
+You can find the actual assignment in "dt-bindings/clk/tegra30-car.h"
+
 The CAR (Clock And Reset) Controller on Tegra is the HW module responsible
 for muxing and gating Tegra's clocks, and setting their rates.
 
@@ -14,211 +16,6 @@ Required properties :
 - #clock-cells : Should be 1.
   In clock consumers, this cell represents the clock ID exposed by the CAR.
 
-  The first 130 clocks are numbered to match the bits in the CAR's CLK_OUT_ENB
-  registers. These IDs often match those in the CAR's RST_DEVICES registers,
-  but not in all cases. Some bits in CLK_OUT_ENB affect multiple clocks. In
-  this case, those clocks are assigned IDs above 160 in order to highlight
-  this issue. Implementations that interpret these clock IDs as bit values
-  within the CLK_OUT_ENB or RST_DEVICES registers should be careful to
-  explicitly handle these special cases.
-
-  The balance of the clocks controlled by the CAR are assigned IDs of 160 and
-  above.
-
-  0	cpu
-  1	unassigned
-  2	unassigned
-  3	unassigned
-  4	rtc
-  5	timer
-  6	uarta
-  7	unassigned	(register bit affects uartb and vfir)
-  8	gpio
-  9	sdmmc2
-  10	unassigned	(register bit affects spdif_in and spdif_out)
-  11	i2s1
-  12	i2c1
-  13	ndflash
-  14	sdmmc1
-  15	sdmmc4
-  16	unassigned
-  17	pwm
-  18	i2s2
-  19	epp
-  20	unassigned	(register bit affects vi and vi_sensor)
-  21	2d
-  22	usbd
-  23	isp
-  24	3d
-  25	unassigned
-  26	disp2
-  27	disp1
-  28	host1x
-  29	vcp
-  30	i2s0
-  31	cop_cache
-
-  32	mc
-  33	ahbdma
-  34	apbdma
-  35	unassigned
-  36	kbc
-  37	statmon
-  38	pmc
-  39	unassigned	(register bit affects fuse and fuse_burn)
-  40	kfuse
-  41	sbc1
-  42	nor
-  43	unassigned
-  44	sbc2
-  45	unassigned
-  46	sbc3
-  47	i2c5
-  48	dsia
-  49	unassigned	(register bit affects cve and tvo)
-  50	mipi
-  51	hdmi
-  52	csi
-  53	tvdac
-  54	i2c2
-  55	uartc
-  56	unassigned
-  57	emc
-  58	usb2
-  59	usb3
-  60	mpe
-  61	vde
-  62	bsea
-  63	bsev
-
-  64	speedo
-  65	uartd
-  66	uarte
-  67	i2c3
-  68	sbc4
-  69	sdmmc3
-  70	pcie
-  71	owr
-  72	afi
-  73	csite
-  74	pciex
-  75	avpucq
-  76	la
-  77	unassigned
-  78	unassigned
-  79	dtv
-  80	ndspeed
-  81	i2cslow
-  82	dsib
-  83	unassigned
-  84	irama
-  85	iramb
-  86	iramc
-  87	iramd
-  88	cram2
-  89	unassigned
-  90	audio_2x	a/k/a audio_2x_sync_clk
-  91	unassigned
-  92	csus
-  93	cdev2
-  94	cdev1
-  95	unassigned
-
-  96	cpu_g
-  97	cpu_lp
-  98	3d2
-  99	mselect
-  100	tsensor
-  101	i2s3
-  102	i2s4
-  103	i2c4
-  104	sbc5
-  105	sbc6
-  106	d_audio
-  107	apbif
-  108	dam0
-  109	dam1
-  110	dam2
-  111	hda2codec_2x
-  112	atomics
-  113	audio0_2x
-  114	audio1_2x
-  115	audio2_2x
-  116	audio3_2x
-  117	audio4_2x
-  118	audio5_2x
-  119	actmon
-  120	extern1
-  121	extern2
-  122	extern3
-  123	sata_oob
-  124	sata
-  125	hda
-  127	se
-  128	hda2hdmi
-  129	sata_cold
-
-  160	uartb
-  161	vfir
-  162	spdif_in
-  163	spdif_out
-  164	vi
-  165	vi_sensor
-  166	fuse
-  167	fuse_burn
-  168	cve
-  169	tvo
-
-  170	clk_32k
-  171	clk_m
-  172	clk_m_div2
-  173	clk_m_div4
-  174	pll_ref
-  175	pll_c
-  176	pll_c_out1
-  177	pll_m
-  178	pll_m_out1
-  179	pll_p
-  180	pll_p_out1
-  181	pll_p_out2
-  182	pll_p_out3
-  183	pll_p_out4
-  184	pll_a
-  185	pll_a_out0
-  186	pll_d
-  187	pll_d_out0
-  188	pll_d2
-  189	pll_d2_out0
-  190	pll_u
-  191	pll_x
-  192	pll_x_out0
-  193	pll_e
-  194	spdif_in_sync
-  195	i2s0_sync
-  196	i2s1_sync
-  197	i2s2_sync
-  198	i2s3_sync
-  199	i2s4_sync
-  200	vimclk
-  201	audio0
-  202	audio1
-  203	audio2
-  204	audio3
-  205	audio4
-  206	audio5
-  207	clk_out_1 (extern1)
-  208	clk_out_2 (extern2)
-  209	clk_out_3 (extern3)
-  210	sclk
-  211	blink
-  212	cclk_g
-  213	cclk_lp
-  214	twd
-  215	cml0
-  216	cml1
-  217	hclk
-  218	pclk
-
 Example SoC include file:
 
 / {
@@ -229,7 +26,7 @@ Example SoC include file:
 	};
 
 	usb at c5004000 {
-		clocks = <&tegra_car 58>; /* usb2 */
+		clocks = <&tegra_car TEGRA30_CLK_USB2>; /* usb2 */
 	};
 };
 
diff --git a/include/dt-bindings/clk/tegra30-car.h b/include/dt-bindings/clk/tegra30-car.h
new file mode 100644
index 0000000..594f61e
--- /dev/null
+++ b/include/dt-bindings/clk/tegra30-car.h
@@ -0,0 +1,265 @@
+/*
+ * This header provides constants for binding nvidia,tegra30-car.
+ *
+ * The first 130 clocks are numbered to match the bits in the CAR's CLK_OUT_ENB
+ * registers. These IDs often match those in the CAR's RST_DEVICES registers,
+ * but not in all cases. Some bits in CLK_OUT_ENB affect multiple clocks. In
+ * this case, those clocks are assigned IDs above 160 in order to highlight
+ * this issue. Implementations that interpret these clock IDs as bit values
+ * within the CLK_OUT_ENB or RST_DEVICES registers should be careful to
+ * explicitly handle these special cases.
+ *
+ * The balance of the clocks controlled by the CAR are assigned IDs of 160 and
+ * above.
+ */
+
+#ifndef _DT_BINDINGS_CLK_TEGRA30_CAR_H
+#define _DT_BINDINGS_CLK_TEGRA30_CAR_H
+
+#define TEGRA30_CLK_CPU 0
+/* 1 */
+/* 2 */
+/* 3 */
+#define TEGRA30_CLK_RTC 4
+#define TEGRA30_CLK_TIMER 5
+#define TEGRA30_CLK_UARTA 6
+/* 7 (register bit affects uartb and vfir) */
+#define TEGRA30_CLK_GPIO 8
+#define TEGRA30_CLK_SDMMC2 9
+/* 10 (register bit affects spdif_in and spdif_out) */
+#define TEGRA30_CLK_I2S1 11
+#define TEGRA30_CLK_I2C1 12
+#define TEGRA30_CLK_NDFLASH 13
+#define TEGRA30_CLK_SDMMC1 14
+#define TEGRA30_CLK_SDMMC4 15
+/* 16 */
+#define TEGRA30_CLK_PWM 17
+#define TEGRA30_CLK_I2S2 18
+#define TEGRA30_CLK_EPP 19
+/* 20 (register bit affects vi and vi_sensor) */
+#define TEGRA30_CLK_GR2D 21
+#define TEGRA30_CLK_USBD 22
+#define TEGRA30_CLK_ISP 23
+#define TEGRA30_CLK_GR3D 24
+/* 25 */
+#define TEGRA30_CLK_DISP2 26
+#define TEGRA30_CLK_DISP1 27
+#define TEGRA30_CLK_HOST1X 28
+#define TEGRA30_CLK_VCP 29
+#define TEGRA30_CLK_I2S0 30
+#define TEGRA30_CLK_COP_CACHE 31
+
+#define TEGRA30_CLK_MC 32
+#define TEGRA30_CLK_AHBDMA 33
+#define TEGRA30_CLK_APBDMA 34
+/* 35 */
+#define TEGRA30_CLK_KBC 36
+#define TEGRA30_CLK_STATMON 37
+#define TEGRA30_CLK_PMC 38
+/* 39 (register bit affects fuse and fuse_burn) */
+#define TEGRA30_CLK_KFUSE 40
+#define TEGRA30_CLK_SBC1 41
+#define TEGRA30_CLK_NOR 42
+/* 43 */
+#define TEGRA30_CLK_SBC2 44
+/* 45 */
+#define TEGRA30_CLK_SBC3 46
+#define TEGRA30_CLK_I2C5 47
+#define TEGRA30_CLK_DSIA 48
+/* 49 (register bit affects cve and tvo) */
+#define TEGRA30_CLK_MIPI 50
+#define TEGRA30_CLK_HDMI 51
+#define TEGRA30_CLK_CSI 52
+#define TEGRA30_CLK_TVDAC 53
+#define TEGRA30_CLK_I2C2 54
+#define TEGRA30_CLK_UARTC 55
+/* 56 */
+#define TEGRA30_CLK_EMC 57
+#define TEGRA30_CLK_USB2 58
+#define TEGRA30_CLK_USB3 59
+#define TEGRA30_CLK_MPE 60
+#define TEGRA30_CLK_VDE 61
+#define TEGRA30_CLK_BSEA 62
+#define TEGRA30_CLK_BSEV 63
+
+#define TEGRA30_CLK_SPEEDO 64
+#define TEGRA30_CLK_UARTD 65
+#define TEGRA30_CLK_UARTE 66
+#define TEGRA30_CLK_I2C3 67
+#define TEGRA30_CLK_SBC4 68
+#define TEGRA30_CLK_SDMMC3 69
+#define TEGRA30_CLK_PCIE 70
+#define TEGRA30_CLK_OWR 71
+#define TEGRA30_CLK_AFI 72
+#define TEGRA30_CLK_CSITE 73
+#define TEGRA30_CLK_PCIEX 74
+#define TEGRA30_CLK_AVPUCQ 75
+#define TEGRA30_CLK_LA 76
+/* 77 */
+/* 78 */
+#define TEGRA30_CLK_DTV 79
+#define TEGRA30_CLK_NDSPEED 80
+#define TEGRA30_CLK_I2CSLOW 81
+#define TEGRA30_CLK_DSIB 82
+/* 83 */
+#define TEGRA30_CLK_IRAMA 84
+#define TEGRA30_CLK_IRAMB 85
+#define TEGRA30_CLK_IRAMC 86
+#define TEGRA30_CLK_IRAMD 87
+#define TEGRA30_CLK_CRAM2 88
+/* 89 */
+#define TEGRA30_CLK_AUDIO_2X 90 /* a/k/a audio_2x_sync_clk */
+/* 91 */
+#define TEGRA30_CLK_CSUS 92
+#define TEGRA30_CLK_CDEV2 93
+#define TEGRA30_CLK_CDEV1 94
+/* 95 */
+
+#define TEGRA30_CLK_CPU_G 96
+#define TEGRA30_CLK_CPU_LP 97
+#define TEGRA30_CLK_GR3D2 98
+#define TEGRA30_CLK_MSELECT 99
+#define TEGRA30_CLK_TSENSOR 100
+#define TEGRA30_CLK_I2S3 101
+#define TEGRA30_CLK_I2S4 102
+#define TEGRA30_CLK_I2C4 103
+#define TEGRA30_CLK_SBC5 104
+#define TEGRA30_CLK_SBC6 105
+#define TEGRA30_CLK_D_AUDIO 106
+#define TEGRA30_CLK_APBIF 107
+#define TEGRA30_CLK_DAM0 108
+#define TEGRA30_CLK_DAM1 109
+#define TEGRA30_CLK_DAM2 110
+#define TEGRA30_CLK_HDA2CODEC_2X 111
+#define TEGRA30_CLK_ATOMICS 112
+#define TEGRA30_CLK_AUDIO0_2X 113
+#define TEGRA30_CLK_AUDIO1_2X 114
+#define TEGRA30_CLK_AUDIO2_2X 115
+#define TEGRA30_CLK_AUDIO3_2X 116
+#define TEGRA30_CLK_AUDIO4_2X 117
+#define TEGRA30_CLK_SPDIF_2X 118
+#define TEGRA30_CLK_ACTMON 119
+#define TEGRA30_CLK_EXTERN1 120
+#define TEGRA30_CLK_EXTERN2 121
+#define TEGRA30_CLK_EXTERN3 122
+#define TEGRA30_CLK_SATA_OOB 123
+#define TEGRA30_CLK_SATA 124
+#define TEGRA30_CLK_HDA 125
+/* 126 */
+#define TEGRA30_CLK_SE 127
+
+#define TEGRA30_CLK_HDA2HDMI 128
+#define TEGRA30_CLK_SATA_COLD 129
+/* 130 */
+/* 131 */
+/* 132 */
+/* 133 */
+/* 134 */
+/* 135 */
+/* 136 */
+/* 137 */
+/* 138 */
+/* 139 */
+/* 140 */
+/* 141 */
+/* 142 */
+/* 143 */
+/* 144 */
+/* 145 */
+/* 146 */
+/* 147 */
+/* 148 */
+/* 149 */
+/* 150 */
+/* 151 */
+/* 152 */
+/* 153 */
+/* 154 */
+/* 155 */
+/* 156 */
+/* 157 */
+/* 158 */
+/* 159 */
+
+#define TEGRA30_CLK_UARTB 160
+#define TEGRA30_CLK_VFIR 161
+#define TEGRA30_CLK_SPDIF_IN 162
+#define TEGRA30_CLK_SPDIF_OUT 163
+#define TEGRA30_CLK_VI 164
+#define TEGRA30_CLK_VI_SENSOR 165
+#define TEGRA30_CLK_FUSE 166
+#define TEGRA30_CLK_FUSE_BURN 167
+#define TEGRA30_CLK_CVE 168
+#define TEGRA30_CLK_TVO 169
+#define TEGRA30_CLK_CLK_32K 170
+#define TEGRA30_CLK_CLK_M 171
+#define TEGRA30_CLK_CLK_M_DIV2 172
+#define TEGRA30_CLK_CLK_M_DIV4 173
+#define TEGRA30_CLK_PLL_REF 174
+#define TEGRA30_CLK_PLL_C 175
+#define TEGRA30_CLK_PLL_C_OUT1 176
+#define TEGRA30_CLK_PLL_M 177
+#define TEGRA30_CLK_PLL_M_OUT1 178
+#define TEGRA30_CLK_PLL_P 179
+#define TEGRA30_CLK_PLL_P_OUT1 180
+#define TEGRA30_CLK_PLL_P_OUT2 181
+#define TEGRA30_CLK_PLL_P_OUT3 182
+#define TEGRA30_CLK_PLL_P_OUT4 183
+#define TEGRA30_CLK_PLL_A 184
+#define TEGRA30_CLK_PLL_A_OUT0 185
+#define TEGRA30_CLK_PLL_D 186
+#define TEGRA30_CLK_PLL_D_OUT0 187
+#define TEGRA30_CLK_PLL_D2 188
+#define TEGRA30_CLK_PLL_D2_OUT0 189
+#define TEGRA30_CLK_PLL_U 190
+#define TEGRA30_CLK_PLL_X 191
+
+#define TEGRA30_CLK_PLL_X_OUT0 192
+#define TEGRA30_CLK_PLL_E 193
+#define TEGRA30_CLK_SPDIF_IN_SYNC 194
+#define TEGRA30_CLK_I2S0_SYNC 195
+#define TEGRA30_CLK_I2S1_SYNC 196
+#define TEGRA30_CLK_I2S2_SYNC 197
+#define TEGRA30_CLK_I2S3_SYNC 198
+#define TEGRA30_CLK_I2S4_SYNC 199
+#define TEGRA30_CLK_VIMCLK_SYNC 200
+#define TEGRA30_CLK_AUDIO0 201
+#define TEGRA30_CLK_AUDIO1 202
+#define TEGRA30_CLK_AUDIO2 203
+#define TEGRA30_CLK_AUDIO3 204
+#define TEGRA30_CLK_AUDIO4 205
+#define TEGRA30_CLK_SPDIF 206
+#define TEGRA30_CLK_CLK_OUT_1 207 /* (extern1) */
+#define TEGRA30_CLK_CLK_OUT_2 208 /* (extern2) */
+#define TEGRA30_CLK_CLK_OUT_3 209 /* (extern3) */
+#define TEGRA30_CLK_SCLK 210
+#define TEGRA30_CLK_BLINK 211
+#define TEGRA30_CLK_CCLK_G 212
+#define TEGRA30_CLK_CCLK_LP 213
+#define TEGRA30_CLK_TWD 214
+#define TEGRA30_CLK_CML0 215
+#define TEGRA30_CLK_CML1 216
+#define TEGRA30_CLK_HCLK 217
+#define TEGRA30_CLK_PCLK 218
+/* 219 */
+/* 220 */
+/* 221 */
+/* 222 */
+/* 223 */
+
+/* 288 */
+/* 289 */
+/* 290 */
+/* 291 */
+/* 292 */
+/* 293 */
+/* 294 */
+/* 295 */
+/* 296 */
+/* 297 */
+/* 298 */
+/* 299 */
+#define TEGRA30_CLK_CLK_OUT_1_MUX 300
+#define TEGRA30_CLK_CLK_MAX 301
+
+#endif	/* _DT_BINDINGS_CLK_TEGRA30_CAR_H */
-- 
1.8.1.5
