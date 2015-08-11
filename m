From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 11 Aug 2015 16:56:33 +0200
Subject: [PATCH v4 4/6] memory: mediatek: Add SMI driver
In-Reply-To: <1438597279-2937-5-git-send-email-yong.wu@mediatek.com>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
 <1438597279-2937-5-git-send-email-yong.wu@mediatek.com>
Message-ID: <20150811145633.GE14980@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 06:21:17PM +0800, Yong Wu wrote:
> +static int mtk_smi_common_get(struct device *smidev)
> +{
> +	struct mtk_smi_common *smipriv = dev_get_drvdata(smidev);
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(smidev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_prepare_enable(smipriv->clk_apb);
> +	if (ret) {
> +		dev_err(smidev, "Failed to enable the apb clock\n");
> +		goto err_put_pm;
> +	}
> +	ret = clk_prepare_enable(smipriv->clk_smi);
> +	if (ret) {
> +		dev_err(smidev, "Failed to enable the smi clock\n");
> +		goto err_disable_apb;
> +	}
> +	return ret;
> +
> +err_disable_apb:
> +	clk_disable_unprepare(smipriv->clk_apb);
> +err_put_pm:
> +	pm_runtime_put(smidev);
> +	return ret;
> +}

[...]

> +int mtk_smi_larb_get(struct device *larbdev)
> +{
> +	struct mtk_smi_larb *larbpriv = dev_get_drvdata(larbdev);
> +	struct mtk_larb_mmu *mmucfg = larbdev->archdata.iommu;
> +	int ret;
> +
> +	ret = mtk_smi_common_get(larbpriv->smi);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_get_sync(larbdev);
> +	if (ret < 0)
> +		goto err_put_smicommon;
> +
> +	ret = clk_prepare_enable(larbpriv->clk_apb);
> +	if (ret) {
> +		dev_err(larbdev, "Failed to enable the apb clock\n");
> +		goto err_put_pm;
> +	}
> +
> +	ret = clk_prepare_enable(larbpriv->clk_smi);
> +	if (ret) {
> +		dev_err(larbdev, "Failed to enable the smi clock\n");
> +		goto err_disable_apb;
> +	}

The clock enablement looks similar to the function above, maybe move it
to a helper function?


	Joerg
