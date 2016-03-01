From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Tue, 1 Mar 2016 18:34:32 +0800
Subject: [PATCH v6 08/11] drm/hisilicon: Add designware dsi host driver
In-Reply-To: <56D4932B.9080500@codeaurora.org>
References: <1456476028-36880-1-git-send-email-xinliang.liu@linaro.org>
 <1456476028-36880-9-git-send-email-xinliang.liu@linaro.org>
 <56D4932B.9080500@codeaurora.org>
Message-ID: <CAGd==05WYu7hW3KfgmvsZyb_PYrniYxtMcrNiz+99mCaw-27bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 1 March 2016 at 02:51, Archit Taneja <architt@codeaurora.org> wrote:
>
>
> On 2/26/2016 2:10 PM, Xinliang Liu wrote:
>>
>> Add DesignWare dsi host driver for hi6220 SoC.
>>
>> v6: None.
>> v5: None.
>> v4: None.
>> v3: None.
>> v2:
>> - Remove abtraction layer.
>
>
> Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks :-)

Best,
-xinliang

>
>
>>
>> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
>> ---
>>   drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 50
>> ++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
>> b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
>> index 8329148cc89d..f15798b61451 100644
>> --- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
>> +++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
>> @@ -79,6 +79,7 @@ struct dsi_hw_ctx {
>>
>>   struct dw_dsi {
>>         struct drm_encoder encoder;
>> +       struct mipi_dsi_host host;
>>         struct drm_display_mode cur_mode;
>>         struct dsi_hw_ctx *ctx;
>>         struct mipi_phy_params phy;
>> @@ -642,6 +643,51 @@ static int dw_drm_encoder_init(struct device *dev,
>>         return 0;
>>   }
>>
>> +static int dsi_host_attach(struct mipi_dsi_host *host,
>> +                          struct mipi_dsi_device *mdsi)
>> +{
>> +       struct dw_dsi *dsi = host_to_dsi(host);
>> +
>> +       if (mdsi->lanes < 1 || mdsi->lanes > 4) {
>> +               DRM_ERROR("dsi device params invalid\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       dsi->lanes = mdsi->lanes;
>> +       dsi->format = mdsi->format;
>> +       dsi->mode_flags = mdsi->mode_flags;
>> +
>> +       return 0;
>> +}
>> +
>> +static int dsi_host_detach(struct mipi_dsi_host *host,
>> +                          struct mipi_dsi_device *mdsi)
>> +{
>> +       /* do nothing */
>> +       return 0;
>> +}
>> +
>> +static const struct mipi_dsi_host_ops dsi_host_ops = {
>> +       .attach = dsi_host_attach,
>> +       .detach = dsi_host_detach,
>> +};
>> +
>> +static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
>> +{
>> +       struct mipi_dsi_host *host = &dsi->host;
>> +       int ret;
>> +
>> +       host->dev = dev;
>> +       host->ops = &dsi_host_ops;
>> +       ret = mipi_dsi_host_register(host);
>> +       if (ret) {
>> +               DRM_ERROR("failed to register dsi host\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static int dsi_bind(struct device *dev, struct device *master, void
>> *data)
>>   {
>>         struct dsi_data *ddata = dev_get_drvdata(dev);
>> @@ -653,6 +699,10 @@ static int dsi_bind(struct device *dev, struct device
>> *master, void *data)
>>         if (ret)
>>                 return ret;
>>
>> +       ret = dsi_host_init(dev, dsi);
>> +       if (ret)
>> +               return ret;
>> +
>>         return 0;
>>   }
>>
>>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
