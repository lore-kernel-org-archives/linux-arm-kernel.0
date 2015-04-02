From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 02 Apr 2015 12:43:50 -0700
Subject: [GIT PULL] qcom SoC changes for v4.1
In-Reply-To: <42F2C5A0-5231-4D4B-95EE-7BC173A14768@codeaurora.org>
References: <alpine.DEB.2.02.1503161601450.30317@galak-ubuntu.qualcomm.com>
 <CAP71WjzKSRRSVLcwpZTaQOYp2uziP7=J=E=3bHAzCjui-ZqbYQ@mail.gmail.com>
 <42F2C5A0-5231-4D4B-95EE-7BC173A14768@codeaurora.org>
Message-ID: <551D9BF6.2070502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/15 12:25, Kumar Gala wrote:
> On Apr 2, 2015, at 3:37 AM, Nicolas Dechesne <nicolas.dechesne@linaro.org> wrote:
>
>> Andy, Kumar,
>>
>> On Mon, Mar 16, 2015 at 10:03 PM, Kumar Gala <galak@codeaurora.org> wrote:
>>> Andy Gross (1):
>>>      soc: qcom: gsbi: Add support for ADM CRCI muxing
>> this commit seems to break the boot on IFC6410, it was initially
>> reported on kernelci.org, see report and bootlog [1].
>>
>> running git bisect led me to:
>>
>> e5fdad68d47ed344832b7ca4e18b2e9708d8141e is the first bad commit
>> commit e5fdad68d47ed344832b7ca4e18b2e9708d8141e
>> Author: Andy Gross <agross@codeaurora.org>
>> Date:   Mon Feb 9 16:01:06 2015 -0600
>>
>>    soc: qcom: gsbi: Add support for ADM CRCI muxing
>>
>>    This patch adds automatic configuration for the ADM CRCI muxing required to
>>    support DMA operations for GSBI clients.  The GSBI mode and
>> instance determine
>>    the correct TCSR ADM CRCI MUX value that must be programmed so that the DMA
>>    works properly.
>>
>>    Signed-off-by: Andy Gross <agross@codeaurora.org>
>>    Signed-off-by: Kumar Gala <galak@codeaurora.org>
>>
>>
>> [1] http://kernelci.org/boot/all/job/arm-soc/kernel/v4.0-rc4-354-ga0690e6586df/
> I think we need to associated DT updates.
>
>

What about this patch squashed on top? Just guessing but I suspect we
don't care about cell-index if we're not doing the tcsr stuff. Also, I
imagine we could get rid of cell-index entirely if we matched against
the address of the gsbi instead.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

----8<-----

diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
index 09c669e70d63..ac7d71b6527d 100644
--- a/drivers/soc/qcom/qcom_gsbi.c
+++ b/drivers/soc/qcom/qcom_gsbi.c
@@ -139,7 +139,7 @@ static int gsbi_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct gsbi_info *gsbi;
 	int i;
-	u32 mask, gsbi_num;
+	u32 mask, gsbi_num = 0;
 	const struct crci_config *config = NULL;
 
 	gsbi = devm_kzalloc(&pdev->dev, sizeof(*gsbi), GFP_KERNEL);
@@ -166,16 +166,19 @@ static int gsbi_probe(struct platform_device *pdev)
 
 			of_node_put(tcsr_node);
 		}
-	}
 
-	if (of_property_read_u32(node, "cell-index", &gsbi_num)) {
-		dev_err(&pdev->dev, "missing cell-index\n");
-		return -EINVAL;
-	}
+		if (config) {
+			if (of_property_read_u32(node, "cell-index", &gsbi_num)) {
+				dev_err(&pdev->dev, "missing cell-index\n");
+				return -EINVAL;
+			}
+
+			if (gsbi_num < 1 || gsbi_num > MAX_GSBI) {
+				dev_err(&pdev->dev, "invalid cell-index\n");
+				return -EINVAL;
+			}
+		}
 
-	if (gsbi_num < 1 || gsbi_num > MAX_GSBI) {
-		dev_err(&pdev->dev, "invalid cell-index\n");
-		return -EINVAL;
 	}
 
 	if (of_property_read_u32(node, "qcom,mode", &gsbi->mode)) {

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
