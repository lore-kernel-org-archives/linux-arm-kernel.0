From: nyushchenko@dev.rtsoft.ru (Nikita Yushchenko)
Date: Mon, 23 Nov 2015 11:08:19 +0300
Subject: imx6dl clock setup incorrectness
In-Reply-To: <CAOMZO5DOwy1oDbNsEDmQ+a4EcCo7QOv0ZYsJ93gj=4oNUNqANA@mail.gmail.com>
References: <564DD51A.8040100@dev.rtsoft.ru>
 <CAOMZO5DOwy1oDbNsEDmQ+a4EcCo7QOv0ZYsJ93gj=4oNUNqANA@mail.gmail.com>
Message-ID: <5652C973.1020002@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

>> While working with board with imx6s cpu, with kernel based on linux-imx
>> imx_3.14.28_1.0.0_ga branch, I noticed this message in boot log:
>>
>>> failed to set parent of clk gpu2d_core_sel to pll2_pfd1_594m
>>
>>
>> I looked into it and found that:
>>
>> - CCM_CBCMR register layout is different between imx6q/imx6d and
>> imc6dl/imx6s (at least manuals state that)
>>
>> - clock setup in clk-imx6q.c (that is used both got imx6q/imx6d and
>> imx6dl/imx6s) creates gpu2d_core_sel clock object as described in imx6q
>> manual (i.e. using bits 18:19 of CCM_CBCMR register)
>>
>> - however per imx6dl manual, these bits contain different field
>> (mlb_sys_sel) on imx6dl/imx6s, and gpu2d_core sel is in bits 8:9
>>
>> - imx6q has different clock selector, gpu3d_shader_clk_sel, in bits 8:9,
>> and existing code unconditionally creates gpu3d_shader_clk_sel clock object
>>
>> - per manual, gpu3d_shader_clk_sel does not exist on imx6qdl/imx6s
>>
>> - however gpu driver (which also is common between imx6q/imx6d and
>> imc6dl/imx6s) does use gpu3d_shader_clk which is child of
>> gpu3d_shader_clk_sel. Which means that it is not possible to simply
>> change clock object creation code to match manuals.
>>
>>
>> I'm looking for advice how to fix this situation properly.
>>
>>
>> Btw situation is the same in mainline kernel - clock setup code in
>> mainline is moved to drivers/clk/imx/ but still has the same incorrectness.
> 
> Isn't this handled by the following commit?
> 
> commit 2e603ad98460fd0efab71e618d49a2ffc9aef67b
> Author: Dirk Behme <dirk.behme@de.bosch.com>
> Date:   Fri May 3 11:08:45 2013 +0200
> 
>     ARM: i.MX6: clk: add i.MX6 DualLite differences
> 
>     The CCM_CBCMR register (address 0x02C4018) has different meaning
>     between the i.MX6 Quad/Dual and the i.MX6 Solo/DualLite.
> 
>     Compared to the i.MX6 Quad/Dual, the CCM_CBCMR register in the
>     i.MX6 Solo/DualLite doesn't have a gpu3d_shader configuration and
>     moves the gpu2_core configuration at that place.
> 
>     Handle these i.MX6 Quad/Dual vs. i.MX6 Solo/DualLite clock differences
>     by using cpu_is_mx6dl().
> 
>     Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>     Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Ah I see.

With this patch, "gpu2d_clk" clk object is just reparented to "gpu3d_shader".

gpu3d_shader_clk_sel CCM_CBCMR field on imx6q is in bits 9:8. On this location imx6dl has gpu2d_core_sel field.

Thus reparenting "gpu2d_clk" to "gpu3d_shader" may look correct...  However I doubt it is.

Per manuals, bit meaning of imxq6's gpu3d_shader_clk_sel and imx6dl's gpu2d_core_sel is different:

- imx6q:

| 9?8 gpu3d_shader_clk_sel
| 
| Selector for gpu3d_shader clock multiplexer
| 00 derive clock from mmdc_ch0 clk
| 01 derive clock from pll3_sw_clk
| 10 derive clock from PFD 594M
| 11 derive clock from 720M PFD

- imx6dl:

| 9?8 gpu2d_core_sel
| Selector for gpu2d_core clock multiplexer
| 00 derive clock from mmdc_ch0 clk
| 01 derive clock from pll3_sw_clk
| 10 derive clock from PLL2 PFD1
| 11 derive clock from Reserved

Also, existing code does create "gpu3d_shader" clock on imx6dl, referencing register bits that, per imx6dl manual, contains gpu2d_core_podf field.

This clock *is* referenced in in-tree device tree file.
As of today, looks like this setting in not used by in-tree code. But it is used by out-fo-tree vivante gpu drivers.


Thus the inconsistency does exist: clock tree created for imx6dl does not match manual. This is misleading at least...  and likely causes a real error (gpu3d driver mangling with gpu2d clock) when out of tree driver gpu3d driver is used.

I guess fix could look something like

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index c193508..f11aab3 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -35,6 +35,7 @@ static const char *axi_sels[]		= { "periph", "pll2_pfd2_396m", "periph", "pll3_p
 static const char *audio_sels[]	= { "pll4_audio_div", "pll3_pfd2_508m", "pll3_pfd3_454m", "pll3_usb_otg", };
 static const char *gpu_axi_sels[]	= { "axi", "ahb", };
 static const char *gpu2d_core_sels[]	= { "axi", "pll3_usb_otg", "pll2_pfd0_352m", "pll2_pfd2_396m", };
+static const char *gpu2d_core_sels_dl[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "dummy", };
 static const char *gpu3d_core_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll2_pfd2_396m", };
 static const char *gpu3d_shader_sels[] = { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll3_pfd0_720m", };
 static const char *ipu_sels[]		= { "mmdc_ch0_axi", "pll2_pfd2_396m", "pll3_120m", "pll3_pfd1_540m", };
@@ -292,10 +293,11 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	if (clk_on_imx6q()) {
 		clk[IMX6QDL_CLK_GPU2D_AXI]        = imx_clk_mux("gpu2d_axi",        base + 0x18, 0,  1, gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
 		clk[IMX6QDL_CLK_GPU3D_AXI]        = imx_clk_mux("gpu3d_axi",        base + 0x18, 1,  1, gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
-	}
-	clk[IMX6QDL_CLK_GPU2D_CORE_SEL]   = imx_clk_mux("gpu2d_core_sel",   base + 0x18, 16, 2, gpu2d_core_sels,   ARRAY_SIZE(gpu2d_core_sels));
+		clk[IMX6QDL_CLK_GPU2D_CORE_SEL]   = imx_clk_mux("gpu2d_core_sel",   base + 0x18, 16, 2, gpu2d_core_sels,   ARRAY_SIZE(gpu2d_core_sels));
+		clk[IMX6QDL_CLK_GPU3D_SHADER_SEL] = imx_clk_mux("gpu3d_shader_sel", base + 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
+	} else
+		clk[IMX6QDL_CLK_GPU2D_CORE_SEL]   = imx_clk_mux("gpu2d_core_sel",   base + 0x18, 8,  2, gpu2d_core_sels_dl, ARRAY_SIZE(gpu2d_core_sels_dl));
 	clk[IMX6QDL_CLK_GPU3D_CORE_SEL]   = imx_clk_mux("gpu3d_core_sel",   base + 0x18, 4,  2, gpu3d_core_sels,   ARRAY_SIZE(gpu3d_core_sels));
-	clk[IMX6QDL_CLK_GPU3D_SHADER_SEL] = imx_clk_mux("gpu3d_shader_sel", base + 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
 	clk[IMX6QDL_CLK_IPU1_SEL]         = imx_clk_mux("ipu1_sel",         base + 0x3c, 9,  2, ipu_sels,          ARRAY_SIZE(ipu_sels));
 	clk[IMX6QDL_CLK_IPU2_SEL]         = imx_clk_mux("ipu2_sel",         base + 0x3c, 14, 2, ipu_sels,          ARRAY_SIZE(ipu_sels));
 	clk[IMX6QDL_CLK_LDB_DI0_SEL]      = imx_clk_mux_flags("ldb_di0_sel", base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_PARENT);
@@ -343,9 +345,12 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_SPDIF_PODF]       = imx_clk_divider("spdif_podf",       "spdif_pred",        base + 0x30, 22, 3);
 	clk[IMX6QDL_CLK_CAN_ROOT]         = imx_clk_divider("can_root",         "pll3_60m",          base + 0x20, 2,  6);
 	clk[IMX6QDL_CLK_ECSPI_ROOT]       = imx_clk_divider("ecspi_root",       "pll3_60m",          base + 0x38, 19, 6);
-	clk[IMX6QDL_CLK_GPU2D_CORE_PODF]  = imx_clk_divider("gpu2d_core_podf",  "gpu2d_core_sel",    base + 0x18, 23, 3);
 	clk[IMX6QDL_CLK_GPU3D_CORE_PODF]  = imx_clk_divider("gpu3d_core_podf",  "gpu3d_core_sel",    base + 0x18, 26, 3);
-	clk[IMX6QDL_CLK_GPU3D_SHADER]     = imx_clk_divider("gpu3d_shader",     "gpu3d_shader_sel",  base + 0x18, 29, 3);
+	if (clk_on_imx6q()) {
+		clk[IMX6QDL_CLK_GPU2D_CORE_PODF]  = imx_clk_divider("gpu2d_core_podf",  "gpu2d_core_sel",    base + 0x18, 23, 3);
+		clk[IMX6QDL_CLK_GPU3D_SHADER]     = imx_clk_divider("gpu3d_shader",     "gpu3d_shader_sel",  base + 0x18, 29, 3);
+	} else
+		clk[IMX6QDL_CLK_GPU2D_CORE_PODF]  = imx_clk_divider("gpu2d_core_podf",  "gpu2d_core_sel",    base + 0x18, 29, 3);
 	clk[IMX6QDL_CLK_IPU1_PODF]        = imx_clk_divider("ipu1_podf",        "ipu1_sel",          base + 0x3c, 11, 3);
 	clk[IMX6QDL_CLK_IPU2_PODF]        = imx_clk_divider("ipu2_podf",        "ipu2_sel",          base + 0x3c, 16, 3);
 	clk[IMX6QDL_CLK_LDB_DI0_DIV_3_5]  = imx_clk_fixed_factor("ldb_di0_div_3_5", "ldb_di0_sel", 2, 7);
@@ -409,14 +414,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem", "ahb",             base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_GPT_IPG]      = imx_clk_gate2("gpt_ipg",       "ipg",               base + 0x6c, 20);
 	clk[IMX6QDL_CLK_GPT_IPG_PER]  = imx_clk_gate2("gpt_ipg_per",   "ipg_per",           base + 0x6c, 22);
-	if (clk_on_imx6dl())
-		/*
-		 * The multiplexer and divider of imx6q clock gpu3d_shader get
-		 * redefined/reused as gpu2d_core_sel and gpu2d_core_podf on imx6dl.
-		 */
-		clk[IMX6QDL_CLK_GPU2D_CORE] = imx_clk_gate2("gpu2d_core", "gpu3d_shader", base + 0x6c, 24);
-	else
-		clk[IMX6QDL_CLK_GPU2D_CORE] = imx_clk_gate2("gpu2d_core", "gpu2d_core_podf", base + 0x6c, 24);
+	clk[IMX6QDL_CLK_GPU2D_CORE]   = imx_clk_gate2("gpu2d_core",    "gpu2d_core_podf",   base + 0x6c, 24);
 	clk[IMX6QDL_CLK_GPU3D_CORE]   = imx_clk_gate2("gpu3d_core",    "gpu3d_core_podf",   base + 0x6c, 26);
 	clk[IMX6QDL_CLK_HDMI_IAHB]    = imx_clk_gate2("hdmi_iahb",     "ahb",               base + 0x70, 0);
 	clk[IMX6QDL_CLK_HDMI_ISFR]    = imx_clk_gate2("hdmi_isfr",     "video_27m",         base + 0x70, 4);

however this will lead to gpu3d_shader_sel and gpu3d_shader clk objects not created on imx6dl, which can lead to unknown breakages.

Nikita
