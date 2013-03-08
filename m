From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 8 Mar 2013 22:55:46 +0200
Subject: [PATCH 3/5] USB chipidea: introduce dual role mode pdata flags
In-Reply-To: <513A1743.8070102@pengutronix.de>
References: <1362049024-11383-1-git-send-email-mkl@pengutronix.de>
 <1362049024-11383-4-git-send-email-mkl@pengutronix.de>
 <20130308163300.GF32368@arwen.pp.htv.fi>
 <CAB7JpEGP4HXrbGs539pV8ruPrS2ZOT0EYhGR74vvFDtHM4GsQg@mail.gmail.com>
 <513A1743.8070102@pengutronix.de>
Message-ID: <CAB7JpEE8L+NR109+tnO_dueWtXBPnQVjegojsQNBUgBHPyk5eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2013 18:52, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 03/08/2013 05:46 PM, Alexander Shishkin wrote:
>> On 8 March 2013 18:33, Felipe Balbi <balbi@ti.com> wrote:
>>> Hi,
>>>
>>> On Thu, Feb 28, 2013 at 11:57:02AM +0100, Marc Kleine-Budde wrote:
>>>> @@ -487,14 +488,23 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>>>>               return -ENODEV;
>>>>       }
>>>>
>>>> +     /* For now we treat dual-role as otg */

Btw, if we do this, Peter's otg code will try to access OTGSC, which
is not what we want on non-otg devices, so we'll need a clear
distinction between the two.

>>>> +     dr_mode = ci->platdata->dr_mode;
>>>> +     if (dr_mode == USB_DR_MODE_UNKNOWN || dr_mode == USB_DR_MODE_DUAL_ROLE)
>>>> +             dr_mode = USB_DR_MODE_OTG;
>>>> +
>>>>       /* initialize role(s) before the interrupt is requested */
>>>> -     ret = ci_hdrc_host_init(ci);
>>>> -     if (ret)
>>>> -             dev_info(dev, "doesn't support host\n");
>>>> +     if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
>>>
>>> this is not something you should be passing via pdata; chipidea core
>>> should know how to read this data by itself. Meaning that chipidea core
>>> should be taught about devicetree. But make it optional since now all
>>> users use DT.
>>
>> And I don't think I like the idea of chipidea core calling into device
>> tree code directly.
>
> Hmmm....this means draw :)

Well, we could go for something like

ci_hdrc-$(CONFIG_OF) += of.o

and try to contain the damage there, maybe? Ideas? I would very much
like to keep the clutter away from the core probe if possible.
