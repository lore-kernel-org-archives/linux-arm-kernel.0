From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 8 Mar 2013 18:46:48 +0200
Subject: [PATCH 3/5] USB chipidea: introduce dual role mode pdata flags
In-Reply-To: <20130308163300.GF32368@arwen.pp.htv.fi>
References: <1362049024-11383-1-git-send-email-mkl@pengutronix.de>
 <1362049024-11383-4-git-send-email-mkl@pengutronix.de>
 <20130308163300.GF32368@arwen.pp.htv.fi>
Message-ID: <CAB7JpEGP4HXrbGs539pV8ruPrS2ZOT0EYhGR74vvFDtHM4GsQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2013 18:33, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Feb 28, 2013 at 11:57:02AM +0100, Marc Kleine-Budde wrote:
>> @@ -487,14 +488,23 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>>               return -ENODEV;
>>       }
>>
>> +     /* For now we treat dual-role as otg */
>> +     dr_mode = ci->platdata->dr_mode;
>> +     if (dr_mode == USB_DR_MODE_UNKNOWN || dr_mode == USB_DR_MODE_DUAL_ROLE)
>> +             dr_mode = USB_DR_MODE_OTG;
>> +
>>       /* initialize role(s) before the interrupt is requested */
>> -     ret = ci_hdrc_host_init(ci);
>> -     if (ret)
>> -             dev_info(dev, "doesn't support host\n");
>> +     if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
>
> this is not something you should be passing via pdata; chipidea core
> should know how to read this data by itself. Meaning that chipidea core
> should be taught about devicetree. But make it optional since now all
> users use DT.

And I don't think I like the idea of chipidea core calling into device
tree code directly.

Regards,
--
Alex
