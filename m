From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 09 Nov 2015 15:40:10 +0000
Subject: Grafting old platform drivers onto a new DT kernel
In-Reply-To: <5640B877.4020108@free.fr> (Mason's message of "Mon, 9 Nov 2015
 16:15:03 +0100")
References: <563B3749.50701@free.fr> <20151105151559.GA16666@lunn.ch>
 <CABxcv=k5mzw_TDsD1eQna9+HY9aqCUd03YAc62750Gs--sMozw@mail.gmail.com>
 <5640B877.4020108@free.fr>
Message-ID: <yw1xtwov5gh1.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

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

The simplest solution for you is probably to add a quick and dirty DT
binding to the old driver.  If it doesn't use any driver-specific
platform data struct, you only need to set .of_match_table in the
struct platform_driver.  If there is a platform data struct, you'll also
need to write some code to populate it from DT properties.  It shouldn't
take more than a few minutes per driver in most cases.

To get those drivers accepted upstream will obviously take a bit more
work.

-- 
M?ns Rullg?rd
mans at mansr.com
