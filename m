From: monstr@monstr.eu (Michal Simek)
Date: Mon, 03 Feb 2014 08:59:43 +0100
Subject: [PATCH 07/10] watchdog: xilinx: Fix OF binding
In-Reply-To: <CAL_JsqJ+Dc9PFVYcxHvLiG9unKQX-kEc1fsYsieyTjf-AN3j=A@mail.gmail.com>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <26d172891694e4041e73b7dae85a1848adf38034.1391177880.git.michal.simek@xilinx.com>
 <CAL_JsqJ+Dc9PFVYcxHvLiG9unKQX-kEc1fsYsieyTjf-AN3j=A@mail.gmail.com>
Message-ID: <52EF4C6F.8040701@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2014 06:33 PM, Rob Herring wrote:
> On Fri, Jan 31, 2014 at 8:18 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> Use of_property_read_u32 functions to clean OF probing.
> 
> The subject is a bit misleading as this doesn't really fix anything.

fair enough. Will change it.

> 
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  drivers/watchdog/of_xilinx_wdt.c | 25 ++++++++++---------------
>>  1 file changed, 10 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
>> index c229cc4..475440a6 100644
>> --- a/drivers/watchdog/of_xilinx_wdt.c
>> +++ b/drivers/watchdog/of_xilinx_wdt.c
>> @@ -147,8 +147,7 @@ static u32 xwdt_selftest(struct xwdt_device *xdev)
>>  static int xwdt_probe(struct platform_device *pdev)
>>  {
>>         int rc;
>> -       u32 *tmptr;
>> -       u32 *pfreq;
>> +       u32 pfreq, enable_once;
>>         struct resource *res;
>>         struct xwdt_device *xdev;
>>         bool no_timeout = false;
>> @@ -168,28 +167,24 @@ static int xwdt_probe(struct platform_device *pdev)
>>         if (IS_ERR(xdev->base))
>>                 return PTR_ERR(xdev->base);
>>
>> -       pfreq = (u32 *)of_get_property(pdev->dev.of_node,
>> -                                       "clock-frequency", NULL);
>> -
>> -       if (pfreq == NULL) {
>> +       rc = of_property_read_u32(pdev->dev.of_node, "clock-frequency", &pfreq);
>> +       if (rc) {
>>                 dev_warn(&pdev->dev,
>>                          "The watchdog clock frequency cannot be obtained\n");
>>                 no_timeout = true;
> 
> You can kill this...
> 
>>         }
>>
>> -       tmptr = (u32 *)of_get_property(pdev->dev.of_node,
>> -                                       "xlnx,wdt-interval", NULL);
>> -       if (tmptr == NULL) {
>> +       rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-interval",
>> +                                 &xdev->wdt_interval);
>> +       if (rc) {
>>                 dev_warn(&pdev->dev,
>>                          "Parameter \"xlnx,wdt-interval\" not found\n");
>>                 no_timeout = true;
> 
> and this...
> 
>> -       } else {
>> -               xdev->wdt_interval = *tmptr;
>>         }
>>
>> -       tmptr = (u32 *)of_get_property(pdev->dev.of_node,
>> -                                       "xlnx,wdt-enable-once", NULL);
>> -       if (tmptr == NULL) {
>> +       rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-enable-once",
>> +                                 &enable_once);
>> +       if (!rc && enable_once) {
>>                 dev_warn(&pdev->dev,
>>                          "Parameter \"xlnx,wdt-enable-once\" not found\n");
>>                 watchdog_set_nowayout(xilinx_wdt_wdd, true);
>> @@ -201,7 +196,7 @@ static int xwdt_probe(struct platform_device *pdev)
>>   */
>>         if (!no_timeout)
> 
> and use "if (pfreq && xdev->wdt_interval)" if you initialize pfreq to 0.


I just wanted to to change functions not logic in the driver.
But it can be changed too.

>>                 xilinx_wdt_wdd->timeout = 2 * ((1 << xdev->wdt_interval) /
>> -                                         *pfreq);
>> +                                         pfreq);
> 
> Is the wdog really usable if the timeout properties are missing? Seems
> like you should fail to probe rather than warn.

There are 2 things.
1. timeout - you don't need pfreq and wdt_interval to use this driver
but for that there should be module parameter timeout there.
It should be added.

2. about warn - based on 1 I don't think driver should failed
but I am looking at logic above which I have added there but should be different.

u32 enable_once = 0;
if (!rc)
	dev_warn

if (enable_once)
	watchdog_set_nowayout(xilinx_wdt_wdd, true);

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140203/78dbb960/attachment.sig>
