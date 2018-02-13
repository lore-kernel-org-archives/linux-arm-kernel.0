From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 13 Feb 2018 10:24:47 +0100
Subject: [PATCH v3 2/5] clk: mediatek: modify MT7622 audsys to adapt MFD
 device
In-Reply-To: <f8e87179bd7700130e294393592719fac8590c59.1518424204.git.ryder.lee@mediatek.com>
References: <cover.1518424204.git.ryder.lee@mediatek.com>
 <f8e87179bd7700130e294393592719fac8590c59.1518424204.git.ryder.lee@mediatek.com>
Message-ID: <cb75cdaa-eb84-d01e-60bd-21a928ddc090@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/12/2018 12:28 PM, Ryder Lee wrote:
> As the new MFD device is in place, switch probing method to adapt it.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt7622-aud.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
> index 13f752d..68c52a9 100644
> --- a/drivers/clk/mediatek/clk-mt7622-aud.c
> +++ b/drivers/clk/mediatek/clk-mt7622-aud.c
> @@ -142,11 +142,16 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
>  {
>  	struct clk_onecell_data *clk_data;
>  	struct device_node *node = pdev->dev.of_node;
> +	struct device_node *pnode = pdev->dev.parent->of_node;
>  	int r;
>  
>  	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
>  
> -	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
> +	/* Check if called from MFD */
> +	if (!pnode)
> +		pnode = node;

This is needed for backwards compatibility, correct?
Please change the comment accordingly. The same holds for mt2701 driver.

Thanks,
Matthias

> +
> +	mtk_clk_register_gates(pnode, audio_clks, ARRAY_SIZE(audio_clks),
>  			       clk_data);
>  
>  	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> 
