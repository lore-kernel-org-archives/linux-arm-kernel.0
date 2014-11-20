From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Nov 2014 16:31:45 +0000
Subject: Removal of bus->msi assignment breaks MSI with stacked domains
Message-ID: <546E1771.4030201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn, Yijing,

I've just realized that patch c167caf8d174 (PCI/MSI: Remove useless
bus->msi assignment) completely breaks MSI on arm64 when using the new
MSI stacked domain:

This patch relies on architectures to implement either
pcibios_msi_controller() or arch_setup_msi_irq(). It turns out that with
stacked domains, none of this is actually necessary, as long as you can
access to the msi_controller.

And everything was fine until this patch came around (and managed to
test on a system where the PCI devices are not directly attached to the
root bus). Of course, everything now breaks, as we cannot get to the MSI
controller (which contains the domain we allocate the MSIs from).

In short, this patch breaks an important feature on which arm64 relies,
and I believe this patch should be reverted ASAP.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
