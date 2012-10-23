From: pkunapuli@nvidia.com (Pavan Kunapuli)
Date: Tue, 23 Oct 2012 12:58:13 +0530
Subject: Deferring sdhci probe if regulators are not found
Message-ID: <C79B248886DD134989C8FF6B096A91AB7EC6B8C76D@BGMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Tegra sdhci platform driver currently enables the necessary gpios which will power on the SD host and sd/emmc cards. I have made changes to use vmmc and vqmmc regulators for the same.

During testing on some platforms, I observed that the there is a possibility of regulator driver probe being deferred due to dependencies on other modules like gpio etc. In such case, the vmmc and vqmmc regulators will not be available. MMC/SD cards will not work without enabling the regulators. To fix this, I am deferring sdhci probe if regulator_get() calls fail. The probe will continue when the regulators are present. With this change, mmc and SD cards are working properly.

However, this patch would require vmmc, vqmmc supplies to be registered either with a valid entry or a using dummy regulator entry for all platforms that use sdhci driver. I am aware of tegra platforms details and can add entries for the same. I don't know the details of other platforms which are using sdhci driver. I can try adding regulator_get() calls in the sdhci tegra platform driver and bypass the regulator_get calls in sdhci driver if the regulator structures are already present. This wouldn't effect non-tegra platforms. But, this is more of a hack and not a proper solution. I need suggestions on how to fix the issue properly without affecting other platforms. I have pushed patches with the above mentioned changes. I hope it helps in understanding better on what I am trying to do.

Regards,
Pavan.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/e913f343/attachment-0001.html>
