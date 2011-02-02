From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed, 02 Feb 2011 07:55:22 -0500
Subject: [PATCH v1 1/4] davinci: da8xx/omap-l1: add support for SPI
In-Reply-To: <4D494C6A.30507@mvista.com>
References: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
	<1296596979-18524-2-git-send-email-michael.williamson@criticallink.com>
	<4D494C6A.30507@mvista.com>
Message-ID: <4D49543A.1070302@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On 2/2/2011 7:22 AM, Sergei Shtylyov wrote:

> Hello.
> 
> On 02-02-2011 0:49, Michael Williamson wrote:
> 
>> Add SPI registration routines, clocks, and driver resources for
>> DA850/OMAP-L138/AM18x and DA830/OMAP-L137/AM17x platforms.
> 
>    You're only adding clocks for the former platform -- the ones for the latter platfrom are already there...
> 
>> Signed-off-by: Michael Williamson<michael.williamson@criticallink.com>
> [...]
> 
>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>> index 3443d97..68fe4c2 100644
>> --- a/arch/arm/mach-davinci/da850.c
>> +++ b/arch/arm/mach-davinci/da850.c
>> @@ -359,6 +359,20 @@ static struct clk usb20_clk = {
>>       .gpsc        = 1,
>>   };
>>
>> +static struct clk spi0_clk = {
>> +    .name        = "spi0",
>> +    .parent        = &pll0_sysclk2,
>> +    .lpsc        = DA8XX_LPSC0_SPI0,
>> +};
>> +
>> +static struct clk spi1_clk = {
>> +    .name        = "spi1",
>> +    .parent        = &pll0_sysclk2,
>> +    .lpsc        = DA8XX_LPSC1_SPI1,
>> +    .gpsc        = 1,
>> +    .flags        = DA850_CLK_ASYNC3,
>> +};
>> +
>>   static struct clk_lookup da850_clks[] = {
>>       CLK(NULL,        "ref",        &ref_clk),
>>       CLK(NULL,        "pll0",        &pll0_clk),
>> @@ -403,6 +417,8 @@ static struct clk_lookup da850_clks[] = {
>>       CLK(NULL,        "aemif",    &aemif_clk),
>>       CLK(NULL,        "usb11",    &usb11_clk),
>>       CLK(NULL,        "usb20",    &usb20_clk),
>> +    CLK("spi_davinci.0",    NULL,        &spi0_clk),
>> +    CLK("spi_davinci.1",    NULL,        &spi1_clk),
>>       CLK(NULL,        NULL,        NULL),
>>   };
> 
>    It's worth separating this into a patch of its own...
> 


OK, I will pull this into a separate patch.

>> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
>> index beda8a4..f421f97 100644
>> --- a/arch/arm/mach-davinci/devices-da8xx.c
>> +++ b/arch/arm/mach-davinci/devices-da8xx.c
>> @@ -725,3 +725,99 @@ int __init da8xx_register_cpuidle(void)
>>
>>       return platform_device_register(&da8xx_cpuidle_device);
>>   }
>> +
>> +static struct resource da8xx_spi0_resources[] = {
>> +    [0] = {
>> +        .start    = 0x01c41000,
>> +        .end    = 0x01c41fff,
>> +        .flags    = IORESOURCE_MEM,
>> +    },
>> +    [1] = {
>> +        .start    = IRQ_DA8XX_SPINT0,
>> +        .end    = IRQ_DA8XX_SPINT0,
>> +        .flags    = IORESOURCE_IRQ,
>> +    },
>> +    [2] = {
>> +        .start    = EDMA_CTLR_CHAN(0, 14),
>> +        .end    = EDMA_CTLR_CHAN(0, 14),
>> +        .flags    = IORESOURCE_DMA,
>> +    },
>> +    [3] = {
>> +        .start    = EDMA_CTLR_CHAN(0, 15),
>> +        .end    = EDMA_CTLR_CHAN(0, 15),
>> +        .flags    = IORESOURCE_DMA,
>> +    },
> 
>    We have DA830_DMACH_SPI0_[RT]X defined for SPI0 DMA channels...
> 


Right.  The current routines/structures were designed to support either da830 or
da850.  They work because the interrupts and the DMA channels are fortunately
the same for the SPI devices between the platforms.  I can use the DA830 enums, 
but I had preferred the clarity of the EDMA_CTRL_CHAN macro, and it would 
remove confusion that this might only apply for DA830 and not DA850.  It would
be nice to rename that DA8XX_DMAC_SPI_[RT]X if the enums were used...

Can I leave this, or do you really want me to use the enums?

>> +    [4] = {
>> +        .flags    = IORESOURCE_DMA,
>> +    },
> 
>    BTW, why do you need this placeholder?
> 


This is for the eventq selection in the edma allocation by the spi driver.  When I 
previously had 0, I should have used EVENTQ_0 (how it was tested).  I will add it 
back in to clarification.

>> +};
>> +
>> +static struct resource da8xx_spi1_resources[] = {
>> +    [0] = {
>> +        .start    = 0x01f0e000,
>> +        .end    = 0x01f0efff,
>> +        .flags    = IORESOURCE_MEM,
>> +    },
>> +    [1] = {
>> +        .start    = IRQ_DA8XX_SPINT1,
>> +        .end    = IRQ_DA8XX_SPINT1,
>> +        .flags    = IORESOURCE_IRQ,
>> +    },
>> +    [2] = {
>> +        .start    = EDMA_CTLR_CHAN(0, 18),
>> +        .end    = EDMA_CTLR_CHAN(0, 18),
>> +        .flags    = IORESOURCE_DMA,
>> +    },
>> +    [3] = {
>> +        .start    = EDMA_CTLR_CHAN(0, 19),
>> +        .end    = EDMA_CTLR_CHAN(0, 19),
>> +        .flags    = IORESOURCE_DMA,
>> +    },
> 
>    We have DA830_DMACH_SPI1_[RT]X defined for SPI1 DMA channels...
> 


I'd really prefer this way, but will change it to DA830_DMAC_SPI1* enum
if you require it.

>> +    [4] = {
>> +        .flags    = IORESOURCE_DMA,
> 
>     ... and this one?
> 


See above.

>> +    },
>> +};
>> +
> 
> WBR, Sergei
