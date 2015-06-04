From: tremyfr@gmail.com (Philippe Reynes)
Date: Thu, 04 Jun 2015 23:26:05 +0200
Subject: [PATCH 2/2] rtc: mxc: add support of device tree
In-Reply-To: <20150528120601.GO2185@piout.net>
References: <1431729330-7625-1-git-send-email-tremyfr@gmail.com>
 <1431729330-7625-3-git-send-email-tremyfr@gmail.com>
 <20150528120601.GO2185@piout.net>
Message-ID: <5570C26D.5080204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,


On 28/05/15 14:06, Alexandre Belloni wrote:
> Hi,
>
> On 16/05/2015 at 00:35:30 +0200, Philippe Reynes wrote :
>>
>
> Please always include a commit message.

Oh yes, sorry about that.

>> Signed-off-by: Philippe Reynes<tremyfr@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/rtc/rtc-mxc.txt |   27 +++++++++++++++++++++
>>   drivers/rtc/rtc-mxc.c                             |   22 ++++++++++++++++-
>>   2 files changed, 48 insertions(+), 1 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/rtc-mxc.txt b/Documentation/devicetree/bindings/rtc/rtc-mxc.txt
>> new file mode 100644
>> index 0000000..5505493
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/rtc-mxc.txt
>> @@ -0,0 +1,27 @@
>> +* Real Time Clock of the i.MX SoCs
>> +
>> +RTC controller for the i.MX SoCs
>> +
>> +Required properties:
>> +- compatible: Should be "fsl,imx1-rtc" or "fsl,imx21-rtc".
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +- interrupts: IRQ line for the RTC.
>> +- clocks: should contain two entries:
>> +  * one for the input reference
>> +  * one for the the SoC RTC
>> +- clock-names: should contain:
>> +  * "rtc" for the input reference clock
>> +  * "ipg" for the SoC RTC clock
>> +
>> +Example:
>> +
>> +rtc at 10007000 {
>> +	compatible = "fsl,imx21-rtc";
>> +	reg =<0x10007000 0x1000>;
>> +	interrupts =<22>;
>> +	clocks =<&clks IMX27_CLK_CKIL>,
>> +	       	<&clks IMX27_CLK_RTC_IPG_GATE>;
>> +	clock-names = "rtc, "ipg";
>> +	status = "disabled";
>> +};
>> diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
>> index e916a91..df6483d 100644
>> --- a/drivers/rtc/rtc-mxc.c
>> +++ b/drivers/rtc/rtc-mxc.c
>> @@ -16,6 +16,8 @@
>>   #include<linux/interrupt.h>
>>   #include<linux/platform_device.h>
>>   #include<linux/clk.h>
>> +#include<linux/of.h>
>> +#include<linux/of_device.h>
>>
>>   #define RTC_INPUT_CLK_32768HZ	(0x00<<  5)
>>   #define RTC_INPUT_CLK_32000HZ	(0x01<<  5)
>> @@ -98,6 +100,15 @@ static struct platform_device_id imx_rtc_devtype[] = {
>>   };
>>   MODULE_DEVICE_TABLE(platform, imx_rtc_devtype);
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id imx_rtc_dt_ids[] = {
>> +	{ .compatible = "fsl,imx1-rtc", .data =&imx_rtc_devtype[IMX1_RTC] },
>> +	{ .compatible = "fsl,imx21-rtc", .data =&imx_rtc_devtype[IMX21_RTC] },
>
> Maybe you can use directly IMX1_RTC and IMX21_RTC which...

I've seen both "style" on the code. I may change the code to simply use IMX1_RTC
and IMX21_RTC.

>>
>> -	pdata->devtype = pdev->id_entry->driver_data;
>> +	of_id = of_match_device(imx_rtc_dt_ids,&pdev->dev);
>> +	if (of_id) {
>> +		struct platform_device_id *id_entry;
>> +
>> +		id_entry = (struct platform_device_id *)of_id->data;
>> +		pdata->devtype = id_entry->driver_data;
>
> ... also simplifies that part.

I'll do it in the next version of this patch.
  
>> +	} else
>> +		pdata->devtype = pdev->id_entry->driver_data;
>>
>

Do you prefer that I wait the clock driver has move to drivers/clk/imx
(as requested by Shawn) before sending a v2 ?

Regards,
Philippe
