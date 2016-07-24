From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 24 Jul 2016 10:40:19 -0400
Subject: [PATCH 04/10] dmaending: qcom_hidma: configure DMA and MSI for OF
In-Reply-To: <20160724063312.GZ9681@localhost>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
 <1468867177-15007-5-git-send-email-okaya@codeaurora.org>
 <20160724063312.GZ9681@localhost>
Message-ID: <3e69f5d5-ce06-8912-cf15-42546fd243af@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/24/2016 2:33 AM, Vinod Koul wrote:
> On Tue, Jul 19, 2016 at 12:09:31AM +0530, Sinan Kaya wrote:
>> Configure the DMA bindings for the device tree based firmware.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/dma/qcom/hidma_mgmt.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
>> index c0e3653..fb30730 100644
>> --- a/drivers/dma/qcom/hidma_mgmt.c
>> +++ b/drivers/dma/qcom/hidma_mgmt.c
>> @@ -375,8 +375,10 @@ static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
>>                         ret = -ENODEV;
>>                         goto out;
>>                 }
>> +               of_node_get(child);
>> +               new_pdev->dev.of_node = child;
>>                 of_dma_configure(&new_pdev->dev, child);
>> -
>> +               of_msi_configure(&new_pdev->dev, child);
> 
> How would this work on non MSI platforms?
> 

The way it works is MSI on OF platforms relies on an optional msi-parent and msi-cells attribute
present in the device tree firmware. 

If these attributes do not exist, the function bails out. The function would create the MSI bindings
only if the correct attributes are present. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
