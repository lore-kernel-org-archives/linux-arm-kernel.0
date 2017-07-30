From: philippe.cornu@st.com (Philippe CORNU)
Date: Sun, 30 Jul 2017 09:10:29 +0000
Subject: [PATCH v6 1/7] drm/stm: ltdc: Fix leak of px clk enable in some
 error paths
In-Reply-To: <bd6aeb5d-8f39-3e5e-0f72-a1d50e4438ef@codeaurora.org>
References: <1500277223-29553-1-git-send-email-philippe.cornu@st.com>
 <1500277223-29553-2-git-send-email-philippe.cornu@st.com>
 <bd6aeb5d-8f39-3e5e-0f72-a1d50e4438ef@codeaurora.org>
Message-ID: <99a961b3-8549-1612-15e8-08f150cc8989@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/29/2017 04:32 PM, Archit Taneja wrote:
> Hi Philippe,
> 
> On 07/17/2017 01:10 PM, Philippe CORNU wrote:
>> The pixel clock gets enabled early during init, since it's required
>> in order to read registers. This pixel clock must be disabled if
>> errors during this init phase.
>>
> 
> This patch was pulled in to drm-misc-next, but it lacks your Sign-off.
> It looks like the Ack and the Sign-off got accidentally mixed up
> 

Hi Archit,
This patch is from Eric that is why I put his "signed-off-by" and I 
"acked" it to confirm that the patch is fine to me :-)

Nevertheless, as I am the patch "author" in the git tree, I confirm with 
my my below signed-off-by:

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>

Many thanks
Philippe :-)

> Can you please reply to this mail with your "Signed-off-by" so that
> we have proof of it on dri-devel?
> 
> Thanks,
> Archit
> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>   drivers/gpu/drm/stm/ltdc.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
>> index 5331760..7f64d5a 100644
>> --- a/drivers/gpu/drm/stm/ltdc.c
>> +++ b/drivers/gpu/drm/stm/ltdc.c
>> @@ -1045,13 +1045,15 @@ int ltdc_load(struct drm_device *ddev)
>>       if (of_address_to_resource(np, 0, &res)) {
>>           DRM_ERROR("Unable to get resource\n");
>> -        return -ENODEV;
>> +        ret = -ENODEV;
>> +        goto err;
>>       }
>>       ldev->regs = devm_ioremap_resource(dev, &res);
>>       if (IS_ERR(ldev->regs)) {
>>           DRM_ERROR("Unable to get ltdc registers\n");
>> -        return PTR_ERR(ldev->regs);
>> +        ret = PTR_ERR(ldev->regs);
>> +        goto err;
>>       }
>>       for (i = 0; i < MAX_IRQ; i++) {
>> @@ -1064,7 +1066,7 @@ int ltdc_load(struct drm_device *ddev)
>>                           dev_name(dev), ddev);
>>           if (ret) {
>>               DRM_ERROR("Failed to register LTDC interrupt\n");
>> -            return ret;
>> +            goto err;
>>           }
>>       }
>> @@ -1079,7 +1081,7 @@ int ltdc_load(struct drm_device *ddev)
>>       if (ret) {
>>           DRM_ERROR("hardware identifier (0x%08x) not supported!\n",
>>                 ldev->caps.hw_version);
>> -        return ret;
>> +        goto err;
>>       }
>>       DRM_INFO("ltdc hw version 0x%08x - ready\n", 
>> ldev->caps.hw_version);
>>
> 
