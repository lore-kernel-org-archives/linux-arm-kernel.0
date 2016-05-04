From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 4 May 2016 08:49:55 +0100
Subject: [PATCH 2/2] irqchip/gic-v2m: Add workaround for Broadcom NS2
 GICv2m erratum
In-Reply-To: <1462319245-32532-3-git-send-email-ray.jui@broadcom.com>
References: <1462319245-32532-1-git-send-email-ray.jui@broadcom.com>
 <1462319245-32532-3-git-send-email-ray.jui@broadcom.com>
Message-ID: <5729A9A3.6070207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/16 00:47, Ray Jui wrote:
> Alex Barba <alex.barba@broadcom.com> discovered Broadcom NS2 GICv2m
> implementation has an erratum where the MSI data needs to be the SPI
> number subtracted by an offset of 32, for the correct MSI interrupt to
> be triggered.
> 
> We are aware that APM X-Gene GICv2m has a similar erratum where the
> MSI data needs to be the offset from the spi_start. While APM's workaround
> is triggered based on readings from the MSI_IIDR register, this patch
> contains a more general solution by allowing this offset to be
> specified with an optional DT property 'arm,msi-offset-spi'. This patch
> also maintains compatibility with existing APM platforms

It may be more generic, but it also fails to deal with less capable
firmware implementations. In contrast, reading MSI_IIDR is always
possible (assuming you have a unique ID for this v2m implementation).

If you cannot uniquely identify it using an ID register, the usual
alternative is to have a new "compatible" string identifying the
defective part, and set the offset based on this string. This still
fails the ACPI test, but is the least invasive DT-wise.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
