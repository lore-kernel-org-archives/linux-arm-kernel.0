From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Jul 2015 16:46:34 +0100
Subject: [RFCv2 PATCH 0/8] Introducing ACPI support for GICv2m
In-Reply-To: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <55A9235A.6010505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suravee,

On 13/07/15 10:14, Suravee Suthikulpanit wrote:
> ACPI core patches for ARM64 are now upstreamed in 4.1. The PCI support
> patches for ARM64 ACPI are also in progress. I am sending out this RFC to
> introduce ACPI support for GICv2m. This would allow MSI to work when
> booting ACPI.
> 
> There are some modifications to the irq_domain and acpi/gsi code.
> 
> Due to a large number of prerequisite patches, I have put together a branch
> on GitHub for review and testing:
> 
> 	https://github.com/ssuthiku/linux.git acpi-pci-msi-rfc2
> 
> This branch has been tested on AMD Seattle Platform. Any feedback and
> comments are appreciated.

I've had a look at this, and mostly the init_alloc_info method you
introduce. I have a few issues with the concept:

- The first thing that annoys me a tiny bit is that the bottom irqchip
(the GIC in your case) is allocating memory on the behalf of all the
others in the stack, while the actual users are sitting on top. It feels
really backward. Why can't this allocation be performed at the top of
the stack? The order of the request goes from top to bottom anyway, so
what am I missing?

- This gic_irq_alloc_info structure is completely GIC specific, and
contains things that don't make much sense to most domains. Here, it is
only useful to the GICv2m driver, but not to the top MSI layer. So why
should this structure be passed around across domains that don't care?

So I'd like to get back to the intent: why do you need to turn the logic
around? I understand that of_phandle_args is not ideal for ACPI, and I'm
happy to find ways around its limitations. But why do we need to reverse
the allocation logic and make this structure global along the stack,
rather than keeping it for local interaction at the frontier of two domains?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
