From: architt@codeaurora.org (Archit Taneja)
Date: Wed, 2 Dec 2015 13:50:36 +0530
Subject: [PATCH v2 10/10] drm/hisilicon: Add support for external bridge
In-Reply-To: <CAGd==05Tw5YBWK19jJTruerkkj1Z8q05dB9VyP0AnTMwxyuPNQ@mail.gmail.com>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
 <1448707145-69348-11-git-send-email-xinliang.liu@linaro.org>
 <565D62A3.2030301@codeaurora.org>
 <CAGd==05Tw5YBWK19jJTruerkkj1Z8q05dB9VyP0AnTMwxyuPNQ@mail.gmail.com>
Message-ID: <565EA9D4.4090905@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/01/2015 08:20 PM, Xinliang Liu wrote:
> On 1 December 2015 at 17:04, Archit Taneja <architt@codeaurora.org> wrote:
>>
>>
>> On 11/28/2015 04:09 PM, Xinliang Liu wrote:
>>>
>>> Add support for external HDMI bridge.
>>>
>>> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
>>> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
>>> Signed-off-by: Andy Green <andy.green@linaro.org>
>>> ---
>>>    drivers/gpu/drm/hisilicon/hisi_drm_dsi.c | 51
>>> ++++++++++++++++++++++++++++++++
>>>    1 file changed, 51 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
>>> b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
>>> index 066e08d..9e056db 100644
>>> --- a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
>>> +++ b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
>>> @@ -78,6 +78,7 @@ struct dsi_hw_ctx {
>>>
>>>    struct hisi_dsi {
>>>          struct drm_encoder encoder;
>>> +       struct drm_bridge *bridge;
>>>          struct mipi_dsi_host host;
>>>          struct drm_display_mode cur_mode;
>>>          struct dsi_hw_ctx *ctx;
>>> @@ -671,6 +672,25 @@ static int dsi_host_init(struct device *dev, struct
>>> hisi_dsi *dsi)
>>>          return 0;
>>>    }
>>>
>>> +static int dsi_bridge_init(struct drm_device *dev, struct hisi_dsi *dsi)
>>> +{
>>> +       struct drm_encoder *encoder = &dsi->encoder;
>>> +       struct drm_bridge *bridge = dsi->bridge;
>>> +       int ret;
>>> +
>>> +       /* associate the bridge to dsi encoder */
>>> +       encoder->bridge = bridge;
>>> +       bridge->encoder = encoder;
>>> +
>>> +       ret = drm_bridge_attach(dev, bridge);
>>> +       if (ret) {
>>> +               DRM_ERROR("failed to attach exteranl bridge\n");
>>
>>
>> s/exteranl/external
>>
>
> will be fixed in v3.
>
>>
>>> +               return ret;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>    static int dsi_bind(struct device *dev, struct device *master, void
>>> *data)
>>>    {
>>>          struct dsi_data *ddata = dev_get_drvdata(dev);
>>> @@ -686,6 +706,10 @@ static int dsi_bind(struct device *dev, struct device
>>> *master, void *data)
>>>          if (ret)
>>>                  return ret;
>>>
>>> +       ret = dsi_bridge_init(drm_dev, dsi);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>>          return 0;
>>>    }
>>>
>>> @@ -702,8 +726,35 @@ static const struct component_ops dsi_ops = {
>>>    static int dsi_parse_dt(struct platform_device *pdev, struct hisi_dsi
>>> *dsi)
>>>    {
>>>          struct dsi_hw_ctx *ctx = dsi->ctx;
>>> +       struct device_node *np = pdev->dev.of_node;
>>> +       struct device_node *endpoint, *bridge_node;
>>> +       struct drm_bridge *bridge;
>>>          struct resource *res;
>>>
>>> +       /*
>>> +        * Get the endpoint node. In our case, dsi has one output port
>>> +        * to which the external HDMI bridge is connected.
>>> +        */
>>> +       endpoint = of_graph_get_next_endpoint(np, NULL);
>>> +       if (!endpoint) {
>>> +               DRM_ERROR("no valid endpoint node\n");
>>> +               return -ENODEV;
>>> +       }
>>> +       of_node_put(endpoint);
>>> +
>>> +       bridge_node = of_graph_get_remote_port_parent(endpoint);
>>> +       if (!bridge_node) {
>>> +               DRM_ERROR("no valid bridge node\n");
>>> +               return -ENODEV;
>>> +       }
>>> +       of_node_put(bridge_node);
>>> +
>>> +       bridge = of_drm_find_bridge(bridge_node);
>>> +       if (!bridge) {
>>> +               DRM_INFO("wait for external HDMI bridge driver.\n");
>>> +               return -EPROBE_DEFER;
>>> +       }
>>> +       dsi->bridge = bridge;
>>
>>
>> This could be left for later, but it would be better if the dsi driver
>> registers even if the bridge driver module isn't inserted yet, or
>> happens much later in boot.
>>
>> We could achieve this by trying to attach the bridge (done in
>> dsi_bridge_init) in the dsi_host_attach callback instead of having it
>> in dsi_bind.
>
> Do you mean that it is the right time or place to attach the bridge in
> dsi_host_attach callback.
> Why? Because at this time bridge driver must be register?

The bridge/panel drivers generally call drm_bridge_add/drm_panel_add and 
mipi_dsi_attach() during probe.

If the driver calls drm_bridge_add() before mipi_dsi_attach() in probe,
then 'of_drm_find_bridge()' should succeed in the callback. This, 
however, is prone to all sorts of race conditions and hence not the
best solution.

In the case of panels, a dsi host can always create a dummy connector,
and search for a panel (of_drm_find_panel) in its 'detect' helper.
Unfortunately, we don't have a free connector in the case of bridges.
The connector are, in most cases, created by the bridge driver itself,
and the dsi host driver has no say over the connector ops.

I don't have a better solution yet, hence I said it could be left for
later :)

Archit

>
> Thanks,
> -xinliang
>
>>
>> Thanks,
>> Archit
>>
>>>
>>>          ctx->dsi_cfg_clk = devm_clk_get(&pdev->dev, "pclk_dsi");
>>>          if (IS_ERR(ctx->dsi_cfg_clk)) {
>>>
>>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> hosted by The Linux Foundation

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, hosted by The Linux Foundation
