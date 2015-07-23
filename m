From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Thu, 23 Jul 2015 13:49:08 +0700
Subject: [RFCv2 PATCH 0/8] Introducing ACPI support for GICv2m
In-Reply-To: <55A9235A.6010505@arm.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <55A9235A.6010505@arm.com>
Message-ID: <55B08E64.1020005@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Sorry for delay reply. Please see my comments below.

On 7/17/15 22:46, Marc Zyngier wrote:
> Hi Suravee,
>
> On 13/07/15 10:14, Suravee Suthikulpanit wrote:
>> ACPI core patches for ARM64 are now upstreamed in 4.1. The PCI support
>> patches for ARM64 ACPI are also in progress. I am sending out this RFC to
>> introduce ACPI support for GICv2m. This would allow MSI to work when
>> booting ACPI.
>>
>> There are some modifications to the irq_domain and acpi/gsi code.
>>
>> Due to a large number of prerequisite patches, I have put together a branch
>> on GitHub for review and testing:
>>
>> 	https://github.com/ssuthiku/linux.git acpi-pci-msi-rfc2
>>
>> This branch has been tested on AMD Seattle Platform. Any feedback and
>> comments are appreciated.
>
> I've had a look at this, and mostly the init_alloc_info method you
> introduce. I have a few issues with the concept:
>
> - The first thing that annoys me a tiny bit is that the bottom irqchip
> (the GIC in your case) is allocating memory on the behalf of all the
> others in the stack, while the actual users are sitting on top. It feels
> really backward. Why can't this allocation be performed at the top of
> the stack? The order of the request goes from top to bottom anyway, so
> what am I missing?

The reason I am allocating struct gic_irq_alloc_info in 
gic_init_irq_alloc_info() is because this structure is specific to GIC, 
and GIC have control of what information it would need to store in this 
structure. The upper levels (ACPI, DT, and GICv2m domains) should not 
need to know about the detail of this structure. They mainly just need 
to keep track of the handle for this structure, and pass it into the 
irq_domain_alloc_irqs().

> - This gic_irq_alloc_info structure is completely GIC specific, and
> contains things that don't make much sense to most domains.

Exactly. Also, I think another benefits is to consolidate the different 
mapping that GIC supports (e.g. SPI, PPI, GSI) used in different places. 
Please refer to patch 2.

> Here, it is
> only useful to the GICv2m driver, but not to the top MSI layer. So why
> should this structure be passed around across domains that don't care?

Actually, this structure is not used just by the GICv2m driver. It's 
also used by the ACPI acpi_register_gsi(), which is also allocating 
interrupts with GSI mapping.

> So I'd like to get back to the intent: why do you need to turn the logic
> around? I understand that of_phandle_args is not ideal for ACPI, and I'm
> happy to find ways around its limitations. But why do we need to reverse
> the allocation logic and make this structure global along the stack,
> rather than keeping it for local interaction at the frontier of two domains?

Please see the explanation above. Let me know if you have other ideas or 
if I am missing your point on the reverse allocation.

Thanks,
Suravee

> Thanks,
>
> 	M.
>
