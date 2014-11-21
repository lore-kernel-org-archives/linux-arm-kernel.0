From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 21 Nov 2014 09:22:36 +0800
Subject: Removal of bus->msi assignment breaks MSI with stacked domains
In-Reply-To: <546E1771.4030201@arm.com>
References: <546E1771.4030201@arm.com>
Message-ID: <546E93DC.8010902@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/21 0:31, Marc Zyngier wrote:
> Bjorn, Yijing,
> 
> I've just realized that patch c167caf8d174 (PCI/MSI: Remove useless
> bus->msi assignment) completely breaks MSI on arm64 when using the new
> MSI stacked domain:

Sorry, this is my first part to refactor MSI related code, now
how to get pci msi_controller depends arch functions(pcibios_msi_controller() or
arch_setup_msi_irq()), we are working on generic pci_host_bridge, after that,
we could eventually eliminate MSI arch functions and find pci dev 's msi controller
by pci_host_bridge->get_msi_controller().

Marc, could you tell me what pci host driver in your test platform ?

> 
> This patch relies on architectures to implement either
> pcibios_msi_controller() or arch_setup_msi_irq(). It turns out that with
> stacked domains, none of this is actually necessary, as long as you can
> access to the msi_controller.
> 
> And everything was fine until this patch came around (and managed to
> test on a system where the PCI devices are not directly attached to the
> root bus). Of course, everything now breaks, as we cannot get to the MSI
> controller (which contains the domain we allocate the MSIs from).
> 
> In short, this patch breaks an important feature on which arm64 relies,
> and I believe this patch should be reverted ASAP.

Bjorn, could you help to revert this patch ?


> 
> Thanks,
> 
> 	M.
> 


-- 
Thanks!
Yijing
