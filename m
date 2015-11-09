From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 09 Nov 2015 15:36:54 +0000
Subject: Grafting old platform drivers onto a new DT kernel
In-Reply-To: <5640B877.4020108@free.fr>
References: <563B3749.50701@free.fr> <20151105151559.GA16666@lunn.ch>
 <CABxcv=k5mzw_TDsD1eQna9+HY9aqCUd03YAc62750Gs--sMozw@mail.gmail.com>
 <5640B877.4020108@free.fr>
Message-ID: <5640BD96.4070504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/15 15:15, Mason wrote:
> On 05/11/2015 16:42, Javier Martinez Canillas wrote:
>> Hello,
>>
>> On Thu, Nov 5, 2015 at 12:15 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>>>> Since I don't have time to rewrite the drivers at the moment, I'm wondering
>>>> if it's possible to "graft" old drivers (they're using the platform API, no
>>>> trace of DT support) onto my small base?
>>>
>>> Platform drivers are still usable with DT systems. We used that fact
>>> when converting platform based machines over to DT, one driver at a
>>> time. Look in the git history for kirkwood devices. e.g. somewhere
>>> around v3.7, arch/arm/mach-kirkwood. board-dt.c, and the various
>>> board-*.c files, and the DT files in the usual place.
>>>
>>
>> OMAP did the same and still some boards use platform data and manually
>> register platform devices from board code. Take a look to
>> arch/arm/mach-omap2/pdata-quirks.c to see how that is being done.
> 
> Hello,
> 
> I tried compiling an ancient SDHCI driver on a v4.2 system. It crashes
> all over init because several host->ops functions are required, but the
> old driver does not define them:
> .reset
> .set_clock
> .set_bus_width
> .set_uhs_signaling
> 
> So I downgraded to an older v3.14 kernel, and that problem vanished.
> But I am having a problem with the IRQ setup.
> 
> # cat /proc/interrupts 
>             CPU0       CPU1       
>  18:         93          0      irq0   1 Level     serial
>  55:       2832          0      irq0  38 Level     26000.ethernet
>  60:          0          0      irq0  43 Edge      mmc0
> 211:        319       2603       GIC  29 Edge      twd
> 
> Ethernet is using IRQ 38, as specified in the DT.
> mmc0 is supposed to use IRQ 60.
> 
> I see that the mmc0 has the index 60, so I must have messed up between
> the real irq (hwirq?) and the index Linux uses internally (virq?)
> 
> static struct resource sdhci_resources[] = {
> 	{
> 		.start	= TANGOX_SDIO0_BASE_ADDR,
> 		.end	= TANGOX_SDIO0_BASE_ADDR + 0x1ff,
> 		.flags	= IORESOURCE_MEM,
> 	},
> 	{
> 		.start	= 60,	/* SDHCI0 IRQ */
> 		.flags	= IORESOURCE_IRQ,
> 	},
> };
> 
> Both ethernet and sdhci driver call platform_get_irq(pdev, 0);
> but the eth driver is DT, so calls of_irq_get() while sdhci is
> legacy, so calls platform_get_resource() -- IIUC.
> 
> How do I specify a "hwirq" instead of a "Linux index"? and where?

You don't. Either you're using DT all over the place (and the problem is
moot), or you're not using DT at all (and you're left with hardcoding
everything). There is strictly no provision for "mix-and-match", because
that ends up being an intricate (and unmaintainable) mess.

If you want a temporary workaround, have a look at 0fb22a8 ("ARM: OMAP:
Work around hardcoded interrupts"). That will give you an idea of how to
convert one into the other at runtime. It will also give you an insight
as to why you really don't want this in a mainline kernel, and certainly
not on a new platform.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
