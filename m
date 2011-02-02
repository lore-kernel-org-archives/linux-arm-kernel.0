From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed, 02 Feb 2011 08:21:24 -0500
Subject: [PATCH v1 1/4] davinci: da8xx/omap-l1: add support for SPI
In-Reply-To: <4D495662.3060302@mvista.com>
References: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
	<1296596979-18524-2-git-send-email-michael.williamson@criticallink.com>
	<4D494C6A.30507@mvista.com> <4D49543A.1070302@criticallink.com>
	<4D495662.3060302@mvista.com>
Message-ID: <4D495A54.2090702@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/2/2011 8:04 AM, Sergei Shtylyov wrote:

> Hello.
> 
> On 02-02-2011 15:55, Michael Williamson wrote:
> 
>>>> Add SPI registration routines, clocks, and driver resources for
>>>> DA850/OMAP-L138/AM18x and DA830/OMAP-L137/AM17x platforms.
> 
>>>     You're only adding clocks for the former platform -- the ones for the latter platfrom are already there...
> 
>>>> Signed-off-by: Michael Williamson<michael.williamson@criticallink.com>
>>> [...]
> 
>>>> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
>>>> index beda8a4..f421f97 100644
>>>> --- a/arch/arm/mach-davinci/devices-da8xx.c
>>>> +++ b/arch/arm/mach-davinci/devices-da8xx.c
>>>> @@ -725,3 +725,99 @@ int __init da8xx_register_cpuidle(void)
>>>>
>>>>        return platform_device_register(&da8xx_cpuidle_device);
>>>>    }
>>>> +
>>>> +static struct resource da8xx_spi0_resources[] = {
>>>> +    [0] = {
>>>> +        .start    = 0x01c41000,
>>>> +        .end    = 0x01c41fff,
>>>> +        .flags    = IORESOURCE_MEM,
>>>> +    },
>>>> +    [1] = {
>>>> +        .start    = IRQ_DA8XX_SPINT0,
>>>> +        .end    = IRQ_DA8XX_SPINT0,
>>>> +        .flags    = IORESOURCE_IRQ,
>>>> +    },
>>>> +    [2] = {
>>>> +        .start    = EDMA_CTLR_CHAN(0, 14),
>>>> +        .end    = EDMA_CTLR_CHAN(0, 14),
>>>> +        .flags    = IORESOURCE_DMA,
>>>> +    },
>>>> +    [3] = {
>>>> +        .start    = EDMA_CTLR_CHAN(0, 15),
>>>> +        .end    = EDMA_CTLR_CHAN(0, 15),
>>>> +        .flags    = IORESOURCE_DMA,
>>>> +    },
> 
>>>     We have DA830_DMACH_SPI0_[RT]X defined for SPI0 DMA channels...
> 
>> Right.  The current routines/structures were designed to support either da830 or
>> da850.  They work because the interrupts and the DMA channels are fortunately
>> the same for the SPI devices between the platforms.  I can use the DA830 enums,
>> but I had preferred the clarity of the EDMA_CTRL_CHAN macro, and it would
>> remove confusion that this might only apply for DA830 and not DA850.  It would
>> be nice to rename that DA8XX_DMAC_SPI_[RT]X if the enums were used...
> 
>> Can I leave this, or do you really want me to use the enums?
> 
>    OK, you can leave this as is...
> 
>>>> +    [4] = {
>>>> +        .flags    = IORESOURCE_DMA,
>>>> +    },
> 
>>>     BTW, why do you need this placeholder?
> 
>> This is for the eventq selection in the edma allocation by the spi driver.  When I
>> previously had 0, I should have used EVENTQ_0 (how it was tested).  I will add it
>> back in to clarification.
> 
>    But event queue is not a DMA channel, so can't have just IORESOURCE_DMA in 'flags'. IIUC, there was a patch to add some clarifying flag(s) to IORESOURCE_DMA to support the event queue resource (which I never approved :-).
> 



I'd like to get the support in there for the driver that's currently in 
the mainline, which needs this resource as it is.  I had essentially copied
the setup approach from the dm365.c board file, which is doing the same thing.

It looks like other devices take EVENTQ information as platform data (e.g., 
snd_platform_data takes .asp_chan_q).  Would it make sense to update the
spi platform data to accept an EVENTQ parameter as well?  I would be willing
to push a follow on patch to sort this out, if it is required.

Thanks.

> WBR, Sergei
