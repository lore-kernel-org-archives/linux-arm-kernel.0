From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 Jun 2016 15:42:26 +0200
Subject: [PATCH 2/3] ARM: mvebu: map PCI I/O regions strongly ordered
In-Reply-To: <1466084547-31343-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1466084547-31343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1466084547-31343-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for HW I/O coherency to work on Cortex-A9 based Marvell SoCs,
all MMIO registers must be mapped strongly ordered. In commit
1c8c3cf0b5239 ("ARM: 8060/1: mm: allow sub-architectures to override PCI
I/O memory type") we implemented a new function,
pci_ioremap_set_mem_type(), that allow sub-architecture code to override
the memory type used to map PCI I/O regions.

In the discussion around this patch series [1], Arnd Bergmann made the
comment that maybe all PCI I/O regions should be mapped
strongly-ordered, which would have made our proposal to add
pci_ioremap_set_mem_type() irrelevant. So, we submitted a patch [2] that
did what Arnd suggested.

However, Russell in the end merged our initial proposal to add
pci_ioremap_set_mem_type(), but it was never used anywhere. Further
discussion with Arnd and other folks on IRC lead to the conclusion that
in fact using strongly-ordered for all platforms was maybe not
desirable, and therefore, using pci_ioremap_set_mem_type() was the most
appropriate solution.

As a consequence, this commit finally adds the
pci_ioremap_set_mem_type() call in the mach-mvebu platform code, which
was originally part of our initial patch series [3] and is necessary for
the whole mechanism to work.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256565.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256755.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256563.html

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 474abff..e80f0dd 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -181,6 +181,7 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
 
 	coherency_cpu_base = of_iomap(np, 0);
 	arch_ioremap_caller = armada_wa_ioremap_caller;
+	pci_ioremap_set_mem_type(MT_UNCACHED);
 
 	/*
 	 * We should switch the PL310 to I/O coherency mode only if
-- 
2.7.4
