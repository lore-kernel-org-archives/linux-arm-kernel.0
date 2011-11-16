From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 16 Nov 2011 14:04:12 -0600
Subject: [PATCH v8 11/20] OMAP2+: UART: Move errata handling from serial.c
 to omap-serial
In-Reply-To: <CAAL8m4xYUd=5g7VOa7Ofnm6nRs8U1a7W+sofAkeCVOOURRfVXg@mail.gmail.com>
References: <1321005551-21786-1-git-send-email-govindraj.raja@ti.com>
 <1321005551-21786-2-git-send-email-govindraj.raja@ti.com>
 <4EC17123.2070505@ti.com>
 <CAAL8m4xYUd=5g7VOa7Ofnm6nRs8U1a7W+sofAkeCVOOURRfVXg@mail.gmail.com>
Message-ID: <4EC4173C.7090200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Govindraj,

On 11/16/2011 4:13, Govindraj wrote:
> On Tue, Nov 15, 2011 at 1:20 AM, Jon Hunter<jon-hunter@ti.com>  wrote:
>> Hi Govindraj,
>
> [...]
>
>>>
>>>         oh = uart->oh;
>>> -       uart->dma_enabled = 0;
>>>         name = DRIVER_NAME;
>>>
>>>         omap_up.dma_enabled = uart->dma_enabled;
>>>         omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
>>>         omap_up.flags = UPF_BOOT_AUTOCONF;
>>>         omap_up.get_context_loss_count =
>>> omap_pm_get_dev_context_loss_count;
>>> +       omap_up.set_forceidle = omap_uart_set_forceidle;
>>> +       omap_up.set_noidle = omap_uart_set_noidle;
>>> +
>>> +       /* Enable the MDR1 errata for OMAP2/3/4 */
>>> +       if ((cpu_is_omap2430() || cpu_is_omap34xx() ||
>>> cpu_is_omap44xx())&&
>>> +                                               !cpu_is_ti816x())
>>> +               omap_up.errata |= UART_ERRATA_i202_MDR1_ACCESS;
>>
>> I am not sure that this will apply the errata for OMAP3630 devices. I think
>> we need cpu_is_omap36xx() above too. Or you may wish to do
>> !cpu_class_is_omap1 and !cpu_is_omap2420.
>>
>
> Yes correct, I have updated this patch as here [1].

Thanks! Looks good.

> btw, omap-serial is applicable only for omap2+ so
> I think cpu_class_is omap1 not applicable here
> need to be handled in /mach-omap1/serial.c.

Duh! I missed that. We are good then.

Cheers
Jon
