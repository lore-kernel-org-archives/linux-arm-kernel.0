From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Mon,  9 Oct 2017 15:11:46 +0100
Subject: [PATCH v3 1/7] nvmem: imx-ocotp: Restrict OTP write to IMX6 processors
In-Reply-To: <1507558312-20580-1-git-send-email-pure.logic@nexus-software.ie>
References: <1507558312-20580-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1507558312-20580-2-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX7S/D have a different scheme for addressing the OTP registers inside
the OCOTP block. Currently it's possible to address the wrong OTP registers
given the disparity between IMX6 and IMX7 OTP addressing.

Since OTP programming is one-time destructive its important we restrict
this interface ASAP.

Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/nvmem/imx-ocotp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 193ca8f..17d160f 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -347,6 +347,8 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	imx_ocotp_nvmem_config.dev = dev;
 	imx_ocotp_nvmem_config.priv = priv;
 	priv->config = &imx_ocotp_nvmem_config;
+	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx7d-ocotp"))
+		imx_ocotp_nvmem_config.read_only = true;
 	nvmem = nvmem_register(&imx_ocotp_nvmem_config);
 
 	if (IS_ERR(nvmem))
-- 
2.7.4
