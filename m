From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Mar 2015 15:00:02 -0600
Subject: [PATCH v5] drivers/tty: amba: defer probing DMA availability
 until hw_init
In-Reply-To: <54F77A3F.5000300@linaro.org>
References: <1424969811-11197-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1424969811-11197-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <CAL_Jsq+1ayOsYH+dyexnyiLTuW4=ervVFdU6HL7GLtKQGCt9Ew@mail.gmail.com>
 <54F77A3F.5000300@linaro.org>
Message-ID: <CAL_Jsq+LPOMfO4ZymduEHegwb6vSZtfgnT5gHWyj47X5sOuYbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 4, 2015 at 3:33 PM, Jorge Ramirez-Ortiz
<jorge.ramirez-ortiz@linaro.org> wrote:
> On 03/03/2015 11:13 AM, Rob Herring wrote:
>> On Thu, Feb 26, 2015 at 10:56 AM, Jorge Ramirez-Ortiz
>> <jorge.ramirez-ortiz@linaro.org> wrote:
>>> Fix a race condition that happens when device_initcall(pl011_dma_initicall)
>>> is executed before all the devices have been probed - this issue was observed on
>>> an hisi_6220 SoC (HiKey board from Linaro).

[...]

>>> @@ -261,10 +262,11 @@ static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
>>>         }
>>>  }
>>>
>>> -static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *uap)
>>> +static void pl011_dma_probe(struct uart_amba_port *uap)
>>>  {
>>>         /* DMA is the sole user of the platform data right now */
>>> -       struct amba_pl011_data *plat = dev_get_platdata(uap->port.dev);
>>> +       struct device *const uap_dev = uap->port.dev;
>> Call this "dev" so you don't have all the needless renaming.
>>
>> With that change:
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>
>
> OK.
>
> while I am at it, you initially suggested to do the probe in pl011_dma_startup.
>
> Instead I probed from pl011_hwinit since it matched the original behaviour of
> also probing the DMA when CONFIG_CONSOLE_POLL was enabled.
> However, since the CONFIG_CONSOLE_POLL implementation for the amba-pl011 doesn't
> use the DMA it actually doesn't help to keep it in pl011_hwinit.
>
> is it ok with you if I move this to pl011_dma_startup as you initially suggested?

That sounds fine.

Rob
