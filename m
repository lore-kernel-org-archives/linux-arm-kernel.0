From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 18:00:03 +0800
Subject: [PATCH v3 3/5] clk: mediatek: Add subsystem clocks of MT8173
In-Reply-To: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1436522405-13923-4-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most multimedia subsystem clocks will be accessed by multiple
drivers, so it's a better way to manage these clocks in CCF.
This patch adds clock support for MM, IMG, VDEC, VENC and VENC_LT
subsystems.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8173.c      | 263 +++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/mt8173-clk.h |  91 +++++++++++-
 2 files changed, 352 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index b3d91ee..1d21e26 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -700,6 +700,183 @@ static const struct mtk_composite peri_clks[] __initconst = {
 	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
 };
 
+static const struct mtk_gate_regs cg_regs_4_8_0 = {
+	.set_ofs = 0x0004,
+	.clr_ofs = 0x0008,
+	.sta_ofs = 0x0000,
+};
+
+#define GATE_IMG(_id, _name, _parent, _shift) {			\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &cg_regs_4_8_0,				\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_setclr,		\
+	}
+
+static const struct mtk_gate img_clks[] __initconst = {
+	GATE_IMG(CLK_IMG_LARB2_SMI, "img_larb2_smi", "mm_sel", 0),
+	GATE_IMG(CLK_IMG_CAM_SMI, "img_cam_smi", "mm_sel", 5),
+	GATE_IMG(CLK_IMG_CAM_CAM, "img_cam_cam", "mm_sel", 6),
+	GATE_IMG(CLK_IMG_SEN_TG, "img_sen_tg", "camtg_sel", 7),
+	GATE_IMG(CLK_IMG_SEN_CAM, "img_sen_cam", "mm_sel", 8),
+	GATE_IMG(CLK_IMG_CAM_SV, "img_cam_sv", "mm_sel", 9),
+	GATE_IMG(CLK_IMG_FD, "img_fd", "mm_sel", 11),
+};
+
+static const struct mtk_gate_regs mm0_cg_regs = {
+	.set_ofs = 0x0104,
+	.clr_ofs = 0x0108,
+	.sta_ofs = 0x0100,
+};
+
+static const struct mtk_gate_regs mm1_cg_regs = {
+	.set_ofs = 0x0114,
+	.clr_ofs = 0x0118,
+	.sta_ofs = 0x0110,
+};
+
+#define GATE_MM0(_id, _name, _parent, _shift) {			\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &mm0_cg_regs,				\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_setclr,		\
+	}
+
+#define GATE_MM1(_id, _name, _parent, _shift) {			\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &mm1_cg_regs,				\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_setclr,		\
+	}
+
+static const struct mtk_gate mm_clks[] __initconst = {
+	/* MM0 */
+	GATE_MM0(CLK_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 0),
+	GATE_MM0(CLK_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 1),
+	GATE_MM0(CLK_MM_CAM_MDP, "mm_cam_mdp", "mm_sel", 2),
+	GATE_MM0(CLK_MM_MDP_RDMA0, "mm_mdp_rdma0", "mm_sel", 3),
+	GATE_MM0(CLK_MM_MDP_RDMA1, "mm_mdp_rdma1", "mm_sel", 4),
+	GATE_MM0(CLK_MM_MDP_RSZ0, "mm_mdp_rsz0", "mm_sel", 5),
+	GATE_MM0(CLK_MM_MDP_RSZ1, "mm_mdp_rsz1", "mm_sel", 6),
+	GATE_MM0(CLK_MM_MDP_RSZ2, "mm_mdp_rsz2", "mm_sel", 7),
+	GATE_MM0(CLK_MM_MDP_TDSHP0, "mm_mdp_tdshp0", "mm_sel", 8),
+	GATE_MM0(CLK_MM_MDP_TDSHP1, "mm_mdp_tdshp1", "mm_sel", 9),
+	GATE_MM0(CLK_MM_MDP_WDMA, "mm_mdp_wdma", "mm_sel", 11),
+	GATE_MM0(CLK_MM_MDP_WROT0, "mm_mdp_wrot0", "mm_sel", 12),
+	GATE_MM0(CLK_MM_MDP_WROT1, "mm_mdp_wrot1", "mm_sel", 13),
+	GATE_MM0(CLK_MM_FAKE_ENG, "mm_fake_eng", "mm_sel", 14),
+	GATE_MM0(CLK_MM_MUTEX_32K, "mm_mutex_32k", "rtc_sel", 15),
+	GATE_MM0(CLK_MM_DISP_OVL0, "mm_disp_ovl0", "mm_sel", 16),
+	GATE_MM0(CLK_MM_DISP_OVL1, "mm_disp_ovl1", "mm_sel", 17),
+	GATE_MM0(CLK_MM_DISP_RDMA0, "mm_disp_rdma0", "mm_sel", 18),
+	GATE_MM0(CLK_MM_DISP_RDMA1, "mm_disp_rdma1", "mm_sel", 19),
+	GATE_MM0(CLK_MM_DISP_RDMA2, "mm_disp_rdma2", "mm_sel", 20),
+	GATE_MM0(CLK_MM_DISP_WDMA0, "mm_disp_wdma0", "mm_sel", 21),
+	GATE_MM0(CLK_MM_DISP_WDMA1, "mm_disp_wdma1", "mm_sel", 22),
+	GATE_MM0(CLK_MM_DISP_COLOR0, "mm_disp_color0", "mm_sel", 23),
+	GATE_MM0(CLK_MM_DISP_COLOR1, "mm_disp_color1", "mm_sel", 24),
+	GATE_MM0(CLK_MM_DISP_AAL, "mm_disp_aal", "mm_sel", 25),
+	GATE_MM0(CLK_MM_DISP_GAMMA, "mm_disp_gamma", "mm_sel", 26),
+	GATE_MM0(CLK_MM_DISP_UFOE, "mm_disp_ufoe", "mm_sel", 27),
+	GATE_MM0(CLK_MM_DISP_SPLIT0, "mm_disp_split0", "mm_sel", 28),
+	GATE_MM0(CLK_MM_DISP_SPLIT1, "mm_disp_split1", "mm_sel", 29),
+	GATE_MM0(CLK_MM_DISP_MERGE, "mm_disp_merge", "mm_sel", 30),
+	GATE_MM0(CLK_MM_DISP_OD, "mm_disp_od", "mm_sel", 31),
+	/* MM1 */
+	GATE_MM1(CLK_MM_DISP_PWM0MM, "mm_disp_pwm0mm", "mm_sel", 0),
+	GATE_MM1(CLK_MM_DISP_PWM026M, "mm_disp_pwm026m", "pwm_sel", 1),
+	GATE_MM1(CLK_MM_DISP_PWM1MM, "mm_disp_pwm1mm", "mm_sel", 2),
+	GATE_MM1(CLK_MM_DISP_PWM126M, "mm_disp_pwm126m", "pwm_sel", 3),
+	GATE_MM1(CLK_MM_DSI0_ENGINE, "mm_dsi0_engine", "mm_sel", 4),
+	GATE_MM1(CLK_MM_DSI0_DIGITAL, "mm_dsi0_digital", "clk_null", 5),
+	GATE_MM1(CLK_MM_DSI1_ENGINE, "mm_dsi1_engine", "mm_sel", 6),
+	GATE_MM1(CLK_MM_DSI1_DIGITAL, "mm_dsi1_digital", "clk_null", 7),
+	GATE_MM1(CLK_MM_DPI_PIXEL, "mm_dpi_pixel", "dpi0_sel", 8),
+	GATE_MM1(CLK_MM_DPI_ENGINE, "mm_dpi_engine", "mm_sel", 9),
+	GATE_MM1(CLK_MM_DPI1_PIXEL, "mm_dpi1_pixel", "clk_null", 10),
+	GATE_MM1(CLK_MM_DPI1_ENGINE, "mm_dpi1_engine", "mm_sel", 11),
+	GATE_MM1(CLK_MM_HDMI_PIXEL, "mm_hdmi_pixel", "dpi0_sel", 12),
+	GATE_MM1(CLK_MM_HDMI_PLLCK, "mm_hdmi_pllck", "hdmi_sel", 13),
+	GATE_MM1(CLK_MM_HDMI_AUDIO, "mm_hdmi_audio", "apll1", 14),
+	GATE_MM1(CLK_MM_HDMI_SPDIF, "mm_hdmi_spdif", "apll2", 15),
+	GATE_MM1(CLK_MM_LVDS_PIXEL, "mm_lvds_pixel", "clk_null", 16),
+	GATE_MM1(CLK_MM_LVDS_CTS, "mm_lvds_cts", "clk_null", 17),
+	GATE_MM1(CLK_MM_SMI_LARB4, "mm_smi_larb4", "mm_sel", 18),
+	GATE_MM1(CLK_MM_HDMI_HDCP, "mm_hdmi_hdcp", "hdcp_sel", 19),
+	GATE_MM1(CLK_MM_HDMI_HDCP24M, "mm_hdmi_hdcp24m", "hdcp_24m_sel", 20),
+};
+
+static const struct mtk_gate_regs vdec0_cg_regs = {
+	.set_ofs = 0x0000,
+	.clr_ofs = 0x0004,
+	.sta_ofs = 0x0000,
+};
+
+static const struct mtk_gate_regs vdec1_cg_regs = {
+	.set_ofs = 0x0008,
+	.clr_ofs = 0x000c,
+	.sta_ofs = 0x0008,
+};
+
+#define GATE_VDEC0(_id, _name, _parent, _shift) {		\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &vdec0_cg_regs,				\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_setclr_inv,		\
+	}
+
+#define GATE_VDEC1(_id, _name, _parent, _shift) {		\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &vdec1_cg_regs,				\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_setclr_inv,		\
+	}
+
+static const struct mtk_gate vdec_clks[] __initconst = {
+	GATE_VDEC0(CLK_VDEC_CKEN, "vdec_cken", "vdec_sel", 0),
+	GATE_VDEC1(CLK_VDEC_LARB_CKEN, "vdec_larb_cken", "mm_sel", 0),
+};
+
+#define GATE_VENC(_id, _name, _parent, _shift) {		\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &cg_regs_4_8_0,				\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_setclr_inv,		\
+	}
+
+static const struct mtk_gate venc_clks[] __initconst = {
+	GATE_VENC(CLK_VENC_CKE0, "venc_cke0", "mm_sel", 0),
+	GATE_VENC(CLK_VENC_CKE1, "venc_cke1", "venc_sel", 4),
+	GATE_VENC(CLK_VENC_CKE2, "venc_cke2", "venc_sel", 8),
+	GATE_VENC(CLK_VENC_CKE3, "venc_cke3", "venc_sel", 12),
+};
+
+#define GATE_VENCLT(_id, _name, _parent, _shift) {		\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &cg_regs_4_8_0,				\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_setclr_inv,		\
+	}
+
+static const struct mtk_gate venclt_clks[] __initconst = {
+	GATE_VENCLT(CLK_VENCLT_CKE0, "venclt_cke0", "mm_sel", 0),
+	GATE_VENCLT(CLK_VENCLT_CKE1, "venclt_cke1", "venclt_sel", 4),
+};
+
 static struct clk_onecell_data *mt8173_top_clk_data;
 static struct clk_onecell_data *mt8173_pll_clk_data;
 
@@ -844,3 +1021,89 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 }
 CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8173-apmixedsys",
 		mtk_apmixedsys_init);
+
+static void __init mtk_imgsys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
+
+	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
+						clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, r);
+}
+CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt8173-imgsys", mtk_imgsys_init);
+
+static void __init mtk_mmsys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
+
+	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
+						clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, r);
+}
+CLK_OF_DECLARE(mtk_mmsys, "mediatek,mt8173-mmsys", mtk_mmsys_init);
+
+static void __init mtk_vdecsys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
+
+	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
+						clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, r);
+}
+CLK_OF_DECLARE(mtk_vdecsys, "mediatek,mt8173-vdecsys", mtk_vdecsys_init);
+
+static void __init mtk_vencsys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
+
+	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
+						clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, r);
+}
+CLK_OF_DECLARE(mtk_vencsys, "mediatek,mt8173-vencsys", mtk_vencsys_init);
+
+static void __init mtk_vencltsys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_VENCLT_NR_CLK);
+
+	mtk_clk_register_gates(node, venclt_clks, ARRAY_SIZE(venclt_clks),
+						clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, r);
+}
+CLK_OF_DECLARE(mtk_vencltsys, "mediatek,mt8173-vencltsys", mtk_vencltsys_init);
diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
index 4ad76ed..6ce88bf 100644
--- a/include/dt-bindings/clock/mt8173-clk.h
+++ b/include/dt-bindings/clock/mt8173-clk.h
@@ -158,8 +158,8 @@
 
 /* APMIXED_SYS */
 
-#define CLK_APMIXED_ARMCA15PLL	1
-#define CLK_APMIXED_ARMCA7PLL	2
+#define CLK_APMIXED_ARMCA15PLL		1
+#define CLK_APMIXED_ARMCA7PLL		2
 #define CLK_APMIXED_MAINPLL		3
 #define CLK_APMIXED_UNIVPLL		4
 #define CLK_APMIXED_MMPLL		5
@@ -232,4 +232,91 @@
 #define CLK_PERI_UART3_SEL		39
 #define CLK_PERI_NR_CLK			40
 
+/* IMG_SYS */
+
+#define CLK_IMG_LARB2_SMI		1
+#define CLK_IMG_CAM_SMI			2
+#define CLK_IMG_CAM_CAM			3
+#define CLK_IMG_SEN_TG			4
+#define CLK_IMG_SEN_CAM			5
+#define CLK_IMG_CAM_SV			6
+#define CLK_IMG_FD			7
+#define CLK_IMG_NR_CLK			8
+
+/* MM_SYS */
+
+#define CLK_MM_SMI_COMMON		1
+#define CLK_MM_SMI_LARB0		2
+#define CLK_MM_CAM_MDP			3
+#define CLK_MM_MDP_RDMA0		4
+#define CLK_MM_MDP_RDMA1		5
+#define CLK_MM_MDP_RSZ0			6
+#define CLK_MM_MDP_RSZ1			7
+#define CLK_MM_MDP_RSZ2			8
+#define CLK_MM_MDP_TDSHP0		9
+#define CLK_MM_MDP_TDSHP1		10
+#define CLK_MM_MDP_WDMA			11
+#define CLK_MM_MDP_WROT0		12
+#define CLK_MM_MDP_WROT1		13
+#define CLK_MM_FAKE_ENG			14
+#define CLK_MM_MUTEX_32K		15
+#define CLK_MM_DISP_OVL0		16
+#define CLK_MM_DISP_OVL1		17
+#define CLK_MM_DISP_RDMA0		18
+#define CLK_MM_DISP_RDMA1		19
+#define CLK_MM_DISP_RDMA2		20
+#define CLK_MM_DISP_WDMA0		21
+#define CLK_MM_DISP_WDMA1		22
+#define CLK_MM_DISP_COLOR0		23
+#define CLK_MM_DISP_COLOR1		24
+#define CLK_MM_DISP_AAL			25
+#define CLK_MM_DISP_GAMMA		26
+#define CLK_MM_DISP_UFOE		27
+#define CLK_MM_DISP_SPLIT0		28
+#define CLK_MM_DISP_SPLIT1		29
+#define CLK_MM_DISP_MERGE		30
+#define CLK_MM_DISP_OD			31
+#define CLK_MM_DISP_PWM0MM		32
+#define CLK_MM_DISP_PWM026M		33
+#define CLK_MM_DISP_PWM1MM		34
+#define CLK_MM_DISP_PWM126M		35
+#define CLK_MM_DSI0_ENGINE		36
+#define CLK_MM_DSI0_DIGITAL		37
+#define CLK_MM_DSI1_ENGINE		38
+#define CLK_MM_DSI1_DIGITAL		39
+#define CLK_MM_DPI_PIXEL		40
+#define CLK_MM_DPI_ENGINE		41
+#define CLK_MM_DPI1_PIXEL		42
+#define CLK_MM_DPI1_ENGINE		43
+#define CLK_MM_HDMI_PIXEL		44
+#define CLK_MM_HDMI_PLLCK		45
+#define CLK_MM_HDMI_AUDIO		46
+#define CLK_MM_HDMI_SPDIF		47
+#define CLK_MM_LVDS_PIXEL		48
+#define CLK_MM_LVDS_CTS			49
+#define CLK_MM_SMI_LARB4		50
+#define CLK_MM_HDMI_HDCP		51
+#define CLK_MM_HDMI_HDCP24M		52
+#define CLK_MM_NR_CLK			53
+
+/* VDEC_SYS */
+
+#define CLK_VDEC_CKEN			1
+#define CLK_VDEC_LARB_CKEN		2
+#define CLK_VDEC_NR_CLK			3
+
+/* VENC_SYS */
+
+#define CLK_VENC_CKE0			1
+#define CLK_VENC_CKE1			2
+#define CLK_VENC_CKE2			3
+#define CLK_VENC_CKE3			4
+#define CLK_VENC_NR_CLK			5
+
+/* VENCLT_SYS */
+
+#define CLK_VENCLT_CKE0			1
+#define CLK_VENCLT_CKE1			2
+#define CLK_VENCLT_NR_CLK		3
+
 #endif /* _DT_BINDINGS_CLK_MT8173_H */
-- 
1.8.1.1.dirty
