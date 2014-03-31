From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 31 Mar 2014 17:05:13 +0800
Subject: [PATCH v2 3/3] [media] atmel-isi: add primary DT support
In-Reply-To: <Pine.LNX.4.64.1403302313290.12008@axis700.grange>
References: <1395744087-5753-1-git-send-email-josh.wu@atmel.com>
 <1395744320-15025-1-git-send-email-josh.wu@atmel.com>
 <Pine.LNX.4.64.1403302313290.12008@axis700.grange>
Message-ID: <53392FC9.9070706@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Guennadi

On 3/31/2014 5:20 AM, Guennadi Liakhovetski wrote:
> Hi Josh,
>
> Please correct me if I'm wrong, but I don't see how this is going to work
> without the central part - building asynchronous V4L2 data structures from
> the DT, something that your earlier patch

Here you mean Bryan Wu not me, right?   ;-)
Bryan write the patch "[v2] media: soc-camera: OF cameras" in: 
https://patchwork.linuxtv.org/patch/22288/.
And I saw Ben Dooks already sent out his patch to support soc-camera OF 
now (https://patchwork.linuxtv.org/patch/23304/) which is simpler than 
Bryan's.

> "media: soc-camera: OF cameras"
> was doing, but which you stopped developing after a discussion with Ben
> (added to Cc).

And yes, atmel-isi dt patch should not work without above SoC-Camera of 
support patch.
But as the atmel-isi dt binding document and port node can be finalized. 
So I think this patch is ready for the mainline.

BTW: I will test Ben's patch with atmel-isi.

thanks and best regards,
Josh Wu

>
> Thanks
> Guennadi
>
> On Tue, 25 Mar 2014, Josh Wu wrote:
>
>> This patch add the DT support for Atmel ISI driver.
>> It use the same v4l2 DT interface that defined in video-interfaces.txt.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> Cc: devicetree at vger.kernel.org
>> ---
>> v1 --> v2:
>>   refine the binding document.
>>   add port node description.
>>   removed the optional property.
>>
>>   .../devicetree/bindings/media/atmel-isi.txt        |   50 ++++++++++++++++++++
>>   drivers/media/platform/soc_camera/atmel-isi.c      |   31 +++++++++++-
>>   2 files changed, 79 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/media/atmel-isi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/media/atmel-isi.txt b/Documentation/devicetree/bindings/media/atmel-isi.txt
>> new file mode 100644
>> index 0000000..11c98ee
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/atmel-isi.txt
>> @@ -0,0 +1,50 @@
>> +Atmel Image Sensor Interface (ISI) SoC Camera Subsystem
>> +----------------------------------------------
>> +
>> +Required properties:
>> +- compatible: must be "atmel,at91sam9g45-isi"
>> +- reg: physical base address and length of the registers set for the device;
>> +- interrupts: should contain IRQ line for the ISI;
>> +- clocks: list of clock specifiers, corresponding to entries in
>> +          the clock-names property;
>> +- clock-names: must contain "isi_clk", which is the isi peripherial clock.
>> +
>> +ISI supports a single port node with parallel bus. It should contain one
>> +'port' child node with child 'endpoint' node. Please refer to the bindings
>> +defined in Documentation/devicetree/bindings/media/video-interfaces.txt.
>> +
>> +Example:
>> +	isi: isi at f0034000 {
>> +		compatible = "atmel,at91sam9g45-isi";
>> +		reg = <0xf0034000 0x4000>;
>> +		interrupts = <37 IRQ_TYPE_LEVEL_HIGH 5>;
>> +
>> +		clocks = <&isi_clk>;
>> +		clock-names = "isi_clk";
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_isi>;
>> +
>> +		port {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			isi_0: endpoint {
>> +				remote-endpoint = <&ov2640_0>;
>> +			};
>> +		};
>> +	};
>> +
>> +	i2c1: i2c at f0018000 {
>> +		ov2640: camera at 0x30 {
>> +			compatible = "omnivision,ov2640";
>> +			reg = <0x30>;
>> +
>> +			port {
>> +				ov2640_0: endpoint {
>> +					remote-endpoint = <&isi_0>;
>> +					bus-width = <8>;
>> +				};
>> +			};
>> +		};
>> +	};
>> diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
>> index f4add0a..d6a1f7b 100644
>> --- a/drivers/media/platform/soc_camera/atmel-isi.c
>> +++ b/drivers/media/platform/soc_camera/atmel-isi.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> +#include <linux/of.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>   
>> @@ -33,6 +34,7 @@
>>   #define VID_LIMIT_BYTES			(16 * 1024 * 1024)
>>   #define MIN_FRAME_RATE			15
>>   #define FRAME_INTERVAL_MILLI_SEC	(1000 / MIN_FRAME_RATE)
>> +#define ISI_DEFAULT_MCLK_FREQ		25000000
>>   
>>   /* Frame buffer descriptor */
>>   struct fbd {
>> @@ -885,6 +887,20 @@ static int atmel_isi_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> +static int atmel_isi_probe_dt(struct atmel_isi *isi,
>> +			struct platform_device *pdev)
>> +{
>> +	struct device_node *node = pdev->dev.of_node;
>> +
>> +	/* Default settings for ISI */
>> +	isi->pdata.full_mode = 1;
>> +	isi->pdata.mck_hz = ISI_DEFAULT_MCLK_FREQ;
>> +	isi->pdata.frate = ISI_CFG1_FRATE_CAPTURE_ALL;
>> +	isi->pdata.data_width_flags = ISI_DATAWIDTH_8 | ISI_DATAWIDTH_10;
>> +
>> +	return 0;
>> +}
>> +
>>   static int atmel_isi_probe(struct platform_device *pdev)
>>   {
>>   	unsigned int irq;
>> @@ -896,7 +912,7 @@ static int atmel_isi_probe(struct platform_device *pdev)
>>   	struct isi_platform_data *pdata;
>>   
>>   	pdata = dev->platform_data;
>> -	if (!pdata || !pdata->data_width_flags) {
>> +	if ((!pdata || !pdata->data_width_flags) && !pdev->dev.of_node) {
>>   		dev_err(&pdev->dev,
>>   			"No config available for Atmel ISI\n");
>>   		return -EINVAL;
>> @@ -912,7 +928,11 @@ static int atmel_isi_probe(struct platform_device *pdev)
>>   	if (IS_ERR(isi->pclk))
>>   		return PTR_ERR(isi->pclk);
>>   
>> -	memcpy(&isi->pdata, pdata, sizeof(struct isi_platform_data));
>> +	if (pdata)
>> +		memcpy(&isi->pdata, pdata, sizeof(struct isi_platform_data));
>> +	else	/* dt probe */
>> +		atmel_isi_probe_dt(isi, pdev);
>> +
>>   	isi->active = NULL;
>>   	spin_lock_init(&isi->lock);
>>   	INIT_LIST_HEAD(&isi->video_buffer_list);
>> @@ -1014,11 +1034,18 @@ err_alloc_ctx:
>>   	return ret;
>>   }
>>   
>> +static const struct of_device_id atmel_isi_of_match[] = {
>> +	{ .compatible = "atmel,at91sam9g45-isi" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, atmel_isi_of_match);
>> +
>>   static struct platform_driver atmel_isi_driver = {
>>   	.remove		= atmel_isi_remove,
>>   	.driver		= {
>>   		.name = "atmel_isi",
>>   		.owner = THIS_MODULE,
>> +		.of_match_table = atmel_isi_of_match,
>>   	},
>>   };
>>   
>> -- 
>> 1.7.9.5
>>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
