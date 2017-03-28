From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 28 Mar 2017 17:26:32 +0900
Subject: [PATCH v5 3/5] drm/exynos: dsi: Fix the parse_dt function
In-Reply-To: <93e79e92-a102-e931-8d63-843031848888@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p2d2f7a0f768082b7a54b2ebe260e78436@epcas1p2.samsung.com>
 <1488948852-5380-4-git-send-email-hoegeun.kwon@samsung.com>
 <93e79e92-a102-e931-8d63-843031848888@samsung.com>
Message-ID: <58DA1E38.50907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Merged.

Thanks,
Inki Dae

2017? 03? 22? 10:36? Hoegeun Kwon ?(?) ? ?:
> Hi inki,
> 
> Could you check the this patch?
> For reference, patch 1/5 and 2/5 have already been applied to Krzysztof tree.
> 
> Best regards,
> Hoegeun
> 
> 
> On 03/08/2017 01:54 PM, Hoegeun Kwon wrote:
>> The dsi + panel is a parental relationship, so OF grpah is not needed.
>> Therefore, the current dsi_parse_dt function will throw an error,
>> because there is no linked OF graph for the case fimd + dsi + panel.
>>
>> Parse the Pll burst and esc clock frequency properties in dsi_parse_dt()
>> and create a bridge_node only if there is an OF graph associated with dsi.
>>
>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
>> ---
>>   drivers/gpu/drm/exynos/exynos_drm_dsi.c | 32 ++++++++------------------------
>>   1 file changed, 8 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> index f5c04d0..2d4e118 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> @@ -1652,39 +1652,23 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
>>       if (ret < 0)
>>           return ret;
>>   -    ep = of_graph_get_endpoint_by_regs(node, DSI_PORT_OUT, 0);
>> -    if (!ep) {
>> -        dev_err(dev, "no output port with endpoint specified\n");
>> -        return -EINVAL;
>> -    }
>> -
>> -    ret = exynos_dsi_of_read_u32(ep, "samsung,burst-clock-frequency",
>> +    ret = exynos_dsi_of_read_u32(node, "samsung,burst-clock-frequency",
>>                        &dsi->burst_clk_rate);
>>       if (ret < 0)
>> -        goto end;
>> +        return ret;
>>   -    ret = exynos_dsi_of_read_u32(ep, "samsung,esc-clock-frequency",
>> +    ret = exynos_dsi_of_read_u32(node, "samsung,esc-clock-frequency",
>>                        &dsi->esc_clk_rate);
>>       if (ret < 0)
>> -        goto end;
>> -
>> -    of_node_put(ep);
>> +        return ret;
>>         ep = of_graph_get_next_endpoint(node, NULL);
>> -    if (!ep) {
>> -        ret = -EINVAL;
>> -        goto end;
>> -    }
>> -
>> -    dsi->bridge_node = of_graph_get_remote_port_parent(ep);
>> -    if (!dsi->bridge_node) {
>> -        ret = -EINVAL;
>> -        goto end;
>> +    if (ep) {
>> +        dsi->bridge_node = of_graph_get_remote_port_parent(ep);
>> +        of_node_put(ep);
>>       }
>> -end:
>> -    of_node_put(ep);
>>   -    return ret;
>> +    return 0;
>>   }
>>     static int exynos_dsi_bind(struct device *dev, struct device *master,
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
