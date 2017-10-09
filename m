From: net147@gmail.com (Jonathan Liu)
Date: Tue, 10 Oct 2017 08:17:34 +1100
Subject: [PATCH] usb: musb: sunxi: Explicitly release USB PHY on exit
In-Reply-To: <20171009142302.GB32614@uda0271908>
References: <20170926113923.18181-1-net147@gmail.com>
 <20171009142302.GB32614@uda0271908>
Message-ID: <CANwerB2kbxnhrgWAnmWB9Uzp+M1MjC7MwWuwLXw==dpdCRLCAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10 October 2017 at 01:23, Bin Liu <b-liu@ti.com> wrote:
> Hi,
>
> On Tue, Sep 26, 2017 at 09:39:23PM +1000, Jonathan Liu wrote:
>> This fixes a kernel oops when unloading the driver due to usb_put_phy
>> being called after usb_phy_generic_unregister when the device is
>> detached. Calling usb_phy_generic_unregister causes x->dev->driver to
>> be NULL in usb_put_phy and results in a NULL pointer dereference.
>>
>> As we are now explicitly managing the lifetime of usb_phy,
>> devm_usb_get_phy is changed to usb_get_phy and we call usb_put_phy in
>> the probe error path.
>>
>> Cc: stable at vger.kernel.org # v4.3+
>> Signed-off-by: Jonathan Liu <net147@gmail.com>
>> ---
>>  drivers/usb/musb/sunxi.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
>> index c9a09b5bb6e5..8eed61042103 100644
>> --- a/drivers/usb/musb/sunxi.c
>> +++ b/drivers/usb/musb/sunxi.c
>> @@ -297,6 +297,8 @@ static int sunxi_musb_exit(struct musb *musb)
>>       if (test_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags))
>>               sunxi_sram_release(musb->controller->parent);
>>
>> +     usb_put_phy(glue->xceiv);
>
> Will devm_usb_put_phy() solve the issue too? Then you don't need the
> changes in sunxi_musb_probe() below.
>

devm_usb_put_phy does solve the issue without changes in
sunxi_musb_probe but I think it is clearer that the lifetime is
explicitly managed if we don't mix implicit and explicit freeing of
resources.

>> +
>>       return 0;
>>  }
>>
>> @@ -781,7 +783,7 @@ static int sunxi_musb_probe(struct platform_device *pdev)
>>               return PTR_ERR(glue->usb_phy);
>>       }
>>
>> -     glue->xceiv = devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
>> +     glue->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
>>       if (IS_ERR(glue->xceiv)) {
>>               ret = PTR_ERR(glue->xceiv);
>>               dev_err(&pdev->dev, "Error getting usb-phy %d\n", ret);
>> @@ -803,11 +805,13 @@ static int sunxi_musb_probe(struct platform_device *pdev)
>>       if (IS_ERR(glue->musb_pdev)) {
>>               ret = PTR_ERR(glue->musb_pdev);
>>               dev_err(&pdev->dev, "Error registering musb dev: %d\n", ret);
>> -             goto err_unregister_usb_phy;
>> +             goto err_put_usb_phy;
>>       }
>>
>>       return 0;
>>
>> +err_put_usb_phy:
>> +     usb_put_phy(glue->xceiv);
>>  err_unregister_usb_phy:
>>       usb_phy_generic_unregister(glue->usb_phy);
>>       return ret;
>> --
>> 2.13.2
>
> Regards,
> -Bin.

Regards,
Jonathan
