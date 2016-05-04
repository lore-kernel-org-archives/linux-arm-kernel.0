From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 4 May 2016 18:25:56 +0100
Subject: [PATCH 2/2] irqchip/gic-v2m: Add workaround for Broadcom NS2
 GICv2m erratum
In-Reply-To: <964ae899-2fd1-baa4-521d-a31326281aa0@broadcom.com>
References: <1462319245-32532-1-git-send-email-ray.jui@broadcom.com>
 <1462319245-32532-3-git-send-email-ray.jui@broadcom.com>
 <5729A9A3.6070207@arm.com>
 <964ae899-2fd1-baa4-521d-a31326281aa0@broadcom.com>
Message-ID: <572A30A4.2060806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ray,

On 04/05/16 17:20, Ray Jui wrote:
> Hi Marc,
> 
> On 5/4/2016 12:49 AM, Marc Zyngier wrote:
>> On 04/05/16 00:47, Ray Jui wrote:
>>> Alex Barba <alex.barba@broadcom.com> discovered Broadcom NS2 GICv2m
>>> implementation has an erratum where the MSI data needs to be the SPI
>>> number subtracted by an offset of 32, for the correct MSI interrupt to
>>> be triggered.
>>>
>>> We are aware that APM X-Gene GICv2m has a similar erratum where the
>>> MSI data needs to be the offset from the spi_start. While APM's workaround
>>> is triggered based on readings from the MSI_IIDR register, this patch
>>> contains a more general solution by allowing this offset to be
>>> specified with an optional DT property 'arm,msi-offset-spi'. This patch
>>> also maintains compatibility with existing APM platforms
>>
>> It may be more generic, but it also fails to deal with less capable
>> firmware implementations. In contrast, reading MSI_IIDR is always
>> possible (assuming you have a unique ID for this v2m implementation).
>>
>> If you cannot uniquely identify it using an ID register, the usual
>> alternative is to have a new "compatible" string identifying the
>> defective part, and set the offset based on this string. This still
>> fails the ACPI test, but is the least invasive DT-wise.
> 
> Okay. We do seem to have an ID. The JEP code looks a bit weird as the 
> IIDR register reads 0x13f. We were just a bit concerned that there's 

Ah, people get creative sometimes...

> another chip from Broadcom that may happen to have the same ID but may 
> already have this offset issue fixed (or made worse with a different 
> offset, :) ). Since that chip has not even taped out yet, we can wait 
> till later to confirm. If a compatible string is needed in the future, 
> we'll add that.

OK. It'd be good to make sure that this ID register is changed. I don't
mind handling a different ID for the same quirk, but being unable to
distinguish a quirky part from a fixed one would be pretty dumb.

> For now, I'm going to submit another patch to deal with this offset 
> based on IIDR reading 0x13f.

Sounds good.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
