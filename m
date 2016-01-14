From: msalter@redhat.com (Mark Salter)
Date: Thu, 14 Jan 2016 10:29:53 -0500
Subject: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Message-ID: <1452785393.28109.16.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-01-13 at 14:20 +0100, Tomasz Nowicki wrote:
> From the functionality point of view this series might be split into the
> following logic parts:
> 1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
> ?? PCI config regions and used when necessary.
> 2. Move non-arch specific bits to the core code.
> 3. Use MMCONFIG code and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
> 
> Patches has been built on top of 4.4 and can be found here:
> git at github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
> 
> NOTE, this patch set depends on Matthew's patches:
> http://www.spinics.net/lists/linux-pci/msg45950.html
> https://github.com/Vality/linux/tree/pci-fixes
> 
> This has been tested on Cavium ThunderX server and QEMU.
> Any help in reviewing and testing is very appreciated.
> 
> v2 -> v3
> - fix legacy IRQ assigning and IO ports registration
> - remove reference to arch specific companion device for ia64
> - move ACPI PCI host controller driver to pci_root.c
> - drop generic domain assignment for x86 and ia64 as I am not
> ? able to run all necessary test variants
> - drop patch which cleaned legacy IRQ assignment since it belongs to
> ? Mathew's series:
> ? https://patchwork.ozlabs.org/patch/557504/
> - extend MCFG quirk code
> - rebased to 4.4
> 
> v1 -> v2
> - moved non-arch specific piece of code to dirver/acpi/ directory
> - fixed IO resource handling
> - introduced PCI config accessors quirks matching
> - moved ACPI_COMPANION_SET to generic code

IO resources on Mustang get disabled unless I do:

@@ -126,9 +126,10 @@ static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
????????if (!acpi_dev_resource_len_valid(res->start, res->end, len, true))
????????????????res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
?
+#if 0
????????if (res->end >= 0x10003)
????????????????res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
-
+#endif

res->end is way beyond 0x10003 on Mustang:

? pci_bus 0000:00: root bus resource [io??0x0000-0xffff window] (bus address [0x10000000-0x1000ffff])
