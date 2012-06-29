From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 29 Jun 2012 13:08:17 +0200
Subject: [PATCH V2] MXS: Add DT binding support into stmp3xxx-rtc
In-Reply-To: <20120625043711.GA18156@S2101-09.ap.freescale.net>
References: <1339181804-22822-1-git-send-email-marex@denx.de>
 <20120625043711.GA18156@S2101-09.ap.freescale.net>
Message-ID: <4FED8CA1.5000800@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2012 06:37 AM, Shawn Guo wrote:
> On Fri, Jun 08, 2012 at 08:56:44PM +0200, Marek Vasut wrote:
>> Add simple binding for the stmp3xxx-rtc.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
> 
> Hi Alessandro,
> 
> The patch has some changes on arch/arm/boot/dts/imx28.dtsi, and also we
> need the patch to convert some board files over to device tree.  May I
> have your ack to queue the patch on my tree?

The interrupt numbers are not as the driver expects them..

> 
> Regards,
> Shawn
> 
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: rtc-linux at googlegroups.com
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> ---
>>  .../devicetree/bindings/rtc/stmp3xxx-rtc.txt        |   19 +++++++++++++++++++
>>  arch/arm/boot/dts/imx28.dtsi                        |    1 +
>>  drivers/rtc/rtc-stmp3xxx.c                          |    7 +++++++
>>  3 files changed, 27 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
>>
>> V2: Fix typos, remove fsl,imx28-rtc
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt b/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
>> new file mode 100644
>> index 0000000..a7a7de5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
>> @@ -0,0 +1,19 @@
>> +* STMP3xxx/i.MX28 Time Clock controller
>> +
>> +Required properties:
>> +- compatible: should be one of the following.
>> +    * "fsl,stmp3xxx-rtc"
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +- interrupts: Two interrupt numbers to the cpu should be specified. First
>> +  interrupt number is the rtc tick interrupt and second interrupt number
>> +  is the rtc alarm interrupt. The number of cells representing a interrupt
>> +  depends on the parent interrupt controller.

The driver expects the first interrupt to the the alarm interrupt, the
event interrupt is not use, yet.

>> +
>> +Example:
>> +
>> +	rtc at 80056000 {
>> +		compatible = "fsl,stmp3xxx-rtc";
>> +		reg = <0x80056000 2000>;
>> +		interrupts = <28 29>;
>> +	};
>> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
>> index cabcce8..5053019 100644
>> --- a/arch/arm/boot/dts/imx28.dtsi
>> +++ b/arch/arm/boot/dts/imx28.dtsi
>> @@ -387,6 +387,7 @@
>>  			};
>>  
>>  			rtc at 80056000 {
>> +				compatible = "fsl,imx28-rtc", "fsl,stmp3xxx-rtc";
>>  				reg = <0x80056000 2000>;
>>  				interrupts = <28 29>;

should be:
                                             <29 28>


>>  				status = "disabled";
>> diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
>> index 1028786..3aadb58 100644
>> --- a/drivers/rtc/rtc-stmp3xxx.c
>> +++ b/drivers/rtc/rtc-stmp3xxx.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/rtc.h>
>>  #include <linux/slab.h>
>> +#include <linux/of_device.h>
>>  
>>  #include <mach/common.h>
>>  
>> @@ -265,6 +266,11 @@ static int stmp3xxx_rtc_resume(struct platform_device *dev)
>>  #define stmp3xxx_rtc_resume	NULL
>>  #endif
>>  
>> +static const struct of_device_id rtc_dt_ids[] = {
>> +	{ .compatible = "fsl,stmp3xxx-rtc", },
>> +	{ /* sentinel */ }
>> +};
>> +
>>  static struct platform_driver stmp3xxx_rtcdrv = {
>>  	.probe		= stmp3xxx_rtc_probe,
>>  	.remove		= stmp3xxx_rtc_remove,
>> @@ -273,6 +279,7 @@ static struct platform_driver stmp3xxx_rtcdrv = {
>>  	.driver		= {
>>  		.name	= "stmp3xxx-rtc",
>>  		.owner	= THIS_MODULE,
>> +		.of_match_table = rtc_dt_ids,
>>  	},
>>  };
>>  
>> -- 
>> 1.7.10
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120629/1e8f68eb/attachment.sig>
