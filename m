From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 23 Oct 2015 15:50:21 +0300
Subject: MUSB peripheral DMA regression caused by driver core runtime PM
 change
In-Reply-To: <20151022230133.GV3078@atomide.com>
References: <20151021234134.GQ3078@atomide.com>
 <20151022180216.GT3078@atomide.com> <20151022230133.GV3078@atomide.com>
Message-ID: <562A2D0D.3060104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2015 02:01 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [151022 11:03]:
>> * Tony Lindgren <tony@atomide.com> [151021 16:44]:
>>> Hi all,
>>>
>>> I noticed a regresssino in v4.3-rc series to day with MUSB gadgets
>>> and DMA. Doing a git bisect between v4.2..v4.3-rc1 on it pointed to:
>>>
>>> ddef08dd00f5 ("Driver core: wakeup the parent device before trying probe")
>>>
>>> With the commit above reverted things work fine with DMA and USB gadgets.
>>>
>>> This is on omap3 with CONFIG_USB_INVENTRA_DMA selected. Selecting
>>> CONFIG_MUSB_PIO_ONLY still works even without reverting ddef08dd00f5.
>>>
>>> Anybody got ideas what might be wrong? Some wrong runtime PM usage
>>> under drivers/usb/musb?
>>
>> Here's some more debug info on where things are different initializing
>> the USB gadgets. I added some printks and diffed the dmesg output. The
>> added calls from commit ddef08dd00f5 start with dd:
>
> Well turns out the problem actually happens earlier. We end up calling
> omap2430_runtime_resume with NULL struct musb while EPROBE_DEFER
> probing.
>
> No ideas yet how it should be fixed though.
>

I'm not sure, but below diff might help

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 70f2b8a..aba8ca7 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -391,6 +391,8 @@ static int omap2430_musb_init(struct musb *musb)
         }
         musb->isr = omap2430_musb_interrupt;

+       pm_runtime_enable(glue->dev);
+
         status = pm_runtime_get_sync(dev);
         if (status < 0) {
                 dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
@@ -626,8 +628,6 @@ static int omap2430_probe(struct platform_device *pdev)
                 goto err2;
         }

-       pm_runtime_enable(&pdev->dev);
-
         ret = platform_device_add(musb);
         if (ret) {
                 dev_err(&pdev->dev, "failed to register musb device\n");




-- 
regards,
-grygorii
