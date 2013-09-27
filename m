From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 27 Sep 2013 16:35:29 +0200
Subject: imprecise external abort using the flexcan driver on i.MX6Q
In-Reply-To: <21061.38627.854812.311229@ipc1.ka-ro>
References: <21060.15934.600859.167074@ipc1.ka-ro>
 <CAOMZO5AODznB9D+J2D1juoL=f5eBuJEyuNtN+DEYFuSdhNdt5g@mail.gmail.com>
 <21061.38627.854812.311229@ipc1.ka-ro>
Message-ID: <524597B1.5070703@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 04:32 PM, Lothar Wa?mann wrote:
> Hi,
> 
> Fabio Estevam writes:
>> Hi Lothar,
>>
>> On Thu, Sep 26, 2013 at 11:01 AM, Lothar Wa?mann
>> <LW@karo-electronics.de> wrote:
>>> Does anyone have any clue how this can happen?
>>>
>>> Can anyone reproduce this on another machine?
>>
>> Is the change below needed?
>>
>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>> @@ -310,7 +310,7 @@
>>                         };
>>
>>                         can1: flexcan at 02090000 {
>> -                               compatible = "fsl,imx6q-flexcan";
>> +                               compatible = "fsl,imx6q-flexcan",
>> "fsl,p1010-flexcan";
>>                                 reg = <0x02090000 0x4000>;
>>                                 interrupts = <0 110 0x04>;
>>                                 clocks = <&clks 108>, <&clks 109>;
>> @@ -318,7 +318,7 @@
>>                         };
>>
>>                         can2: flexcan at 02094000 {
>> -                               compatible = "fsl,imx6q-flexcan";
>> +                               compatible = "fsl,imx6q-flexcan",
>> "fsl,p1010-flexcan";
>>                                 reg = <0x02094000 0x4000>;
>>                                 interrupts = <0 111 0x04>;
>>                                 clocks = <&clks 110>, <&clks 111>;
> The driver contains:
> |static const struct of_device_id flexcan_of_match[] = {
> |	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
> |	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
> |	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
> |	{ /* sentinel */ },
> 
> Thus, with your proposed change the DT data would become ambiguous and
> the driver might use &fsl_p1010_devtype_data rather than
> &fsl_imx6q_devtype_data depending how the matching algorithm works.

In fact the imx6 flexcan is not compatible with the p1010, as a certain
register on the imx6 must be written to let the driver work.

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
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/caf8911a/attachment.sig>
