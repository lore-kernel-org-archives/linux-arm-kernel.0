From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Thu, 16 Aug 2018 11:10:01 +0200
Subject: [PATCH10 3/3] ARM:drm ivip Intel FPGA Video and Image Processing
 Suite
In-Reply-To: <1534408434.3432.3.camel@intel.com>
References: <1534237029-2648-1-git-send-email-hean.loong.ong@intel.com>
 <1534237029-2648-4-git-send-email-hean.loong.ong@intel.com>
 <28d5e08c-4ae2-2d09-6ce4-985578535d34@tronnes.org>
 <1534408434.3432.3.camel@intel.com>
Message-ID: <d25039b3-9b7f-e36d-5b87-970e11232530@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 16.08.2018 10.33, skrev Ong, Hean Loong:
> On Wed, 2018-08-15 at 14:26 +0200, Noralf Tr?nnes wrote:
>> Den 14.08.2018 10.57, skrev Hean-Loong, Ong:
>>> From: Ong Hean Loong <hean.loong.ong@intel.com>
>>>
>>> Driver for Intel FPGA Video and Image Processing Suite Frame Buffer
>>> II.
>>> The driver only supports the Intel Arria10 devkit and its variants.
>>> This driver can be either loaded staticlly or in modules.
>>> The OF device tree binding is located at:
>>> Documentation/devicetree/bindings/display/altr,vip-fb2.txt
>>>
>>> Signed-off-by: Ong Hean Loong <hean.loong.ong@intel.com>
>>> ---

<snip>

>>> +int intelvipfb_probe(struct device *dev)
>>> +{
>>> +	int retval;
>>> +	struct drm_device *drm;
>>> +	struct intelvipfb_priv *fbpriv = dev_get_drvdata(dev);
>>> +	struct drm_connector *connector;
>>> +	u32 formats[] = {DRM_FORMAT_XRGB8888};
>>> +
>>> +	drm = fbpriv->drm;
>>> +
>>> +	drm->dev_private = fbpriv;
>>> +
>>> +	intelvipfb_setup_mode_config(drm);
>>> +
>>> +	connector = intelvipfb_conn_setup(drm);
>>> +	if (!connector) {
>>> +		dev_err(drm->dev, "Connector setup failed\n");
>>> +		goto err_mode_config;
>>> +	}
>>> +
>>> +	retval = drm_simple_display_pipe_init(drm, &fbpriv->pipe,
>>> +					??????&fbpriv_funcs,
>>> formats,
>>> +			ARRAY_SIZE(formats), NULL, connector);
>>> +	if (retval < 0) {
>>> +		dev_err(drm->dev, "Cannot setup simple display
>>> pipe\n");
>>> +		goto err_mode_config;
>>> +	}
>>> +
>>> +	fbpriv->fbcma = drm_fbdev_cma_init(drm,
>>> +			drm->mode_config.preferred_depth,
>>> +			drm->mode_config.num_connector);
>> Please use drm_fbdev_generic_setup() for fbdev emulation. It tears
>> down
>> automatically on drm_dev_unregister() and you don't need the
>> drm_driver->lastclose hook.
>>
>> All drivers that use drm_fbdev_cma_init() will move to this shortly.
>>
>> Noralf.
>>
> I could not find any examples that currently uses
> the?drm_fbdev_generic_setup (). Would you mind pointing me on where
> such examples are available that would allow me to replace the
> assignment of the fbcma pointer with?drm_fbdev_generic_setup() method

This is the only one converted so far:
Commit: dff1c7032ffea20cca2ad3973ed4c69c8182683d
drm/tinydrm: Use drm_fbdev_generic_setup()

Noralf.
