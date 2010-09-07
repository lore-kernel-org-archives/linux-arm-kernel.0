From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 7 Sep 2010 14:11:45 +0800
Subject: [PATCH] ARM: pxa: Enable U2D only in case PXA3xx is enabled
In-Reply-To: <4C85D40C.5090209@compulab.co.il>
References: <1283806389-18128-1-git-send-email-marek.vasut@gmail.com>
	<AANLkTintMS3-+tj5JoBoF4o+7WY9E4gZh3_szNsnNyS6@mail.gmail.com>
	<4C85D40C.5090209@compulab.co.il>
Message-ID: <AANLkTikfJ+pcY4aQMhGE7FpGapyGeXauGAqW8cUiXB82@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 7, 2010 at 1:56 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> ?On 09/07/10 05:26, Eric Miao wrote:
>> On Tue, Sep 7, 2010 at 4:53 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> In case PXA3xx support isn't enabled in kernel, the pxa3xx_u2d_start_hc()
>>> and pxa3xx_u2d_stop_hc() functions are undefined. Encapsulate their callings
>>> with #ifdef CONFIG_PXA3xx macro.
>>>
>> This isn't necessary. cpu_is_pxa3xx() will expand to zero if CONFIG_PXA3xx
>> isn't defined, and the whole if () statement will be optimized away by the
>> compiler.
>
> That was my intention, but I haven't checked if it really does the job.

It didn't. But I proposed a fix hours ago and it seemed to work. Tested
by Marek.

>
>>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>>> ---
>>>
>>> NOTE: I'm adding "Make a proper fix for this thing" into my ToDo. This is just a
>>> quick patch since I have that exam soon. I'll go for approach 2) from what we
>>> discussed in the other thread once the exam's past me.
>
> I've already started working on this yesterday and I'll be glad to have the patch reviewed
> more carefully then the U2D series were (so we need to fix it right away).
>
>>> ?drivers/usb/host/ohci-pxa27x.c | ? ?4 ++++
>>> ?1 files changed, 4 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
>>> index afef7b0..f3c60b9 100644
>>> --- a/drivers/usb/host/ohci-pxa27x.c
>>> +++ b/drivers/usb/host/ohci-pxa27x.c
>>> @@ -236,8 +236,10 @@ static int pxa27x_start_hc(struct pxa27x_ohci *ohci, struct device *dev)
>>> ? ? ? ?if (retval < 0)
>>> ? ? ? ? ? ? ? ?return retval;
>>>
>>> +#ifdef CONFIG_PXA3xx
>>> ? ? ? ?if (cpu_is_pxa3xx())
>>> ? ? ? ? ? ? ? ?pxa3xx_u2d_start_hc(&ohci_to_hcd(&ohci->ohci)->self);
>>> +#endif
>>>
>>> ? ? ? ?uhchr = __raw_readl(ohci->mmio_base + UHCHR) & ~UHCHR_SSE;
>>> ? ? ? ?__raw_writel(uhchr, ohci->mmio_base + UHCHR);
>>> @@ -255,8 +257,10 @@ static void pxa27x_stop_hc(struct pxa27x_ohci *ohci, struct device *dev)
>>>
>>> ? ? ? ?inf = dev->platform_data;
>>>
>>> +#ifdef CONFIG_PXA3xx
>>> ? ? ? ?if (cpu_is_pxa3xx())
>>> ? ? ? ? ? ? ? ?pxa3xx_u2d_stop_hc(&ohci_to_hcd(&ohci->ohci)->self);
>>> +#endif
>>>
>>> ? ? ? ?if (inf->exit)
>>> ? ? ? ? ? ? ? ?inf->exit(dev);
>>> --
>>> 1.7.1
>>>
>>>
>
> --
> Regards,
> Igor.
>
>
