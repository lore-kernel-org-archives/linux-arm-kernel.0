From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 5 Mar 2013 10:11:59 +0800
Subject: [V8 PATCH 02/16] usb: gadget: mv_udc: use PHY driver for udc
In-Reply-To: <20130304142417.GH3397@arwen.pp.htv.fi>
References: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
 <1361419646-9052-3-git-send-email-chao.xie@marvell.com>
 <20130304142417.GH3397@arwen.pp.htv.fi>
Message-ID: <CADApbegMLe7rzGwVuCiT5R3-GUg4_PmWx8RTDU3p4iqZ8hO+CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 4, 2013 at 10:24 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Feb 20, 2013 at 11:07:12PM -0500, Chao Xie wrote:
>> Originaly, udc driver will call the callbacks in platform data
>> for PHY initialization and shut down.
>> With PHY driver, it will call the APIs provided by PHY driver
>> for PHY initialization and shut down. It removes the callbacks
>> in platform data, and at same time it removes one block in the
>> way of enabling device tree for udc driver.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> ---
>>  drivers/usb/gadget/mv_udc.h      |    2 +-
>>  drivers/usb/gadget/mv_udc_core.c |   45 ++++++++++++++-----------------------
>>  2 files changed, 18 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/mv_udc.h b/drivers/usb/gadget/mv_udc.h
>> index 9073436..f339df4 100644
>> --- a/drivers/usb/gadget/mv_udc.h
>> +++ b/drivers/usb/gadget/mv_udc.h
>> @@ -180,7 +180,6 @@ struct mv_udc {
>>
>>       struct mv_cap_regs __iomem      *cap_regs;
>>       struct mv_op_regs __iomem       *op_regs;
>> -     void __iomem                    *phy_regs;
>>       unsigned int                    max_eps;
>>       struct mv_dqh                   *ep_dqh;
>>       size_t                          ep_dqh_size;
>> @@ -217,6 +216,7 @@ struct mv_udc {
>>       struct work_struct      vbus_work;
>>       struct workqueue_struct *qwork;
>>
>> +     struct usb_phy          *phy;
>>       struct usb_phy          *transceiver;
>>
>>       struct mv_usb_platform_data     *pdata;
>> diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
>> index c8cf959..4876d2f 100644
>> --- a/drivers/usb/gadget/mv_udc_core.c
>> +++ b/drivers/usb/gadget/mv_udc_core.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/clk.h>
>>  #include <linux/platform_data/mv_usb.h>
>> +#include <linux/usb/mv_usb2.h>
>>  #include <asm/unaligned.h>
>>
>>  #include "mv_udc.h"
>> @@ -1121,15 +1122,14 @@ static int mv_udc_enable_internal(struct mv_udc *udc)
>>
>>       dev_dbg(&udc->dev->dev, "enable udc\n");
>>       udc_clock_enable(udc);
>> -     if (udc->pdata->phy_init) {
>> -             retval = udc->pdata->phy_init(udc->phy_regs);
>> -             if (retval) {
>> -                     dev_err(&udc->dev->dev,
>> -                             "init phy error %d\n", retval);
>> -                     udc_clock_disable(udc);
>> -                     return retval;
>> -             }
>
> dude, you really don't test your patches, do you ? Your previous patch
> removed ->phy_init(), ->phy_deinit() and ->private_init() from your
> platform_data.
>
> Are you seriously telling me you didn't compile test your patches ?
>
> Rewrite your series again and make sure that each and every patch
> compiles and works on its own. You shouldn't cause any regressions or
> build breaks or build warnings while converting this driver.
>
> I won't review the rest of this series and I'm purging it from my TODO
> list.
>

Thanks for your review.

The patches are seperated into two parts. for  each part it includes
some patches.
I have compiled and tested each part for our configurartion and x86
configuration, but
not for every patch. i will do it.

> cheers
>
> --
> balbi
