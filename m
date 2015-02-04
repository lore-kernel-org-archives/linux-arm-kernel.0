From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 04 Feb 2015 18:30:21 +0100
Subject: [PATCH 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <1423005775-26457-3-git-send-email-robh@kernel.org> (Rob
 Herring's message of "Tue, 3 Feb 2015 17:22:53 -0600")
References: <1423005775-26457-1-git-send-email-robh@kernel.org>
 <1423005775-26457-3-git-send-email-robh@kernel.org>
Message-ID: <87h9v1a8k2.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

Hi Rob,

> SA1100 and PXA differ only in register offsets which are currently
> hardcoded in a machine specific header. Some arm64 platforms (PXA1928)
> have this RTC block also.
>
> Convert the driver to use ioremap and set the register offsets dynamically.
> Since we are touching all the register accesses, convert them all to
> readl/writel.
A general comment, probably made by Arnd already, why not using the relaxed
accessors ?

... zip ...

> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, iores);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	if (IS_ENABLED(CONFIG_ARCH_SA1100) ||
> +	    of_device_is_compatible(pdev->dev.of_node, "mrvl,sa1100-rtc")) {
> +		info->rcnr = base + 0x04;
> +		info->rtsr = base + 0x10;
> +		info->rtar = base + 0x00;
> +		info->rttr = base + 0x08;
> +	} else {
> +		info->rcnr = base + 0x0;
> +		info->rtsr = base + 0x8;
> +		info->rtar = base + 0x4;
> +		info->rttr = base + 0xc;
> +	}
> +
This is making me feel a bit uncomfortable. What if a single kernel is built for
both SA1100 and PXA, and used in a PXA platform (as this drivers is also used in
pxa2xx and pxa3xx) ?

And just for your information, both rtc-sa1100 and rtc-pxa can be used at the
same time in a pxa kernel.

Apart from that worry it's quite nice.

Cheers.

-- 
Robert
