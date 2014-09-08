From: dianders@chromium.org (Doug Anderson)
Date: Mon, 8 Sep 2014 11:48:25 -0700
Subject: [PATCH] usb: dwc2: Read GNPTXFSIZ when in forced HOST mode.
In-Reply-To: <A2CA0424C0A6F04399FB9E1CD98E0304844C4EA0@US01WEMBX2.internal.synopsys.com>
References: <1407440891-29295-1-git-send-email-dianders@chromium.org>
 <A2CA0424C0A6F04399FB9E1CD98E0304844C4EA0@US01WEMBX2.internal.synopsys.com>
Message-ID: <CAD=FV=Uh5a2oHTcrmUGOCiENnuOaJ5qQCnAxL2wKTGoLGDgVHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

On Thu, Aug 7, 2014 at 1:18 PM, Paul Zimmerman
<Paul.Zimmerman@synopsys.com> wrote:
>> From: Doug Anderson [mailto:dianders at chromium.org]
>> Sent: Thursday, August 07, 2014 12:48 PM
>>
>> The documentation for GNPTXFSIZ says that "For host mode, this field
>> is always valid."  Since we're already switching to host mode for
>> HPTXFSIZ, let's also read GNPTXFSIZ in host mode.
>>
>> On an rk3288 SoC, without this change we see this at bootup:
>>   dwc2 ff580000.usb: gnptxfsiz=00100400
>>   dwc2 ff580000.usb: 128 invalid for host_nperio_tx_fifo_size. Check HW configuration.
>>
>> After this change we see:
>>   dwc2 ff580000.usb: gnptxfsiz=04000400
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> ---
>>  drivers/usb/dwc2/core.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
>> index 27d2c9b..c184ed43 100644
>> --- a/drivers/usb/dwc2/core.c
>> +++ b/drivers/usb/dwc2/core.c
>> @@ -2674,23 +2674,23 @@ int dwc2_get_hwparams(struct dwc2_hsotg *hsotg)
>>       hwcfg2 = readl(hsotg->regs + GHWCFG2);
>>       hwcfg3 = readl(hsotg->regs + GHWCFG3);
>>       hwcfg4 = readl(hsotg->regs + GHWCFG4);
>> -     gnptxfsiz = readl(hsotg->regs + GNPTXFSIZ);
>>       grxfsiz = readl(hsotg->regs + GRXFSIZ);
>>
>>       dev_dbg(hsotg->dev, "hwcfg1=%08x\n", hwcfg1);
>>       dev_dbg(hsotg->dev, "hwcfg2=%08x\n", hwcfg2);
>>       dev_dbg(hsotg->dev, "hwcfg3=%08x\n", hwcfg3);
>>       dev_dbg(hsotg->dev, "hwcfg4=%08x\n", hwcfg4);
>> -     dev_dbg(hsotg->dev, "gnptxfsiz=%08x\n", gnptxfsiz);
>>       dev_dbg(hsotg->dev, "grxfsiz=%08x\n", grxfsiz);
>>
>> -     /* Force host mode to get HPTXFSIZ exact power on value */
>> +     /* Force host mode to get HPTXFSIZ / GNPTXFSIZ exact power on value */
>>       gusbcfg = readl(hsotg->regs + GUSBCFG);
>>       gusbcfg |= GUSBCFG_FORCEHOSTMODE;
>>       writel(gusbcfg, hsotg->regs + GUSBCFG);
>>       usleep_range(100000, 150000);
>>
>> +     gnptxfsiz = readl(hsotg->regs + GNPTXFSIZ);
>>       hptxfsiz = readl(hsotg->regs + HPTXFSIZ);
>> +     dev_dbg(hsotg->dev, "gnptxfsiz=%08x\n", gnptxfsiz);
>>       dev_dbg(hsotg->dev, "hptxfsiz=%08x\n", hptxfsiz);
>>       gusbcfg = readl(hsotg->regs + GUSBCFG);
>>       gusbcfg &= ~GUSBCFG_FORCEHOSTMODE;
>
> Nice! I wonder if this is a bug in the original driver, and they
> actually meant to read this register instead of HPTXFSIZ? Well, it
> doesn't really matter I guess.
>
> Acked-by: Paul Zimmerman <paulz@synopsys.com>
>
> You may want to resend this to Greg after -rc1 is out and he reopens
> his usb-next tree.

Is this something you want me to resend with Paul's Acked-by and
Kever's Reviewed-by?  Please let me know and I'm happy to repost.

-Doug
