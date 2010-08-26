From: yunpeng.gao@intel.com (Gao, Yunpeng)
Date: Thu, 26 Aug 2010 17:42:00 +0800
Subject: [RFC/PATCH 3/6] mmc: add general runtime PM support
In-Reply-To: <1281532770-27545-4-git-send-email-ohad@wizery.com>
References: <1281532770-27545-1-git-send-email-ohad@wizery.com>
	<1281532770-27545-4-git-send-email-ohad@wizery.com>
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A516CE8@shsmsx501.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>+static int mmc_runtime_suspend(struct device *dev)
>+{
>+	int status = 0;
>+	struct mmc_card *card = dev_to_mmc_card(dev);
>+
>+	mmc_power_save_host(card->host);
>+
>+	return status;
>+}

It seems the power_save callback is not implemented (Null pointer) yet for both mmc and sdio. Does it mean that the power_save callback will be implemented in future or just don't need at all? Thanks.

>+static int mmc_runtime_resume(struct device *dev)
>+{
>+	int status = 0;
>+	struct mmc_card *card = dev_to_mmc_card(dev);
>+
>+	mmc_power_restore_host(card->host);
>+
>+	return status;
>+}
>+
>+static int mmc_runtime_idle(struct device *dev)
>+{
>+	struct mmc_card *card = dev_to_mmc_card(dev);
>+
>+	return pm_runtime_suspend(dev);
>+}
>+
>+static const struct dev_pm_ops mmc_bus_pm_ops = {
>+	.runtime_suspend	= mmc_runtime_suspend,
>+	.runtime_resume		= mmc_runtime_resume,
>+	.runtime_idle		= mmc_runtime_idle,
>+};
>+
> static struct bus_type mmc_bus_type = {
> 	.name		= "mmc",
> 	.dev_attrs	= mmc_dev_attrs,
>@@ -146,6 +180,7 @@ static struct bus_type mmc_bus_type = {
> 	.remove		= mmc_bus_remove,
> 	.suspend	= mmc_bus_suspend,
> 	.resume		= mmc_bus_resume,
>+	.pm		= &mmc_bus_pm_ops,
> };
>
I think this is a good example to implement runtime PM support for mmc driver. But seems it doesn't provide a runtime PM example on host controller driver side. To my understanding, once the functions (mmc card or sdio devices) and mmc/sdio bus enter into rumtime suspend, it should then make the host controller enter into runtime suspend, too. Any ideas on how to achieve this? Thanks.

Best Regards,
Yunpeng Gao
