From: arend@broadcom.com (Arend van Spriel)
Date: Thu, 9 Aug 2012 14:09:51 +0200
Subject: How to get the irq flags from the dts file
In-Reply-To: <1344509006.2295.148.camel@tegra-chromium-2>
References: <1344509006.2295.148.camel@tegra-chromium-2>
Message-ID: <5023A88F.8040402@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2012 12:43 PM, Wei Ni wrote:
> Hi, all
> I'm working on tegra wlan upstream issue.
> The tegra board use the Broadcom 4329 as wlan device, and the driver is
> the brcmfmac. 
> 
> This wlan driver support out-band-interrupt (OOB), I want to add DT
> support to use this OOB.
> I can add following lines in the dts file to create platform device and
> pass the interrupt resource to the driver.
> 
> wlan {
>         compatible = "broadcome, brcmf_sdio_pd";

I don't know the DT syntax, but I assume broadcome should be broadcom,
right? ;-)

>         interrupt-parten = <&gpio>;
>         interrupts = <144, 0x04>; /* IRQF_TRIGGER_HIGH */
> };
> 
> In the wlan driver, it will use platform_get_resource() to get the
> res->irq, res->flags, the irq number is right, but the flags will be
> IORESOURCE_IRQ, not the 0x04 (IRQF_TRIGGER_HIGH).
> The wlan driver wish this flags include the IRQF_TRGGER_* information,
> and it will use this flags to configure other hw settings. If it is
> wrong, the wlan can't work.
> 
> I checked drivers/of/irq.c, in function of_irq_to_resource(), it will
> set r->flags = IORESOURCE_IRQ directly, not read the flags from the dtb
> file. And I didn't find any of_xx api to get this flags.
> 
> How can I get this flags, does anyone has suggestion?

I did a quick search in the kernel and there are a number of platform
drivers that seem to expect the IRQF_TRIGGER_* info by using (res->flags
& IRQF_TRIGGER_MASK) and to determine IRQF_SHARED as well.

Gr. AvS
