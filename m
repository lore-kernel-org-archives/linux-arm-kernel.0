From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Mon, 14 Oct 2013 20:42:28 +0000
Subject: [PATCH 05/11] USB: OHCI: Properly handle ohci-ep93xx suspend
In-Reply-To: <Pine.LNX.4.44L0.1310141630370.6851-100000@netrider.rowland.org>
References: <CAOesGMhiMD2_OOdR1_GDrJUWgU-qU9MyirhGtxXiWRQcMWy8+g@mail.gmail.com>
 <Pine.LNX.4.44L0.1310141630370.6851-100000@netrider.rowland.org>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D8817DABD8C@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 14, 2013 1:35 PM, Alan Stern wrote:
> On Mon, 14 Oct 2013, Olof Johansson wrote:
>
>> Hi, Greg,
>> 
>> [Adding ep93xx maintainers as well]
>> 
>> On Wed, Oct 2, 2013 at 3:15 AM, Majunath Goudar <csmanjuvijay@gmail.com> wrote:
>>> From: Manjunath Goudar <manjunath.goudar@linaro.org>
>>>
>>> Suspend scenario in case of ohci-ep93xx glue was not
>>> properly handled as it was not suspending generic part
>>> of ohci controller. Alan Stern suggested, properly handle
>>> ohci-ep93xx suspend scenario.
>>>
>>> Calling explicitly the ohci_suspend() routine in
>>> ohci_hcd_ep93xx_drv_suspend() will ensure proper handling of
>>> suspend scenario.
>
>>> --- a/drivers/usb/host/ohci-ep93xx.c
>>> +++ b/drivers/usb/host/ohci-ep93xx.c
>>> @@ -112,13 +112,20 @@ static int ohci_hcd_ep93xx_drv_suspend(struct platform_device *pdev, pm_message_
>>>  {
>>>         struct usb_hcd *hcd = platform_get_drvdata(pdev);
>>>         struct ohci_hcd *ohci = hcd_to_ohci(hcd);
>>> +       bool do_wakeup = device_may_wakeup(&pdev->dev);
>>> +       int ret;
>>>
>>>         if (time_before(jiffies, ohci->next_statechange))
>>>                 msleep(5);
>>>         ohci->next_statechange = jiffies;
>>>
>>> -       clk_disable(usb_host_clock);
>>> -       return 0;
>>> +       ret = ohci_suspend(hcd, do_wakeup);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ep93xx_stop_hc(&pdev->dev);
>>> +
>>> +       return ret;
>>>  }
>> 
>> This patch showed up in -next today (or maybe a while ago and I didn't
>> notice). It's causing a build failure on ep93xx:
>> 
>> From http://arm-soc.lixom.net/buildlogs/next-thierry/v3.12-rc5-5366-gba2e8c2/buildall.arm.ep93xx_defconfig.log.failed:
>> 
>> drivers/usb/host/ohci-ep93xx.c: In function 'ohci_hcd_ep93xx_drv_suspend':
>> drivers/usb/host/ohci-ep93xx.c:126:2: error: implicit declaration of
>> function 'ep93xx_stop_hc'
>> 
>> 
>> It's really confusing though, because Majunath has posted this patch
>> three times. The first time it had the ep93xx_stop_hc() call in there,
>> the second patch (labelled V2) did not, and the third(?) version,
>> without version label, also lacked it. No revision log in the patch,
>> and no comments on it.
>
> In fact he has posted it a lot more than 3 times, and the version 
> numbers (or lack thereof) are definitely confusing.
>
> The reason for the build failure is that Manjanuth started work on this 
> patch many months ago -- back in the spring.  At that time the 
> ep93xx_stop_hc() routine did exist.
>
> But commit af3f233fd27b (usb: ohci-ep93xx: tidy up driver (*probe) and 
>  (*remove)), dated July 1, removed it.  Manjunath never updated his 
> patch in response.
>
>> But it does seem like the wrong version was merged based on build results.
>
> No, it's a rebasing failure, not a wrong version.

Alan,

As an alternative to this patch, I have successfully used the ohci-platform
driver on the ep93xx. This does move a bit of glue code into the ep93xx
core (arch/arm/mach-ep93xx/core.c) but it removes the ohci-ep93xx glue
driver completely.

I can post a patch for this shortly if you would like.

Regards,
Hartley
