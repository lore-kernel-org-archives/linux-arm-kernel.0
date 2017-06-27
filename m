From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 27 Jun 2017 12:07:48 +0200
Subject: [PATCH] drm: exynos: dsi: release DSI_PORT_OUT node right after
 of_drm_find_bridge()
In-Reply-To: <5952219F.1030902@samsung.com>
References: <CGME20170626004946epcas4p40785020666ae6d43476822d067604baa@epcas4p4.samsung.com>
 <20170624005628.5896-1-shuahkh@osg.samsung.com>
 <5d308e03-e92a-7bac-f65e-23c2ccbe161a@samsung.com>
 <5952219F.1030902@samsung.com>
Message-ID: <cd0eb692-5f8c-0137-8cc7-fa0ae9d7cf9b@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.06.2017 11:13, Inki Dae wrote:
> Hi Andrzej,
>
> 2017? 06? 26? 16:02? Andrzej Hajda ?(?) ? ?:
>> Hi Shuah,
>>
>>
>> On 24.06.2017 02:56, Shuah Khan wrote:
>>> Fix to call of_node_put() right after of_drm_find_bridge() instead of
>>> holding on to it until exynos_dsi_remove().
>> I think the current implementation is OK, node is get in probe and put
>> in remove.
>> There could be many bind/unbind during lifetime of the bound driver.
>> For example, there is possible sequence:
>> 1. probe -
>> 2. bind
>> 3. unbind
>> 4. bind
>>
>> With this patch on 2nd bind (point 4) driver will call
>> of_drm_find_bridge on dsi->bridge_node which was put earlier (point 2.).
>>
> Right. This is a problem.
>
> How about moving of_drm_find_bridge function call to probe and keeping drm_bridge_attach call in bind for cleanup?
> Seems it doesn't need to call of_drm_find_bridge function every time bind callback is called.

I think the reason to call of_drm_find_bridge in bind is to avoid probe
deferring, and with current code it will probably defer forever,
explanation below:

The only bridge connected to DSI is bridge provided by MIC driver, and
MIC driver is componentized, but it registers his bridge in bind callback.
So with drm_bridge_attach moved to probe of DSI initialization would
never succeed because:
1. MIC->bind will be called only if all DRM components are present.
2. DSI driver will defer probing because the bridge is not present, thus
DSI component will never be present.

So the current code looks better to me, but there are two thing which
could be improved:
A. Maybe it would be good thing to move MIC bridge registration to
probe, I see no reason to postpone it to bind phase, this way it should
be safer if for some reason DSI->bind callback would be called before
MIC->bind.
B. Add error checking to of_drm_find_bridge in DSI driver, I know MIC is
generally optional, but if the graph link is present (ie. 
dsi->bridge_node is valid) MIC bridge should be present, if it is not,
it indicates some problem.

Regards
Andrzej

>
> Thanks,
> Inki Dae
>
>> Regards
>> Andrzej
>>
>>
>>> Suggested-by: Inki Dae <inki.dae@samsung.com>
>>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>>> ---
>>>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>>> index e337cd2..7513b88 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>>> @@ -1689,6 +1689,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>>>  
>>>  	if (dsi->bridge_node) {
>>>  		bridge = of_drm_find_bridge(dsi->bridge_node);
>>> +		of_node_put(dsi->bridge_node);
>>>  		if (bridge)
>>>  			drm_bridge_attach(encoder, bridge, NULL);
>>>  	}
>>> @@ -1807,10 +1808,6 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>>>  
>>>  static int exynos_dsi_remove(struct platform_device *pdev)
>>>  {
>>> -	struct exynos_dsi *dsi = platform_get_drvdata(pdev);
>>> -
>>> -	of_node_put(dsi->bridge_node);
>>> -
>>>  	pm_runtime_disable(&pdev->dev);
>>>  
>>>  	component_del(&pdev->dev, &exynos_dsi_component_ops);
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>
