From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 12 Jun 2015 19:09:02 +0200
Subject: [PATCH 4/5] clk: mediatek: Add subsystem clocks of MT8173
In-Reply-To: <1432192376-6712-5-git-send-email-jamesjj.liao@mediatek.com>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-5-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <5809360.66NP4oPW1R@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 21, 2015 03:12:55 PM James Liao wrote:
> Most multimedia subsystem clocks will be accessed by multiple
> drivers, so it's a better way to manage these clocks in CCF.
> This patch adds clock support for MM, IMG, VDEC, VENC and VENC_LT
> subsystems.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt8173.c      | 310
> +++++++++++++++++++++++++++++++++ include/dt-bindings/clock/mt8173-clk.h | 
> 87 +++++++++
>  2 files changed, 397 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8173.c
> b/drivers/clk/mediatek/clk-mt8173.c index eb175ac..e2f40ba 100644
> --- a/drivers/clk/mediatek/clk-mt8173.c
> +++ b/drivers/clk/mediatek/clk-mt8173.c
> @@ -700,6 +700,195 @@ static const struct mtk_composite peri_clks[]
> __initconst = { MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel",
> uart_ck_sel_parents, 0x40c, 3, 1), };
> 
> +static struct mtk_gate_regs img_cg_regs = {
> +	.set_ofs = 0x0004,
> +	.clr_ofs = 0x0008,
> +	.sta_ofs = 0x0000,
> +};
> +
> +#define GATE_IMG(_id, _name, _parent, _shift) {	\
> +		.id = _id,					\
> +		.name = _name,					\
> +		.parent_name = _parent,				\
> +		.regs = &img_cg_regs,				\
> +		.shift = _shift,				\
> +		.ops = &mtk_clk_gate_ops_setclr,			\
> +	}
> +
[...]
> +
> +static struct mtk_gate_regs venc_cg_regs = {
> +	.set_ofs = 0x0004,
> +	.clr_ofs = 0x0008,
> +	.sta_ofs = 0x0000,
> +};
> +
> +#define GATE_VENC(_id, _name, _parent, _shift) {	\
> +		.id = _id,					\
> +		.name = _name,					\
> +		.parent_name = _parent,				\
> +		.regs = &venc_cg_regs,				\
> +		.shift = _shift,				\
> +		.ops = &mtk_clk_gate_ops_setclr_inv,		\
> +	}
> +
> +static struct mtk_gate venc_clks[] __initdata = {
> +	GATE_VENC(CLK_VENC_CKE0, "venc_cke0", "mm_sel", 0),
> +	GATE_VENC(CLK_VENC_CKE1, "venc_cke1", "venc_sel", 4),
> +	GATE_VENC(CLK_VENC_CKE2, "venc_cke2", "venc_sel", 8),
> +	GATE_VENC(CLK_VENC_CKE3, "venc_cke3", "venc_sel", 12),
> +};
> +
> +static struct mtk_gate_regs venclt_cg_regs = {
> +	.set_ofs = 0x0004,
> +	.clr_ofs = 0x0008,
> +	.sta_ofs = 0x0000,
> +};


The register for imagesys, vencsys and vencltsys have all the same offset.
We could use just one struct for all of them. 

Cheers,
Matthias
