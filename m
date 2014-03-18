From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Tue, 18 Mar 2014 09:09:05 +0100
Subject: [PATCH RESEND 1/2] ARM: ixp4xx: Make dma_set_coherent_mask
 common, correct implementation
In-Reply-To: <m3iorcj6nb.fsf@t19.piap.pl>
References: <20140317105448.14bcb617@marrow.netinsight.se>
 <20140317105659.449505d8@marrow.netinsight.se>
 <m3iorcj6nb.fsf@t19.piap.pl>
Message-ID: <20140318090905.72a686e8@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Mar 2014 08:41:12 +0100
Krzysztof Ha?asa <khalasa@piap.pl> wrote:

> Believe it or not, the correct patch is the one I'm attaching. One can
> add extra *set_masks* (e.g. the new call setting both streaming and
> coherent masks) in the drivers, but essentially it must do what this one
> does. Also, converting the mask (in the dev struct) from a pointer to a
> simple value would IMHO make sense, too.

OK, you know the hardware better so if you say so!

> I'm unable to look at this ATM but I will update the patch to the new
> kernel, perhaps soon.

Some comments below though:

>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
>  #include <asm/mach/time.h>
> @@ -578,6 +577,56 @@ void ixp4xx_restart(enum reboot_mode mode, const char *cmd)
>  	}
>  }
>  
> +#ifdef CONFIG_PCI

To me it seems the conditional compilation is superfluous - dev_is_pci
is used to check for PCI-devices anyway, and the compiler should be
smart enough to remove dead code for the non-PCI case.

> +static int ixp4xx_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
> +{
> +	return (dma_addr + size) >= SZ_64M;
> +}
> +
> +static int ixp4xx_platform_notify_remove(struct device *dev)
> +{
> +	if (dev->bus == &pci_bus_type)

if (dev_is_pci(dev))

> +		dmabounce_unregister_dev(dev);
> +
> +	return 0;
> +}

// Simon
